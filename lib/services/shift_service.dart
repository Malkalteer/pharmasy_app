import 'package:drift/drift.dart';

import '../core/permissions.dart';
import '../data/database.dart';
import 'audit_service.dart';

const currencySyp = 'SYP';
const currencyUsd = 'USD';

/// أنواع حركات الدرج
class CashTypes {
  static const opening = 'opening';
  static const sale = 'sale';
  static const change = 'change';
  static const refund = 'refund';
  static const expense = 'expense';
  static const withdrawal = 'withdrawal';
  static const deposit = 'deposit';
  static const supplierPayment = 'supplier_payment';
  static const customerPayment = 'customer_payment';
  static const supplierReturn = 'supplier_return';
  static const voidSale = 'void';
  static const handover = 'handover';

  static String label(String t) =>
      const {
        opening: 'رصيد افتتاحي',
        sale: 'مبيعات',
        change: 'باقي للزبون',
        refund: 'مرتجع زبون',
        expense: 'مصروف',
        withdrawal: 'سحب',
        deposit: 'إيداع',
        supplierPayment: 'دفعة لمورد',
        customerPayment: 'تحصيل دين',
        supplierReturn: 'مرتجع مورد',
        voidSale: 'إلغاء فاتورة',
        handover: 'تسليم الدرج',
      }[t] ??
      t;
}

class DrawerBalance {
  final double syp;
  final double usd;
  const DrawerBalance(this.syp, this.usd);
}

class ShiftSummary {
  final Shift shift;
  final DrawerBalance balance;
  final Map<String, DrawerBalance> byType;
  final int salesCount;
  final double salesTotalSyp;
  final double debtSalesSyp;
  ShiftSummary(this.shift, this.balance, this.byType, this.salesCount, this.salesTotalSyp, this.debtSalesSyp);
}

class ShiftService {
  final AppDatabase db;
  final AuditService audit;

  ShiftService(this.db, this.audit);

  Future<Shift?> openShiftOf(int userId) =>
      (db.select(db.shifts)
            ..where((t) => t.userId.equals(userId) & t.status.equals('open'))
            ..orderBy([(t) => OrderingTerm.desc(t.id)])
            ..limit(1))
          .getSingleOrNull();

  Future<Shift?> byId(int id) => (db.select(db.shifts)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<Shift> open({required User user, double openingSyp = 0, double openingUsd = 0}) async {
    final existing = await openShiftOf(user.id);
    if (existing != null) return existing;
    return db.transaction(() async {
      final id = await db
          .into(db.shifts)
          .insert(
            ShiftsCompanion.insert(userId: user.id, openingSyp: Value(openingSyp), openingUsd: Value(openingUsd)),
          );
      if (openingSyp != 0) {
        await addMovementRaw(id, user.id, CashTypes.opening, currencySyp, openingSyp);
      }
      if (openingUsd != 0) {
        await addMovementRaw(id, user.id, CashTypes.opening, currencyUsd, openingUsd);
      }
      await audit.log(
        user,
        AuditActions.shiftOpened,
        entity: 'shift',
        entityId: id,
        details: {'syp': openingSyp, 'usd': openingUsd},
      );
      return (await byId(id))!;
    });
  }

  Future<int> addMovementRaw(
    int shiftId,
    int? userId,
    String type,
    String currency,
    double amount, {
    int? refId,
    String? note,
  }) {
    return db
        .into(db.cashMovements)
        .insert(
          CashMovementsCompanion.insert(
            shiftId: shiftId,
            userId: Value(userId),
            type: type,
            currency: currency,
            amount: amount,
            refId: Value(refId),
            note: Value(note),
          ),
        );
  }

  /// مصروف / سحب / إيداع يدوي
  Future<void> manualMovement({
    required User user,
    required Shift shift,
    required String type,
    required String currency,
    required double amount,
    String? note,
  }) async {
    if (shift.status != 'open') throw BusinessException('الوردية مغلقة');
    if (amount <= 0) throw BusinessException('المبلغ يجب أن يكون أكبر من صفر');
    if (type != CashTypes.deposit && !user.can(Permission.cashOut)) {
      throw PermissionDenied(Permission.cashOut);
    }
    final signed = type == CashTypes.deposit ? amount : -amount;
    if (signed < 0) {
      final bal = await balance(shift.id);
      final avail = currency == currencySyp ? bal.syp : bal.usd;
      if (avail + signed < -0.001) {
        throw BusinessException('المبلغ أكبر من الموجود في الدرج');
      }
    }
    await db.transaction(() async {
      final id = await addMovementRaw(shift.id, user.id, type, currency, signed, note: note);
      await audit.log(
        user,
        AuditActions.cashMovement,
        entity: 'cash',
        entityId: id,
        details: {
          'type': CashTypes.label(type),
          'currency': currency,
          'amount': amount,
          if (note != null) 'note': note,
        },
      );
    });
  }

  Future<DrawerBalance> balance(int shiftId) async {
    final rows = await db
        .customSelect(
          'SELECT currency, COALESCE(SUM(amount),0) AS s FROM cash_movements WHERE shift_id = ? GROUP BY currency',
          variables: [Variable.withInt(shiftId)],
          readsFrom: {db.cashMovements},
        )
        .get();
    double syp = 0, usd = 0;
    for (final r in rows) {
      final c = r.read<String>('currency');
      final s = r.read<double>('s');
      if (c == currencySyp) syp = s;
      if (c == currencyUsd) usd = s;
    }
    return DrawerBalance(_r(syp), _r(usd));
  }

  static double _r(double v) => (v * 100).roundToDouble() / 100;

  Future<List<CashMovement>> movements(int shiftId) =>
      (db.select(db.cashMovements)
            ..where((t) => t.shiftId.equals(shiftId))
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();

  Future<ShiftSummary> summary(Shift shift) async {
    final mv = await movements(shift.id);
    final byType = <String, DrawerBalance>{};
    double syp = 0, usd = 0;
    for (final m in mv) {
      if (m.type == CashTypes.handover) continue;
      final cur = byType[m.type] ?? const DrawerBalance(0, 0);
      if (m.currency == currencySyp) {
        syp += m.amount;
        byType[m.type] = DrawerBalance(cur.syp + m.amount, cur.usd);
      } else {
        usd += m.amount;
        byType[m.type] = DrawerBalance(cur.syp, cur.usd + m.amount);
      }
    }
    final s = await db
        .customSelect(
          "SELECT COUNT(*) AS c, COALESCE(SUM(total_syp),0) AS t, COALESCE(SUM(debt_syp),0) AS d FROM sales WHERE shift_id = ? AND status = 'completed'",
          variables: [Variable.withInt(shift.id)],
          readsFrom: {db.sales},
        )
        .getSingle();
    return ShiftSummary(
      shift,
      DrawerBalance(_r(syp), _r(usd)),
      byType,
      s.read<int>('c'),
      s.read<double>('t'),
      s.read<double>('d'),
    );
  }

  /// إغلاق الوردية وتسليم الدرج: يُسجَّل الفرق بين المتوقع والفعلي ويُصفَّر الدرج
  Future<Shift> close({
    required User user,
    required Shift shift,
    required double actualSyp,
    required double actualUsd,
    int? receivedById,
    String? note,
  }) async {
    if (shift.status != 'open') throw BusinessException('الوردية مغلقة مسبقاً');
    if (shift.userId != user.id && !user.isOwner) throw PermissionDenied();
    return db.transaction(() async {
      final expected = await balance(shift.id);
      final diffSyp = _r(actualSyp - expected.syp);
      final diffUsd = _r(actualUsd - expected.usd);
      // تصفير الدرج: حركة تسليم تساوي الرصيد المتوقع
      if (expected.syp != 0) {
        await addMovementRaw(shift.id, user.id, CashTypes.handover, currencySyp, -expected.syp, note: 'تسليم');
      }
      if (expected.usd != 0) {
        await addMovementRaw(shift.id, user.id, CashTypes.handover, currencyUsd, -expected.usd, note: 'تسليم');
      }
      await (db.update(db.shifts)..where((t) => t.id.equals(shift.id))).write(
        ShiftsCompanion(
          closedAt: Value(DateTime.now()),
          expectedSyp: Value(expected.syp),
          expectedUsd: Value(expected.usd),
          actualSyp: Value(actualSyp),
          actualUsd: Value(actualUsd),
          diffSyp: Value(diffSyp),
          diffUsd: Value(diffUsd),
          receivedById: Value(receivedById),
          note: Value(note),
          status: const Value('closed'),
        ),
      );
      await audit.log(
        user,
        AuditActions.shiftClosed,
        entity: 'shift',
        entityId: shift.id,
        details: {
          'expectedSyp': expected.syp,
          'actualSyp': actualSyp,
          'diffSyp': diffSyp,
          'expectedUsd': expected.usd,
          'actualUsd': actualUsd,
          'diffUsd': diffUsd,
        },
      );
      return (await byId(shift.id))!;
    });
  }

  Future<List<Shift>> list({int? userId, DateTime? from, DateTime? to, int limit = 200}) {
    final q = db.select(db.shifts);
    q.where((t) {
      Expression<bool> e = const Constant(true);
      if (userId != null) e = e & t.userId.equals(userId);
      if (from != null) e = e & t.openedAt.isBiggerOrEqualValue(from);
      if (to != null) e = e & t.openedAt.isSmallerThanValue(to);
      return e;
    });
    q.orderBy([(t) => OrderingTerm.desc(t.id)]);
    q.limit(limit);
    return q.get();
  }

  Future<List<Shift>> openShifts() => (db.select(db.shifts)..where((t) => t.status.equals('open'))).get();
}
