import 'package:drift/drift.dart';

import '../core/permissions.dart';
import '../core/units.dart';
import '../data/database.dart';
import 'audit_service.dart';

/// دواء مع ملخص المخزون
class MedicineStock {
  final Medicine medicine;

  /// إجمالي الكمية الصالحة (غير المنتهية) بأصغر وحدة
  final int available;

  /// الكمية المنتهية الصلاحية بأصغر وحدة
  final int expired;
  final DateTime? nearestExpiry;

  MedicineStock(this.medicine, this.available, this.expired, this.nearestExpiry);

  bool get isLow =>
      medicine.minStockBoxes > 0 &&
      available < medicine.minStockBoxes * medicine.basePerBox;

  /// الكمية الناقصة حتى الوصول للحد الأدنى (بالعلب)
  double get shortageBoxes {
    final need = medicine.minStockBoxes - medicine.boxesOf(available);
    return need > 0 ? need : 0;
  }
}

class BatchWithMedicine {
  final StockBatch batch;
  final Medicine medicine;
  BatchWithMedicine(this.batch, this.medicine);
}

class Allocation {
  final StockBatch batch;
  final int quantity;
  Allocation(this.batch, this.quantity);
}

DateTime _today() {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day);
}

class InventoryService {
  final AppDatabase db;
  final AuditService audit;

  InventoryService(this.db, this.audit);

  Future<List<MedicineStock>> listWithStock({
    String? search,
    bool includeInactive = false,
    int? limit,
    List<int>? ids,
  }) async {
    final today = _today();
    final where = <String>[];
    final vars = <Variable>[
      Variable.withDateTime(today),
      Variable.withDateTime(today),
    ];
    if (!includeInactive) where.add('m.active = 1');
    if (ids != null) {
      if (ids.isEmpty) return [];
      where.add('m.id IN (${ids.join(',')})');
    }
    if (search != null && search.trim().isNotEmpty) {
      final s = '%${search.trim()}%';
      where.add(
          '(m.name LIKE ? OR m.scientific_name LIKE ? OR m.manufacturer LIKE ? OR m.barcode = ?)');
      vars.addAll([
        Variable.withString(s),
        Variable.withString(s),
        Variable.withString(s),
        Variable.withString(search.trim()),
      ]);
    }
    final sql = '''
SELECT m.*,
  COALESCE(SUM(CASE WHEN b.expiry_date IS NULL OR b.expiry_date >= ? THEN b.quantity ELSE 0 END), 0) AS avail,
  COALESCE(SUM(CASE WHEN b.expiry_date IS NOT NULL AND b.expiry_date < ? THEN b.quantity ELSE 0 END), 0) AS expired_qty,
  MIN(CASE WHEN b.quantity > 0 THEN b.expiry_date END) AS nearest
FROM medicines m
LEFT JOIN batches b ON b.medicine_id = m.id
${where.isEmpty ? '' : 'WHERE ${where.join(' AND ')}'}
GROUP BY m.id
ORDER BY m.name COLLATE NOCASE
${limit != null ? 'LIMIT $limit' : ''}
''';
    final rows = await db
        .customSelect(sql,
            variables: vars, readsFrom: {db.medicines, db.batches})
        .get();
    return rows.map((r) {
      final m = db.medicines.map(r.data);
      final nearestRaw = r.data['nearest'];
      DateTime? nearest;
      if (nearestRaw is int) {
        nearest = DateTime.fromMillisecondsSinceEpoch(nearestRaw * 1000);
      }
      return MedicineStock(
        m,
        r.read<int>('avail'),
        r.read<int>('expired_qty'),
        nearest,
      );
    }).toList();
  }

  Future<MedicineStock?> stockOf(int medicineId) async {
    final l = await listWithStock(ids: [medicineId], includeInactive: true);
    return l.firstOrNull;
  }

  Future<Medicine?> byId(int id) =>
      (db.select(db.medicines)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<Medicine?> byBarcode(String code) {
    final c = code.trim();
    return (db.select(db.medicines)
          ..where((t) => t.barcode.equals(c) & t.active.equals(true)))
        .getSingleOrNull();
  }

  Future<List<String>> distinctValues(String column) async {
    final rows = await db.customSelect(
      'SELECT DISTINCT $column AS v FROM medicines WHERE $column IS NOT NULL AND $column <> \'\' ORDER BY v',
      readsFrom: {db.medicines},
    ).get();
    return rows.map((r) => r.read<String>('v')).toList();
  }

  /// البدائل: أدوية بنفس المادة الفعالة ومتوفرة
  Future<List<MedicineStock>> alternatives(Medicine m) async {
    final sci = m.scientificName?.trim();
    if (sci == null || sci.isEmpty) return [];
    final rows = await (db.select(db.medicines)
          ..where((t) =>
              t.scientificName.lower().equals(sci.toLowerCase()) &
              t.id.equals(m.id).not() &
              t.active.equals(true)))
        .get();
    final stocks = await listWithStock(ids: rows.map((r) => r.id).toList());
    return stocks.where((s) => s.available > 0).toList();
  }

  Future<List<MedicineStock>> shortages() async {
    final all = await listWithStock();
    return all.where((s) => s.isLow).toList();
  }

  Future<List<StockBatch>> batchesOf(int medicineId, {bool onlyAvailable = false}) {
    final q = db.select(db.batches)..where((t) => t.medicineId.equals(medicineId));
    if (onlyAvailable) q.where((t) => t.quantity.isBiggerThanValue(0));
    q.orderBy([
      (t) => OrderingTerm(expression: t.expiryDate, nulls: NullsOrder.last),
      (t) => OrderingTerm.asc(t.id),
    ]);
    return q.get();
  }

  /// دفعات تنتهي خلال عدد أشهر (أو منتهية)
  Future<List<BatchWithMedicine>> expiring({
    int months = 3,
    bool expiredOnly = false,
  }) async {
    final today = _today();
    final limit = DateTime(today.year, today.month + months, today.day);
    final q = db.select(db.batches).join([
      innerJoin(db.medicines, db.medicines.id.equalsExp(db.batches.medicineId)),
    ]);
    q.where(db.batches.quantity.isBiggerThanValue(0) &
        db.batches.expiryDate.isNotNull() &
        (expiredOnly
            ? db.batches.expiryDate.isSmallerThanValue(today)
            : db.batches.expiryDate.isSmallerThanValue(limit)));
    q.orderBy([OrderingTerm.asc(db.batches.expiryDate)]);
    final rows = await q.get();
    return rows
        .map((r) => BatchWithMedicine(r.readTable(db.batches), r.readTable(db.medicines)))
        .toList();
  }

  /// توزيع كمية على الدفعات: الأقرب انتهاءً أولاً (FEFO) مع استبعاد المنتهية
  Future<List<Allocation>> allocate(int medicineId, int baseQty) async {
    final today = _today();
    final batches = await (db.select(db.batches)
          ..where((t) =>
              t.medicineId.equals(medicineId) &
              t.quantity.isBiggerThanValue(0) &
              (t.expiryDate.isNull() | t.expiryDate.isBiggerOrEqualValue(today)))
          ..orderBy([
            (t) => OrderingTerm(expression: t.expiryDate, nulls: NullsOrder.last),
            (t) => OrderingTerm.asc(t.id),
          ]))
        .get();
    var remaining = baseQty;
    final result = <Allocation>[];
    for (final b in batches) {
      if (remaining <= 0) break;
      final take = b.quantity < remaining ? b.quantity : remaining;
      result.add(Allocation(b, take));
      remaining -= take;
    }
    if (remaining > 0) {
      throw InsufficientStock(medicineId, baseQty - remaining);
    }
    return result;
  }

  Future<void> changeBatchQty(int batchId, int delta) async {
    await db.customUpdate(
      'UPDATE batches SET quantity = quantity + ? WHERE id = ?',
      variables: [Variable.withInt(delta), Variable.withInt(batchId)],
      updates: {db.batches},
    );
  }

  // ---------------- إدارة الأدوية ----------------

  Future<Medicine> saveMedicine({
    required User actor,
    Medicine? existing,
    required MedicinesCompanion data,
  }) async {
    final barcode = data.barcode.present ? data.barcode.value?.trim() : null;
    if (barcode != null && barcode.isNotEmpty) {
      final other = await (db.select(db.medicines)
            ..where((t) => t.barcode.equals(barcode)))
          .getSingleOrNull();
      if (other != null && other.id != existing?.id) {
        throw BusinessException('الباركود مستخدم لدواء آخر: ${other.name}');
      }
    }
    final clean = data.copyWith(
      barcode: Value((barcode == null || barcode.isEmpty) ? null : barcode),
      updatedAt: Value(DateTime.now()),
    );

    if (existing == null) {
      if (!actor.can(Permission.manageMedicines)) {
        throw PermissionDenied(Permission.manageMedicines);
      }
      final id = await db.into(db.medicines).insert(clean);
      final m = (await byId(id))!;
      await audit.log(actor, AuditActions.medicineCreated,
          entity: 'medicine', entityId: id, details: {'name': m.name, 'priceUsd': m.priceUsd});
      return m;
    }

    final newRow = existing.copyWithCompanion(clean);
    final priceChanged = newRow.priceUsd != existing.priceUsd ||
        newRow.stripPriceUsd != existing.stripPriceUsd ||
        newRow.unitPriceUsd != existing.unitPriceUsd;
    if (priceChanged && !actor.can(Permission.editPrices)) {
      throw PermissionDenied(Permission.editPrices);
    }
    final otherChanged = newRow.copyWith(
          priceUsd: existing.priceUsd,
          stripPriceUsd: Value(existing.stripPriceUsd),
          unitPriceUsd: Value(existing.unitPriceUsd),
          updatedAt: existing.updatedAt,
        ) !=
        existing;
    if (otherChanged && !actor.can(Permission.manageMedicines)) {
      throw PermissionDenied(Permission.manageMedicines);
    }

    await (db.update(db.medicines)..where((t) => t.id.equals(existing.id)))
        .write(clean);
    final m = (await byId(existing.id))!;
    if (priceChanged) {
      await audit.log(actor, AuditActions.priceChanged,
          entity: 'medicine',
          entityId: m.id,
          details: {
            'name': m.name,
            'old': existing.priceUsd,
            'new': m.priceUsd,
            if (existing.stripPriceUsd != m.stripPriceUsd)
              'strip': '${existing.stripPriceUsd} → ${m.stripPriceUsd}',
            if (existing.unitPriceUsd != m.unitPriceUsd)
              'unit': '${existing.unitPriceUsd} → ${m.unitPriceUsd}',
          });
    }
    if (otherChanged) {
      await audit.log(actor, AuditActions.medicineUpdated,
          entity: 'medicine', entityId: m.id, details: {'name': m.name});
    }
    return m;
  }

  /// إضافة كمية يدوياً (مخزون افتتاحي أو بدون فاتورة شراء)
  Future<StockBatch> addBatch({
    required User actor,
    required Medicine medicine,
    required int baseQuantity,
    DateTime? expiryDate,
    String? batchNumber,
    double costUsdPerBox = 0,
    int? supplierId,
    int? purchaseId,
    bool logAudit = true,
  }) async {
    if (purchaseId == null && !actor.can(Permission.manageMedicines)) {
      throw PermissionDenied(Permission.manageMedicines);
    }
    if (baseQuantity <= 0) throw BusinessException('الكمية يجب أن تكون أكبر من صفر');
    final id = await db.into(db.batches).insert(BatchesCompanion.insert(
          medicineId: medicine.id,
          quantity: baseQuantity,
          initialQuantity: baseQuantity,
          expiryDate: Value(expiryDate),
          batchNumber: Value(batchNumber?.trim().isEmpty == true ? null : batchNumber?.trim()),
          costUsdPerBox: Value(costUsdPerBox),
          supplierId: Value(supplierId),
          purchaseId: Value(purchaseId),
        ));
    if (logAudit) {
      await audit.log(actor, AuditActions.batchAdded,
          entity: 'batch',
          entityId: id,
          details: {
            'medicine': medicine.name,
            'qty': medicine.describeQty(baseQuantity),
            'expiry': expiryDate?.toIso8601String().substring(0, 10),
          });
    }
    return (await (db.select(db.batches)..where((t) => t.id.equals(id))).getSingle());
  }

  /// جرد: تعديل كمية دفعة إلى الكمية الفعلية
  Future<void> adjustBatch({
    required User actor,
    required StockBatch batch,
    required int newQuantity,
    required String reason,
    String? note,
  }) async {
    if (!actor.can(Permission.manageMedicines)) {
      throw PermissionDenied(Permission.manageMedicines);
    }
    if (newQuantity < 0) throw BusinessException('الكمية لا يمكن أن تكون سالبة');
    final delta = newQuantity - batch.quantity;
    if (delta == 0) return;
    final m = (await byId(batch.medicineId))!;
    await db.transaction(() async {
      await changeBatchQty(batch.id, delta);
      await db.into(db.stockAdjustments).insert(StockAdjustmentsCompanion.insert(
            batchId: batch.id,
            medicineId: batch.medicineId,
            delta: delta,
            reason: reason,
            note: Value(note),
            userId: Value(actor.id),
          ));
      await audit.log(
        actor,
        reason == 'expired' ? AuditActions.expiredWriteOff : AuditActions.stockAdjusted,
        entity: 'batch',
        entityId: batch.id,
        details: {
          'medicine': m.name,
          'from': m.describeQty(batch.quantity),
          'to': m.describeQty(newQuantity),
          'reason': reason,
          if (note != null && note.isNotEmpty) 'note': note,
        },
      );
    });
  }

  Future<void> updateBatchInfo({
    required User actor,
    required StockBatch batch,
    DateTime? expiryDate,
    String? batchNumber,
  }) async {
    if (!actor.can(Permission.manageMedicines)) {
      throw PermissionDenied(Permission.manageMedicines);
    }
    await (db.update(db.batches)..where((t) => t.id.equals(batch.id))).write(
      BatchesCompanion(
        expiryDate: Value(expiryDate),
        batchNumber: Value(batchNumber),
      ),
    );
    await audit.log(actor, 'تعديل بيانات دفعة',
        entity: 'batch',
        entityId: batch.id,
        details: {'expiry': expiryDate?.toIso8601String().substring(0, 10), 'batch': batchNumber});
  }

  /// قيمة المخزون (بسعر التكلفة وسعر البيع) بالدولار
  Future<(double cost, double retail)> stockValue() async {
    final rows = await db.customSelect('''
SELECT
  COALESCE(SUM(b.quantity * b.cost_usd_per_box * 1.0 / (MAX(m.strips_per_box,1) * MAX(m.units_per_strip,1))), 0) AS cost,
  COALESCE(SUM(b.quantity * m.price_usd * 1.0 / (MAX(m.strips_per_box,1) * MAX(m.units_per_strip,1))), 0) AS retail
FROM batches b JOIN medicines m ON m.id = b.medicine_id
WHERE b.quantity > 0
''', readsFrom: {db.batches, db.medicines}).getSingle();
    return (rows.read<double>('cost'), rows.read<double>('retail'));
  }
}

class InsufficientStock implements Exception {
  final int medicineId;
  final int available;
  InsufficientStock(this.medicineId, this.available);

  @override
  String toString() => 'الكمية المتوفرة غير كافية';
}
