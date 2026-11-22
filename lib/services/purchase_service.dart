import 'package:drift/drift.dart';

import '../core/money.dart';
import '../core/permissions.dart';
import '../core/units.dart';
import '../data/database.dart';
import 'audit_service.dart';
import 'inventory_service.dart';
import 'party_service.dart';
import 'shift_service.dart';

/// سطر في فاتورة شراء
class PurchaseLine {
  final Medicine medicine;
  int quantityBoxes;
  int bonusBoxes;
  double costUsdPerBox;
  String? batchNumber;
  DateTime? expiryDate;

  /// سعر بيع جديد للعلبة (اختياري)
  double? newPriceUsd;

  PurchaseLine(
    this.medicine, {
    this.quantityBoxes = 1,
    this.bonusBoxes = 0,
    this.costUsdPerBox = 0,
    this.batchNumber,
    this.expiryDate,
    this.newPriceUsd,
  });

  double get totalUsd => roundTo(quantityBoxes * costUsdPerBox, 4);
}

class PurchaseDetails {
  final Purchase purchase;
  final Supplier supplier;
  final List<(PurchaseItem, Medicine)> items;
  PurchaseDetails(this.purchase, this.supplier, this.items);
}

class PurchaseService {
  final AppDatabase db;
  final AuditService audit;
  final InventoryService inventory;
  final SupplierService suppliers;
  final ShiftService shifts;

  PurchaseService(this.db, this.audit, this.inventory, this.suppliers, this.shifts);

  /// حفظ فاتورة شراء: إضافة الدفعات للمخزون وتسجيل الدين للمورد
  Future<Purchase> create({
    required User actor,
    required Supplier supplier,
    required List<PurchaseLine> lines,
    String? invoiceNumber,
    DateTime? invoiceDate,
    double discountUsd = 0,
    double paidAmount = 0,
    String paidCurrency = currencyUsd,
    double rate = 0,
    Shift? payFromShift,
    String? notes,
  }) async {
    if (!actor.can(Permission.managePurchases)) throw PermissionDenied(Permission.managePurchases);
    final valid = lines.where((l) => l.quantityBoxes + l.bonusBoxes > 0).toList();
    if (valid.isEmpty) throw BusinessException('الفاتورة فارغة');
    for (final l in valid) {
      if (l.costUsdPerBox < 0 || l.quantityBoxes < 0 || l.bonusBoxes < 0) {
        throw BusinessException('قيم غير صحيحة في "${l.medicine.name}"');
      }
      if (l.newPriceUsd != null && l.newPriceUsd != l.medicine.priceUsd && !actor.can(Permission.editPrices)) {
        throw PermissionDenied(Permission.editPrices);
      }
    }
    final gross = roundTo(valid.fold<double>(0, (s, l) => s + l.totalUsd), 4);
    if (discountUsd < 0 || discountUsd > gross) throw BusinessException('الخصم غير صحيح');
    final net = roundTo(gross - discountUsd, 4);
    final discountRatio = gross > 0 ? discountUsd / gross : 0.0;

    final purchaseId = await db.transaction(() async {
      final id = await db
          .into(db.purchases)
          .insert(
            PurchasesCompanion.insert(
              supplierId: supplier.id,
              invoiceNumber: Value(invoiceNumber?.trim().isEmpty == true ? null : invoiceNumber?.trim()),
              invoiceDate: invoiceDate ?? DateTime.now(),
              totalUsd: net,
              discountUsd: Value(discountUsd),
              notes: Value(notes),
              userId: Value(actor.id),
            ),
          );
      for (final l in valid) {
        final totalBoxes = l.quantityBoxes + l.bonusBoxes;
        // التكلفة الفعلية للعلبة بعد البونص والخصم
        final effCost = totalBoxes == 0
            ? 0.0
            : roundTo(l.quantityBoxes * l.costUsdPerBox * (1 - discountRatio) / totalBoxes, 6);
        final batch = await inventory.addBatch(
          actor: actor,
          medicine: l.medicine,
          baseQuantity: totalBoxes * l.medicine.basePerBox,
          expiryDate: l.expiryDate,
          batchNumber: l.batchNumber,
          costUsdPerBox: effCost,
          supplierId: supplier.id,
          purchaseId: id,
          logAudit: false,
        );
        await db
            .into(db.purchaseItems)
            .insert(
              PurchaseItemsCompanion.insert(
                purchaseId: id,
                medicineId: l.medicine.id,
                batchId: Value(batch.id),
                quantityBoxes: l.quantityBoxes,
                bonusBoxes: Value(l.bonusBoxes),
                costUsdPerBox: l.costUsdPerBox,
                batchNumber: Value(l.batchNumber),
                expiryDate: Value(l.expiryDate),
                totalUsd: l.totalUsd,
              ),
            );
        if (l.newPriceUsd != null && l.newPriceUsd! > 0 && l.newPriceUsd != l.medicine.priceUsd) {
          await inventory.saveMedicine(
            actor: actor,
            existing: l.medicine,
            data: MedicinesCompanion(priceUsd: Value(l.newPriceUsd!)),
          );
        }
      }
      await suppliers.addTransaction(
        supplierId: supplier.id,
        type: 'purchase',
        amountUsd: net,
        originalAmount: net,
        refId: id,
        userId: actor.id,
        note: invoiceNumber == null || invoiceNumber.isEmpty ? 'فاتورة شراء #$id' : 'فاتورة $invoiceNumber',
      );
      await audit.log(
        actor,
        AuditActions.purchaseCreated,
        entity: 'purchase',
        entityId: id,
        details: {'supplier': supplier.name, 'total': net, 'items': valid.length, 'invoice': invoiceNumber},
      );
      if (paidAmount > 0) {
        await suppliers.pay(
          actor: actor,
          supplier: supplier,
          currency: paidCurrency,
          amount: paidAmount,
          rate: rate,
          fromShift: payFromShift,
          note: 'دفعة مع فاتورة الشراء #$id',
          purchaseId: id,
        );
        final paidUsd = paidCurrency == currencyUsd ? paidAmount : sypToUsd(paidAmount, rate);
        await (db.update(
          db.purchases,
        )..where((t) => t.id.equals(id))).write(PurchasesCompanion(paidUsd: Value(paidUsd)));
      }
      return id;
    });
    return (db.select(db.purchases)..where((t) => t.id.equals(purchaseId))).getSingle();
  }

  Future<List<(Purchase, Supplier)>> list({int? supplierId, DateTime? from, DateTime? to, int limit = 300}) async {
    final q = db.select(db.purchases).join([
      innerJoin(db.suppliers, db.suppliers.id.equalsExp(db.purchases.supplierId)),
    ]);
    Expression<bool> e = const Constant(true);
    if (supplierId != null) e = e & db.purchases.supplierId.equals(supplierId);
    if (from != null) e = e & db.purchases.invoiceDate.isBiggerOrEqualValue(from);
    if (to != null) e = e & db.purchases.invoiceDate.isSmallerThanValue(to);
    q.where(e);
    q.orderBy([OrderingTerm.desc(db.purchases.id)]);
    q.limit(limit);
    final rows = await q.get();
    return rows.map((r) => (r.readTable(db.purchases), r.readTable(db.suppliers))).toList();
  }

  Future<PurchaseDetails?> details(int id) async {
    final p = await (db.select(db.purchases)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (p == null) return null;
    final s = (await suppliers.byId(p.supplierId))!;
    final q = db.select(db.purchaseItems).join([
      innerJoin(db.medicines, db.medicines.id.equalsExp(db.purchaseItems.medicineId)),
    ])..where(db.purchaseItems.purchaseId.equals(id));
    final rows = await q.get();
    return PurchaseDetails(p, s, rows.map((r) => (r.readTable(db.purchaseItems), r.readTable(db.medicines))).toList());
  }
}
