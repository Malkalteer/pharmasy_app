import 'package:drift/drift.dart';

import '../core/money.dart';
import '../core/permissions.dart';
import '../core/units.dart';
import '../data/database.dart';
import 'audit_service.dart';
import 'inventory_service.dart';
import 'party_service.dart';
import 'shift_service.dart';

/// سطر مرتجع من زبون: كمية (بوحدة البيع الأصلية) من سطر فاتورة
class CustomerReturnLine {
  final SaleItem item;
  final int quantity;
  final bool restock;
  CustomerReturnLine(this.item, this.quantity, {this.restock = true});
}

/// سطر مرتجع إلى مورد: كمية بأصغر وحدة من دفعة
class SupplierReturnLine {
  final StockBatch batch;
  final Medicine medicine;
  final int baseQuantity;
  SupplierReturnLine(this.batch, this.medicine, this.baseQuantity);

  double get amountUsd => medicine.costOf(baseQuantity, batch.costUsdPerBox);
}

class ReturnsService {
  final AppDatabase db;
  final AuditService audit;
  final InventoryService inventory;
  final ShiftService shifts;
  final CustomerService customers;
  final SupplierService suppliers;

  ReturnsService(this.db, this.audit, this.inventory, this.shifts, this.customers, this.suppliers);

  /// قيمة المرتجع لسطر معيّن (مع توزيع خصم الفاتورة تناسبياً)
  static double lineRefund(Sale sale, SaleItem item, int quantity) {
    if (item.quantity == 0) return 0;
    final ratio = sale.subtotalSyp > 0 ? sale.totalSyp / sale.subtotalSyp : 1.0;
    return roundTo(item.totalSyp * quantity / item.quantity * ratio, 2);
  }

  /// الكمية المتبقية القابلة للإرجاع (بوحدة البيع)
  static int returnableQty(SaleItem item) {
    final perUnit = item.quantity == 0 ? 1 : item.baseQuantity ~/ item.quantity;
    return (item.baseQuantity - item.returnedBase) ~/ (perUnit == 0 ? 1 : perUnit);
  }

  /// مرتجع من زبون على فاتورة. إذا كانت الفاتورة عليها دين، يُخصم من الدين أولاً.
  Future<CustomerReturn> customerReturn({
    required User actor,
    required Shift shift,
    required Sale sale,
    required List<CustomerReturnLine> lines,
    String? note,
  }) async {
    if (!actor.can(Permission.returns)) throw PermissionDenied(Permission.returns);
    if (sale.status != 'completed') throw BusinessException('الفاتورة ملغاة');
    if (shift.status != 'open') throw BusinessException('الوردية مغلقة');
    final valid = lines.where((l) => l.quantity > 0).toList();
    if (valid.isEmpty) throw BusinessException('لم يتم تحديد أي كمية للإرجاع');

    final id = await db.transaction(() async {
      double total = 0;
      double cost = 0;
      final prepared = <(CustomerReturnLine, int, double)>[];
      for (final l in valid) {
        final fresh = await (db.select(db.saleItems)..where((t) => t.id.equals(l.item.id))).getSingle();
        if (l.quantity > returnableQty(fresh)) {
          throw BusinessException('الكمية المرتجعة من "${fresh.medicineName}" أكبر من المباعة');
        }
        final base = fresh.baseQuantity ~/ fresh.quantity * l.quantity;
        final amount = lineRefund(sale, fresh, l.quantity);
        total += amount;
        prepared.add((l, base, amount));
      }
      total = roundTo(total, 2);

      // الدين المتبقي على هذه الفاتورة
      double debtReduce = 0;
      if (sale.customerId != null && sale.debtSyp > 0) {
        final already = await db
            .customSelect(
              'SELECT COALESCE(SUM(debt_reduced_syp),0) AS s FROM customer_returns WHERE sale_id = ?',
              variables: [Variable.withInt(sale.id)],
              readsFrom: {db.customerReturns},
            )
            .getSingle();
        final remainingDebt = sale.debtSyp - already.read<double>('s');
        debtReduce = remainingDebt > 0 ? (total < remainingDebt ? total : remainingDebt) : 0;
      }
      final refund = roundTo(total - debtReduce, 2);

      final rid = await db
          .into(db.customerReturns)
          .insert(
            CustomerReturnsCompanion.insert(
              saleId: sale.id,
              customerId: Value(sale.customerId),
              shiftId: shift.id,
              userId: actor.id,
              rate: sale.rate,
              totalSyp: total,
              refundSyp: Value(refund),
              debtReducedSyp: Value(roundTo(debtReduce, 2)),
              note: Value(note),
            ),
          );

      for (final (l, base, amount) in prepared) {
        // إرجاع الكمية للدفعات الأصلية
        var remaining = base;
        final allocs =
            await (db.select(db.saleItemBatches)
                  ..where((t) => t.saleItemId.equals(l.item.id))
                  ..orderBy([(t) => OrderingTerm.desc(t.id)]))
                .get();
        for (final a in allocs) {
          if (remaining <= 0) break;
          final can = a.baseQuantity - a.returnedBase;
          if (can <= 0) continue;
          final take = can < remaining ? can : remaining;
          if (l.restock) await inventory.changeBatchQty(a.batchId, take);
          cost += a.costUsd * take / a.baseQuantity;
          await (db.update(db.saleItemBatches)..where((t) => t.id.equals(a.id))).write(
            SaleItemBatchesCompanion(returnedBase: Value(a.returnedBase + take)),
          );
          remaining -= take;
        }
        await db.customUpdate(
          'UPDATE sale_items SET returned_base = returned_base + ? WHERE id = ?',
          variables: [Variable.withInt(base), Variable.withInt(l.item.id)],
          updates: {db.saleItems},
        );
        await db
            .into(db.customerReturnItems)
            .insert(
              CustomerReturnItemsCompanion.insert(
                returnId: rid,
                saleItemId: l.item.id,
                medicineId: l.item.medicineId,
                baseQuantity: base,
                amountSyp: amount,
                restocked: Value(l.restock),
              ),
            );
      }
      await (db.update(
        db.customerReturns,
      )..where((t) => t.id.equals(rid))).write(CustomerReturnsCompanion(costUsd: Value(roundTo(cost, 6))));

      if (refund > 0) {
        await shifts.addMovementRaw(shift.id, actor.id, CashTypes.refund, currencySyp, -refund, refId: rid);
      }
      if (debtReduce > 0) {
        await customers.addTransaction(
          customerId: sale.customerId!,
          type: 'return',
          amountUsd: -sypToUsd(debtReduce, sale.rate),
          currency: currencySyp,
          originalAmount: -debtReduce,
          rate: sale.rate,
          refId: rid,
          shiftId: shift.id,
          userId: actor.id,
          note: 'مرتجع على فاتورة ${sale.id}',
        );
      }
      await audit.log(
        actor,
        AuditActions.customerReturn,
        entity: 'sale',
        entityId: sale.id,
        details: {'total': total, 'refund': refund, 'debtReduced': debtReduce},
      );
      return rid;
    });
    return (db.select(db.customerReturns)..where((t) => t.id.equals(id))).getSingle();
  }

  /// مرتجع إلى مورد (منتهي، تالف، زائد...)
  Future<SupplierReturn> supplierReturn({
    required User actor,
    required Supplier supplier,
    required List<SupplierReturnLine> lines,

    /// credit = خصم من دين المورد، cash = استلام المبلغ نقداً في الدرج
    required String settlement,
    Shift? shift,
    String cashCurrency = currencyUsd,
    double rate = 0,
    String? note,
  }) async {
    if (!actor.can(Permission.managePurchases)) throw PermissionDenied(Permission.managePurchases);
    final valid = lines.where((l) => l.baseQuantity > 0).toList();
    if (valid.isEmpty) throw BusinessException('لم يتم تحديد أي كمية');
    if (settlement == 'cash' && shift == null) throw BusinessException('يجب فتح وردية لاستلام المبلغ');
    final id = await db.transaction(() async {
      double total = 0;
      for (final l in valid) {
        final fresh = await (db.select(db.batches)..where((t) => t.id.equals(l.batch.id))).getSingle();
        if (l.baseQuantity > fresh.quantity) {
          throw BusinessException('الكمية أكبر من المتوفر في الدفعة (${l.medicine.name})');
        }
        total += l.amountUsd;
      }
      total = roundTo(total, 4);
      final rid = await db
          .into(db.supplierReturns)
          .insert(
            SupplierReturnsCompanion.insert(
              supplierId: supplier.id,
              userId: Value(actor.id),
              totalUsd: total,
              settlement: settlement,
              note: Value(note),
            ),
          );
      for (final l in valid) {
        await inventory.changeBatchQty(l.batch.id, -l.baseQuantity);
        await db
            .into(db.supplierReturnItems)
            .insert(
              SupplierReturnItemsCompanion.insert(
                returnId: rid,
                batchId: l.batch.id,
                medicineId: l.medicine.id,
                baseQuantity: l.baseQuantity,
                amountUsd: l.amountUsd,
              ),
            );
      }
      if (settlement == 'credit') {
        await suppliers.addTransaction(
          supplierId: supplier.id,
          type: 'return',
          amountUsd: -total,
          originalAmount: total,
          refId: rid,
          userId: actor.id,
          note: 'مرتجع #$rid',
        );
      } else {
        final amount = cashCurrency == currencyUsd ? total : usdToSyp(total, rate, const RoundingConfig(step: 1));
        await shifts.addMovementRaw(
          shift!.id,
          actor.id,
          CashTypes.supplierReturn,
          cashCurrency,
          amount,
          refId: rid,
          note: supplier.name,
        );
      }
      await audit.log(
        actor,
        AuditActions.supplierReturn,
        entity: 'supplier',
        entityId: supplier.id,
        details: {'name': supplier.name, 'totalUsd': total, 'settlement': settlement},
      );
      return rid;
    });
    return (db.select(db.supplierReturns)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<List<CustomerReturn>> customerReturnsOf(int saleId) =>
      (db.select(db.customerReturns)..where((t) => t.saleId.equals(saleId))).get();
}
