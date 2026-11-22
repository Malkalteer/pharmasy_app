import 'package:drift/drift.dart';

import '../core/money.dart';
import '../data/database.dart';

class PeriodRow {
  final String period;
  final int count;
  final double salesSyp;
  final double salesUsd;
  final double costUsd;
  final double returnsSyp;
  final double returnsUsd;
  final double returnsCostUsd;

  PeriodRow(this.period, this.count, this.salesSyp, this.salesUsd, this.costUsd, this.returnsSyp,
      this.returnsUsd, this.returnsCostUsd);

  double get netSalesUsd => salesUsd - returnsUsd;
  double get netSalesSyp => salesSyp - returnsSyp;
  double get profitUsd => roundTo((salesUsd - costUsd) - (returnsUsd - returnsCostUsd), 4);
  double get marginPct => netSalesUsd <= 0 ? 0 : profitUsd / netSalesUsd * 100;
}

class TopItem {
  final int medicineId;
  final String name;
  final int baseQty;
  final double salesSyp;
  final double costUsd;
  TopItem(this.medicineId, this.name, this.baseQty, this.salesSyp, this.costUsd);
}

class UserSalesRow {
  final int userId;
  final String name;
  final int count;
  final double salesSyp;
  final double profitUsd;
  UserSalesRow(this.userId, this.name, this.count, this.salesSyp, this.profitUsd);
}

class ReportService {
  final AppDatabase db;
  ReportService(this.db);

  /// group = 'day' أو 'month'
  Future<List<PeriodRow>> byPeriod(DateTime from, DateTime to, {String group = 'day', int? userId}) async {
    final fmt = group == 'month' ? '%Y/%m' : '%Y/%m/%d';
    final vars = [Variable.withDateTime(from), Variable.withDateTime(to)];
    final userFilter = userId != null ? ' AND user_id = $userId' : '';
    final sales = await db.customSelect('''
SELECT strftime('$fmt', created_at, 'unixepoch', 'localtime') AS p,
  COUNT(*) AS c, SUM(total_syp) AS s, SUM(total_usd) AS u, SUM(cost_usd) AS cost
FROM sales WHERE status = 'completed' AND created_at >= ? AND created_at < ?$userFilter
GROUP BY p ORDER BY p
''', variables: vars, readsFrom: {db.sales}).get();
    final rets = await db.customSelect('''
SELECT strftime('$fmt', created_at, 'unixepoch', 'localtime') AS p,
  SUM(total_syp) AS s, SUM(total_syp / rate) AS u, SUM(cost_usd) AS cost
FROM customer_returns WHERE created_at >= ? AND created_at < ?$userFilter
GROUP BY p
''', variables: vars, readsFrom: {db.customerReturns}).get();
    final retMap = {for (final r in rets) r.read<String>('p'): r};
    final periods = <String>{
      ...sales.map((r) => r.read<String>('p')),
      ...rets.map((r) => r.read<String>('p')),
    }.toList()
      ..sort();
    final salesMap = {for (final r in sales) r.read<String>('p'): r};
    return periods.map((p) {
      final s = salesMap[p];
      final r = retMap[p];
      return PeriodRow(
        p,
        s?.read<int>('c') ?? 0,
        s?.read<double>('s') ?? 0,
        s?.read<double>('u') ?? 0,
        s?.read<double>('cost') ?? 0,
        r?.read<double>('s') ?? 0,
        r?.read<double>('u') ?? 0,
        r?.read<double>('cost') ?? 0,
      );
    }).toList();
  }

  Future<PeriodRow> total(DateTime from, DateTime to, {int? userId}) async {
    final rows = await byPeriod(from, to, group: 'month', userId: userId);
    return PeriodRow(
      'الإجمالي',
      rows.fold(0, (a, r) => a + r.count),
      rows.fold(0.0, (a, r) => a + r.salesSyp),
      rows.fold(0.0, (a, r) => a + r.salesUsd),
      rows.fold(0.0, (a, r) => a + r.costUsd),
      rows.fold(0.0, (a, r) => a + r.returnsSyp),
      rows.fold(0.0, (a, r) => a + r.returnsUsd),
      rows.fold(0.0, (a, r) => a + r.returnsCostUsd),
    );
  }

  Future<List<TopItem>> topMedicines(DateTime from, DateTime to, {int limit = 30}) async {
    final rows = await db.customSelect('''
SELECT si.medicine_id AS mid, si.medicine_name AS name,
  SUM(si.base_quantity - si.returned_base) AS q, SUM(si.total_syp) AS s, SUM(si.cost_usd) AS cost
FROM sale_items si JOIN sales s ON s.id = si.sale_id
WHERE s.status = 'completed' AND s.created_at >= ? AND s.created_at < ?
GROUP BY si.medicine_id ORDER BY s DESC LIMIT $limit
''', variables: [Variable.withDateTime(from), Variable.withDateTime(to)], readsFrom: {db.saleItems, db.sales}).get();
    return rows
        .map((r) => TopItem(r.read<int>('mid'), r.read<String>('name'), r.read<int>('q'), r.read<double>('s'),
            r.read<double>('cost')))
        .toList();
  }

  Future<List<UserSalesRow>> byUser(DateTime from, DateTime to) async {
    final rows = await db.customSelect('''
SELECT s.user_id AS uid, u.full_name AS name, COUNT(*) AS c, SUM(s.total_syp) AS t, SUM(s.total_usd - s.cost_usd) AS p
FROM sales s JOIN users u ON u.id = s.user_id
WHERE s.status = 'completed' AND s.created_at >= ? AND s.created_at < ?
GROUP BY s.user_id ORDER BY t DESC
''', variables: [Variable.withDateTime(from), Variable.withDateTime(to)], readsFrom: {db.sales, db.users}).get();
    return rows
        .map((r) => UserSalesRow(
            r.read<int>('uid'), r.read<String>('name'), r.read<int>('c'), r.read<double>('t'), r.read<double>('p')))
        .toList();
  }

  /// المصاريف من الدرج خلال فترة (حسب العملة)
  Future<(double syp, double usd)> expenses(DateTime from, DateTime to) async {
    final rows = await db.customSelect('''
SELECT currency, COALESCE(SUM(-amount),0) AS s FROM cash_movements
WHERE type = 'expense' AND created_at >= ? AND created_at < ? GROUP BY currency
''', variables: [Variable.withDateTime(from), Variable.withDateTime(to)], readsFrom: {db.cashMovements}).get();
    double syp = 0, usd = 0;
    for (final r in rows) {
      if (r.read<String>('currency') == 'SYP') syp = r.read<double>('s');
      if (r.read<String>('currency') == 'USD') usd = r.read<double>('s');
    }
    return (syp, usd);
  }

  Future<double> totalCustomerDebtUsd() async {
    final r = await db
        .customSelect('SELECT COALESCE(SUM(amount_usd),0) AS s FROM customer_transactions',
            readsFrom: {db.customerTransactions})
        .getSingle();
    return r.read<double>('s');
  }

  Future<double> totalSupplierDebtUsd() async {
    final r = await db
        .customSelect('SELECT COALESCE(SUM(amount_usd),0) AS s FROM supplier_transactions',
            readsFrom: {db.supplierTransactions})
        .getSingle();
    return r.read<double>('s');
  }
}
