import 'package:drift/drift.dart';

import '../core/money.dart';
import '../core/permissions.dart';
import '../data/database.dart';
import 'audit_service.dart';
import 'shift_service.dart';

class CustomerWithBalance {
  final Customer customer;

  /// الدين بالدولار (موجب = على الزبون)
  final double balanceUsd;
  CustomerWithBalance(this.customer, this.balanceUsd);
}

class SupplierWithBalance {
  final Supplier supplier;

  /// المستحق للمورد بالدولار (موجب = على الصيدلية)
  final double balanceUsd;
  SupplierWithBalance(this.supplier, this.balanceUsd);
}

/// الزبائن وديونهم
class CustomerService {
  final AppDatabase db;
  final AuditService audit;
  final ShiftService shifts;

  CustomerService(this.db, this.audit, this.shifts);

  Future<List<CustomerWithBalance>> list({String? search, bool onlyDebtors = false}) async {
    final vars = <Variable>[];
    var where = 'WHERE c.active = 1';
    if (search != null && search.trim().isNotEmpty) {
      where += ' AND (c.name LIKE ? OR c.phone LIKE ?)';
      vars.addAll([Variable.withString('%${search.trim()}%'), Variable.withString('%${search.trim()}%')]);
    }
    final rows = await db
        .customSelect(
          '''
SELECT c.*, COALESCE((SELECT SUM(amount_usd) FROM customer_transactions t WHERE t.customer_id = c.id), 0) AS bal
FROM customers c $where ORDER BY c.name COLLATE NOCASE
''',
          variables: vars,
          readsFrom: {db.customers, db.customerTransactions},
        )
        .get();
    final l = rows
        .map((r) => CustomerWithBalance(db.customers.map(r.data), roundTo(r.read<double>('bal'), 6)))
        .toList();
    return onlyDebtors ? l.where((c) => c.balanceUsd > 0.0001).toList() : l;
  }

  Future<Customer?> byId(int id) => (db.select(db.customers)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<double> balanceUsd(int customerId) async {
    final r = await db
        .customSelect(
          'SELECT COALESCE(SUM(amount_usd),0) AS s FROM customer_transactions WHERE customer_id = ?',
          variables: [Variable.withInt(customerId)],
          readsFrom: {db.customerTransactions},
        )
        .getSingle();
    return roundTo(r.read<double>('s'), 6);
  }

  Future<Customer> save({
    required User actor,
    Customer? existing,
    required String name,
    String? phone,
    String? notes,
    double? creditLimitUsd,
  }) async {
    if (name.trim().isEmpty) throw BusinessException('اسم الزبون مطلوب');
    final data = CustomersCompanion(
      name: Value(name.trim()),
      phone: Value(phone?.trim()),
      notes: Value(notes?.trim()),
      creditLimitUsd: Value(creditLimitUsd),
    );
    if (existing == null) {
      final id = await db.into(db.customers).insert(data);
      await audit.log(actor, 'إضافة زبون', entity: 'customer', entityId: id, details: name);
      return (await byId(id))!;
    }
    if (!actor.can(Permission.manageCustomers)) throw PermissionDenied(Permission.manageCustomers);
    await (db.update(db.customers)..where((t) => t.id.equals(existing.id))).write(data);
    await audit.log(actor, 'تعديل زبون', entity: 'customer', entityId: existing.id, details: name);
    return (await byId(existing.id))!;
  }

  Future<void> addTransaction({
    required int customerId,
    required String type,
    required double amountUsd,
    String currency = currencySyp,
    double originalAmount = 0,
    double rate = 0,
    int? refId,
    int? shiftId,
    int? userId,
    String? note,
  }) async {
    await db
        .into(db.customerTransactions)
        .insert(
          CustomerTransactionsCompanion.insert(
            customerId: customerId,
            type: type,
            amountUsd: amountUsd,
            currency: Value(currency),
            originalAmount: Value(originalAmount),
            rate: Value(rate),
            refId: Value(refId),
            shiftId: Value(shiftId),
            userId: Value(userId),
            note: Value(note),
          ),
        );
  }

  /// تحصيل دفعة من دين زبون إلى درج الصيدلي
  Future<void> receivePayment({
    required User actor,
    required Shift shift,
    required Customer customer,
    required String currency,
    required double amount,
    required double rate,
    String? note,
  }) async {
    if (!actor.can(Permission.manageCustomers)) throw PermissionDenied(Permission.manageCustomers);
    if (amount <= 0) throw BusinessException('المبلغ يجب أن يكون أكبر من صفر');
    if (rate <= 0) throw BusinessException('يرجى تحديد سعر الصرف أولاً');
    final usd = currency == currencyUsd ? amount : sypToUsd(amount, rate);
    await db.transaction(() async {
      final mvId = await shifts.addMovementRaw(
        shift.id,
        actor.id,
        CashTypes.customerPayment,
        currency,
        amount,
        refId: customer.id,
        note: customer.name,
      );
      await addTransaction(
        customerId: customer.id,
        type: 'payment',
        amountUsd: -usd,
        currency: currency,
        originalAmount: amount,
        rate: rate,
        refId: mvId,
        shiftId: shift.id,
        userId: actor.id,
        note: note,
      );
      await audit.log(
        actor,
        AuditActions.customerPayment,
        entity: 'customer',
        entityId: customer.id,
        details: {'name': customer.name, 'amount': amount, 'currency': currency},
      );
    });
  }

  /// تعديل يدوي للدين (دين قديم، تسوية...) - للمالك فقط
  Future<void> adjustDebt({
    required User actor,
    required Customer customer,
    required double amountUsd,
    required String note,
  }) async {
    if (!actor.isOwner) throw PermissionDenied();
    await addTransaction(
      customerId: customer.id,
      type: 'adjustment',
      amountUsd: amountUsd,
      currency: currencyUsd,
      originalAmount: amountUsd,
      userId: actor.id,
      note: note,
    );
    await audit.log(
      actor,
      AuditActions.debtAdjusted,
      entity: 'customer',
      entityId: customer.id,
      details: {'name': customer.name, 'usd': amountUsd, 'note': note},
    );
  }

  Future<List<CustomerTransaction>> statement(int customerId) =>
      (db.select(db.customerTransactions)
            ..where((t) => t.customerId.equals(customerId))
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();
}

/// الموردون (المستودعات) وديون الصيدلية لهم
class SupplierService {
  final AppDatabase db;
  final AuditService audit;
  final ShiftService shifts;

  SupplierService(this.db, this.audit, this.shifts);

  Future<List<SupplierWithBalance>> list({String? search}) async {
    final vars = <Variable>[];
    var where = 'WHERE s.active = 1';
    if (search != null && search.trim().isNotEmpty) {
      where += ' AND (s.name LIKE ? OR s.phone LIKE ?)';
      vars.addAll([Variable.withString('%${search.trim()}%'), Variable.withString('%${search.trim()}%')]);
    }
    final rows = await db
        .customSelect(
          '''
SELECT s.*, COALESCE((SELECT SUM(amount_usd) FROM supplier_transactions t WHERE t.supplier_id = s.id), 0) AS bal
FROM suppliers s $where ORDER BY s.name COLLATE NOCASE
''',
          variables: vars,
          readsFrom: {db.suppliers, db.supplierTransactions},
        )
        .get();
    return rows.map((r) => SupplierWithBalance(db.suppliers.map(r.data), roundTo(r.read<double>('bal'), 6))).toList();
  }

  Future<Supplier?> byId(int id) => (db.select(db.suppliers)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<double> balanceUsd(int supplierId) async {
    final r = await db
        .customSelect(
          'SELECT COALESCE(SUM(amount_usd),0) AS s FROM supplier_transactions WHERE supplier_id = ?',
          variables: [Variable.withInt(supplierId)],
          readsFrom: {db.supplierTransactions},
        )
        .getSingle();
    return roundTo(r.read<double>('s'), 6);
  }

  Future<Supplier> save({
    required User actor,
    Supplier? existing,
    required String name,
    String? phone,
    String? address,
    String? notes,
  }) async {
    if (!actor.can(Permission.managePurchases)) throw PermissionDenied(Permission.managePurchases);
    if (name.trim().isEmpty) throw BusinessException('اسم المورد مطلوب');
    final data = SuppliersCompanion(
      name: Value(name.trim()),
      phone: Value(phone?.trim()),
      address: Value(address?.trim()),
      notes: Value(notes?.trim()),
    );
    if (existing == null) {
      final id = await db.into(db.suppliers).insert(data);
      await audit.log(actor, 'إضافة مورد', entity: 'supplier', entityId: id, details: name);
      return (await byId(id))!;
    }
    await (db.update(db.suppliers)..where((t) => t.id.equals(existing.id))).write(data);
    await audit.log(actor, 'تعديل مورد', entity: 'supplier', entityId: existing.id, details: name);
    return (await byId(existing.id))!;
  }

  Future<void> addTransaction({
    required int supplierId,
    required String type,
    required double amountUsd,
    String currency = currencyUsd,
    double originalAmount = 0,
    double rate = 0,
    int? refId,
    int? shiftId,
    int? userId,
    String? note,
  }) async {
    await db
        .into(db.supplierTransactions)
        .insert(
          SupplierTransactionsCompanion.insert(
            supplierId: supplierId,
            type: type,
            amountUsd: amountUsd,
            currency: Value(currency),
            originalAmount: Value(originalAmount),
            rate: Value(rate),
            refId: Value(refId),
            shiftId: Value(shiftId),
            userId: Value(userId),
            note: Value(note),
          ),
        );
  }

  /// دفعة للمورد. إذا كانت من الدرج تُسجَّل حركة خروج في وردية المستخدم.
  Future<void> pay({
    required User actor,
    required Supplier supplier,
    required String currency,
    required double amount,
    required double rate,
    Shift? fromShift,
    String? note,
    int? purchaseId,
  }) async {
    if (!actor.can(Permission.managePurchases)) throw PermissionDenied(Permission.managePurchases);
    if (amount <= 0) throw BusinessException('المبلغ يجب أن يكون أكبر من صفر');
    if (currency == currencySyp && rate <= 0) throw BusinessException('يرجى تحديد سعر الصرف أولاً');
    final usd = currency == currencyUsd ? amount : sypToUsd(amount, rate);
    await db.transaction(() async {
      if (fromShift != null) {
        final bal = await shifts.balance(fromShift.id);
        final avail = currency == currencySyp ? bal.syp : bal.usd;
        if (avail < amount - 0.001) {
          throw BusinessException('المبلغ أكبر من الموجود في الدرج');
        }
        await shifts.addMovementRaw(
          fromShift.id,
          actor.id,
          CashTypes.supplierPayment,
          currency,
          -amount,
          refId: supplier.id,
          note: supplier.name,
        );
      }
      await addTransaction(
        supplierId: supplier.id,
        type: 'payment',
        amountUsd: -usd,
        currency: currency,
        originalAmount: amount,
        rate: rate,
        refId: purchaseId,
        shiftId: fromShift?.id,
        userId: actor.id,
        note: note,
      );
      await audit.log(
        actor,
        AuditActions.supplierPayment,
        entity: 'supplier',
        entityId: supplier.id,
        details: {'name': supplier.name, 'amount': amount, 'currency': currency, 'fromDrawer': fromShift != null},
      );
    });
  }

  Future<List<SupplierTransaction>> statement(int supplierId) =>
      (db.select(db.supplierTransactions)
            ..where((t) => t.supplierId.equals(supplierId))
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();
}

String customerTxLabel(String t) =>
    const {
      'sale': 'فاتورة بالدين',
      'payment': 'دفعة',
      'return': 'مرتجع',
      'adjustment': 'تسوية',
      'void': 'إلغاء فاتورة',
    }[t] ??
    t;

String supplierTxLabel(String t) =>
    const {'purchase': 'فاتورة شراء', 'payment': 'دفعة', 'return': 'مرتجع', 'adjustment': 'تسوية'}[t] ?? t;
