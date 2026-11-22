import 'package:drift/drift.dart';

import '../core/money.dart';
import '../core/permissions.dart';
import '../core/units.dart';
import '../data/database.dart';
import 'audit_service.dart';
import 'inventory_service.dart';
import 'party_service.dart';
import 'shift_service.dart';

/// سطر في سلة البيع
class CartLine {
  final Medicine medicine;
  SaleUnit unit;
  int quantity;

  CartLine(this.medicine, {this.unit = SaleUnit.box, this.quantity = 1});

  int get baseQuantity => medicine.basePer(unit) * quantity;
  double get unitPriceUsd => medicine.priceUsdFor(unit);
  double unitPriceSyp(double rate, RoundingConfig r) => usdToSyp(unitPriceUsd, rate, r);
  double totalSyp(double rate, RoundingConfig r) => roundTo(unitPriceSyp(rate, r) * quantity, 2);
}

class PaymentInput {
  final double discountSyp;
  final double paidSyp;
  final double paidUsd;
  final Customer? customer;
  final String? note;

  const PaymentInput({this.discountSyp = 0, this.paidSyp = 0, this.paidUsd = 0, this.customer, this.note});
}

/// حساب إجماليات الفاتورة (يُستخدم في الواجهة وعند الحفظ)
class CheckoutTotals {
  final double subtotalSyp;
  final double discountSyp;
  final double totalSyp;
  final double paidTotalSyp;
  final double changeSyp;
  final double debtSyp;

  CheckoutTotals._(this.subtotalSyp, this.discountSyp, this.totalSyp, this.paidTotalSyp, this.changeSyp, this.debtSyp);

  factory CheckoutTotals.compute({
    required List<CartLine> lines,
    required double rate,
    required RoundingConfig rounding,
    double discountSyp = 0,
    double paidSyp = 0,
    double paidUsd = 0,
  }) {
    final sub = roundTo(lines.fold<double>(0, (s, l) => s + l.totalSyp(rate, rounding)), 2);
    final disc = discountSyp.clamp(0, sub).toDouble();
    final total = roundTo(sub - disc, 2);
    final paid = roundTo(paidSyp + paidUsd * rate, 2);
    final change = paid > total ? roundTo(paid - total, 2) : 0.0;
    final debt = paid < total ? roundTo(total - paid, 2) : 0.0;
    return CheckoutTotals._(sub, disc, total, paid, change, debt);
  }
}

class SaleDetails {
  final Sale sale;
  final List<SaleItem> items;
  final User? user;
  final Customer? customer;
  SaleDetails(this.sale, this.items, this.user, this.customer);
}

class SalesService {
  final AppDatabase db;
  final AuditService audit;
  final InventoryService inventory;
  final ShiftService shifts;
  final CustomerService customers;

  SalesService(this.db, this.audit, this.inventory, this.shifts, this.customers);

  Future<SaleDetails> checkout({
    required User actor,
    required Shift shift,
    required List<CartLine> lines,
    required PaymentInput payment,
    required double rate,
    required RoundingConfig rounding,
  }) async {
    if (shift.status != 'open') throw BusinessException('الوردية مغلقة، افتح وردية جديدة');
    if (rate <= 0) throw BusinessException('يرجى تحديد سعر صرف الدولار من الإعدادات');
    final active = lines.where((l) => l.quantity > 0).toList();
    if (active.isEmpty) throw BusinessException('الفاتورة فارغة');
    if (payment.paidSyp < 0 || payment.paidUsd < 0 || payment.discountSyp < 0) {
      throw BusinessException('قيم غير صحيحة');
    }
    if (payment.discountSyp > 0 && !actor.can(Permission.giveDiscount)) {
      throw PermissionDenied(Permission.giveDiscount);
    }
    final t = CheckoutTotals.compute(
      lines: active,
      rate: rate,
      rounding: rounding,
      discountSyp: payment.discountSyp,
      paidSyp: payment.paidSyp,
      paidUsd: payment.paidUsd,
    );
    if (payment.discountSyp > t.subtotalSyp) {
      throw BusinessException('الخصم أكبر من قيمة الفاتورة');
    }
    final customer = payment.customer;
    if (t.debtSyp > 0) {
      if (customer == null) {
        throw BusinessException('المبلغ المدفوع أقل من الإجمالي. اختر زبوناً لتسجيل الباقي ديناً عليه');
      }
      if (!actor.can(Permission.sellOnCredit)) throw PermissionDenied(Permission.sellOnCredit);
      if (customer.creditLimitUsd != null && customer.creditLimitUsd! > 0) {
        final bal = await customers.balanceUsd(customer.id);
        final newDebt = bal + sypToUsd(t.debtSyp, rate);
        if (newDebt > customer.creditLimitUsd! + 0.0001) {
          throw BusinessException(
            'تجاوز سقف الدين للزبون (${fmtUsd(customer.creditLimitUsd!)}). الدين الحالي ${fmtUsd(bal)}',
          );
        }
      }
    }

    final saleId = await db.transaction(() async {
      double totalCost = 0;
      final prepared = <(CartLine, List<Allocation>, double)>[];
      for (final l in active) {
        final List<Allocation> alloc;
        try {
          alloc = await inventory.allocate(l.medicine.id, l.baseQuantity);
        } on InsufficientStock catch (e) {
          throw BusinessException(
            'الكمية غير كافية من "${l.medicine.name}". المتوفر: ${l.medicine.describeQty(e.available)}',
          );
        }
        double cost = 0;
        for (final a in alloc) {
          await inventory.changeBatchQty(a.batch.id, -a.quantity);
          cost += l.medicine.costOf(a.quantity, a.batch.costUsdPerBox);
        }
        totalCost += cost;
        prepared.add((l, alloc, cost));
      }

      final id = await db
          .into(db.sales)
          .insert(
            SalesCompanion.insert(
              shiftId: shift.id,
              userId: actor.id,
              customerId: Value(customer?.id),
              rate: rate,
              subtotalSyp: t.subtotalSyp,
              discountSyp: Value(t.discountSyp),
              totalSyp: t.totalSyp,
              totalUsd: sypToUsd(t.totalSyp, rate),
              costUsd: Value(roundTo(totalCost, 6)),
              paidSyp: Value(payment.paidSyp),
              paidUsd: Value(payment.paidUsd),
              changeSyp: Value(t.changeSyp),
              debtSyp: Value(t.debtSyp),
              note: Value(payment.note),
            ),
          );

      for (final (l, alloc, cost) in prepared) {
        final itemId = await db
            .into(db.saleItems)
            .insert(
              SaleItemsCompanion.insert(
                saleId: id,
                medicineId: l.medicine.id,
                medicineName: l.medicine.name,
                unit: l.unit.index,
                unitLabel: l.medicine.unitLabel(l.unit),
                quantity: l.quantity,
                baseQuantity: l.baseQuantity,
                unitPriceUsd: l.unitPriceUsd,
                unitPriceSyp: l.unitPriceSyp(rate, rounding),
                totalSyp: l.totalSyp(rate, rounding),
                costUsd: roundTo(cost, 6),
              ),
            );
        for (final a in alloc) {
          await db
              .into(db.saleItemBatches)
              .insert(
                SaleItemBatchesCompanion.insert(
                  saleItemId: itemId,
                  batchId: a.batch.id,
                  baseQuantity: a.quantity,
                  costUsd: l.medicine.costOf(a.quantity, a.batch.costUsdPerBox),
                ),
              );
        }
      }

      // حركات الدرج
      if (payment.paidSyp > 0) {
        await shifts.addMovementRaw(shift.id, actor.id, CashTypes.sale, currencySyp, payment.paidSyp, refId: id);
      }
      if (payment.paidUsd > 0) {
        await shifts.addMovementRaw(shift.id, actor.id, CashTypes.sale, currencyUsd, payment.paidUsd, refId: id);
      }
      if (t.changeSyp > 0) {
        await shifts.addMovementRaw(shift.id, actor.id, CashTypes.change, currencySyp, -t.changeSyp, refId: id);
      }
      if (t.debtSyp > 0 && customer != null) {
        await customers.addTransaction(
          customerId: customer.id,
          type: 'sale',
          amountUsd: sypToUsd(t.debtSyp, rate),
          currency: currencySyp,
          originalAmount: t.debtSyp,
          rate: rate,
          refId: id,
          shiftId: shift.id,
          userId: actor.id,
          note: 'فاتورة رقم $id',
        );
      }
      await audit.log(
        actor,
        AuditActions.saleCompleted,
        entity: 'sale',
        entityId: id,
        details: {
          'total': t.totalSyp,
          'items': active.length,
          if (t.discountSyp > 0) 'discount': t.discountSyp,
          if (t.debtSyp > 0) 'debt': t.debtSyp,
          if (customer != null) 'customer': customer.name,
        },
      );
      return id;
    });
    return (await details(saleId))!;
  }

  Future<SaleDetails?> details(int saleId) async {
    final s = await (db.select(db.sales)..where((t) => t.id.equals(saleId))).getSingleOrNull();
    if (s == null) return null;
    final items =
        await (db.select(db.saleItems)
              ..where((t) => t.saleId.equals(saleId))
              ..orderBy([(t) => OrderingTerm.asc(t.id)]))
            .get();
    final u = await (db.select(db.users)..where((t) => t.id.equals(s.userId))).getSingleOrNull();
    final c = s.customerId == null ? null : await customers.byId(s.customerId!);
    return SaleDetails(s, items, u, c);
  }

  Future<List<Sale>> list({
    DateTime? from,
    DateTime? to,
    int? userId,
    int? shiftId,
    int? customerId,
    String? status,
    int limit = 500,
  }) {
    final q = db.select(db.sales);
    q.where((t) {
      Expression<bool> e = const Constant(true);
      if (from != null) e = e & t.createdAt.isBiggerOrEqualValue(from);
      if (to != null) e = e & t.createdAt.isSmallerThanValue(to);
      if (userId != null) e = e & t.userId.equals(userId);
      if (shiftId != null) e = e & t.shiftId.equals(shiftId);
      if (customerId != null) e = e & t.customerId.equals(customerId);
      if (status != null) e = e & t.status.equals(status);
      return e;
    });
    q.orderBy([(t) => OrderingTerm.desc(t.id)]);
    q.limit(limit);
    return q.get();
  }

  /// إلغاء فاتورة: إرجاع الكميات للمخزون وإعادة المبلغ من درج المستخدم الحالي
  Future<void> voidSale({
    required User actor,
    required Shift currentShift,
    required Sale sale,
    required String reason,
  }) async {
    if (!actor.can(Permission.voidSales)) throw PermissionDenied(Permission.voidSales);
    if (sale.status != 'completed') throw BusinessException('الفاتورة ملغاة مسبقاً');
    if (reason.trim().isEmpty) throw BusinessException('يرجى كتابة سبب الإلغاء');
    final returned = await db
        .customSelect(
          'SELECT COUNT(*) AS c FROM customer_returns WHERE sale_id = ?',
          variables: [Variable.withInt(sale.id)],
          readsFrom: {db.customerReturns},
        )
        .getSingle();
    if (returned.read<int>('c') > 0) {
      throw BusinessException('لا يمكن إلغاء فاتورة عليها مرتجعات. استخدم المرتجع للكمية المتبقية');
    }
    await db.transaction(() async {
      final items = await (db.select(db.saleItems)..where((t) => t.saleId.equals(sale.id))).get();
      for (final it in items) {
        final allocs = await (db.select(db.saleItemBatches)..where((t) => t.saleItemId.equals(it.id))).get();
        for (final a in allocs) {
          await inventory.changeBatchQty(a.batchId, a.baseQuantity - a.returnedBase);
        }
      }
      if (sale.paidSyp > 0) {
        await shifts.addMovementRaw(
          currentShift.id,
          actor.id,
          CashTypes.voidSale,
          currencySyp,
          -sale.paidSyp,
          refId: sale.id,
        );
      }
      if (sale.paidUsd > 0) {
        await shifts.addMovementRaw(
          currentShift.id,
          actor.id,
          CashTypes.voidSale,
          currencyUsd,
          -sale.paidUsd,
          refId: sale.id,
        );
      }
      if (sale.changeSyp > 0) {
        await shifts.addMovementRaw(
          currentShift.id,
          actor.id,
          CashTypes.voidSale,
          currencySyp,
          sale.changeSyp,
          refId: sale.id,
        );
      }
      if (sale.debtSyp > 0 && sale.customerId != null) {
        await customers.addTransaction(
          customerId: sale.customerId!,
          type: 'void',
          amountUsd: -sypToUsd(sale.debtSyp, sale.rate),
          currency: currencySyp,
          originalAmount: -sale.debtSyp,
          rate: sale.rate,
          refId: sale.id,
          shiftId: currentShift.id,
          userId: actor.id,
          note: 'إلغاء فاتورة رقم ${sale.id}',
        );
      }
      await (db.update(db.sales)..where((t) => t.id.equals(sale.id))).write(
        SalesCompanion(
          status: const Value('voided'),
          voidedById: Value(actor.id),
          voidedAt: Value(DateTime.now()),
          voidReason: Value(reason.trim()),
        ),
      );
      await audit.log(
        actor,
        AuditActions.saleVoided,
        entity: 'sale',
        entityId: sale.id,
        details: {'total': sale.totalSyp, 'reason': reason.trim()},
      );
    });
  }
}
