import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/money.dart';
import '../../data/database.dart';
import '../../services/report_service.dart';
import '../../services/shift_service.dart';
import '../widgets/common.dart';
import 'home_shell.dart';

/// لوحة اليوم للمالك: المبيعات، الأرباح، الورديات المفتوحة، التنبيهات
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PeriodRow? _today;
  PeriodRow? _month;
  int _low = 0;
  int _expiring = 0;
  int _expired = 0;
  double _custDebt = 0;
  double _suppDebt = 0;
  List<(Shift, String, DrawerBalance)> _open = [];
  List<TopItem> _top = [];
  (double, double) _stock = (0, 0);

  AppState get st => AppState.I;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final s = st.s;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final t = await s.reports.total(today, tomorrow);
    final m = await s.reports.total(DateTime(now.year, now.month), DateTime(now.year, now.month + 1));
    final low = (await s.inventory.shortages()).length;
    final expiring = (await s.inventory.expiring(months: s.settings.expiryAlertMonths)).length;
    final expired = (await s.inventory.expiring(expiredOnly: true)).length;
    final cd = await s.reports.totalCustomerDebtUsd();
    final sd = await s.reports.totalSupplierDebtUsd();
    final users = {for (final u in await s.users.list()) u.id: u.fullName};
    final open = <(Shift, String, DrawerBalance)>[];
    for (final sh in await s.shifts.openShifts()) {
      open.add((sh, users[sh.userId] ?? '', await s.shifts.balance(sh.id)));
    }
    final top = await s.reports.topMedicines(today, tomorrow, limit: 8);
    final stock = await s.inventory.stockValue();
    if (mounted) {
      setState(() {
        _today = t;
        _month = m;
        _low = low;
        _expiring = expiring;
        _expired = expired;
        _custDebt = cd;
        _suppDebt = sd;
        _open = open;
        _top = top;
        _stock = stock;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = _today;
    final m = _month;
    final rate = st.rate;
    if (t == null || m == null) return const Center(child: CircularProgressIndicator());
    void go(String p) => HomeShell.navigate?.call(p);
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionTitle(
            'لوحة اليوم - ${fmtDate(DateTime.now())}',
            icon: Icons.dashboard_outlined,
            actions: [IconButton(onPressed: _load, icon: const Icon(Icons.refresh), tooltip: 'تحديث')],
          ),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              StatCard(
                title: 'مبيعات اليوم',
                value: fmtSyp(t.netSalesSyp),
                sub: '${t.count} فاتورة • ${fmtUsd(roundTo(t.netSalesUsd, 2))}',
                icon: Icons.point_of_sale,
                onTap: () => go('الفواتير'),
              ),
              StatCard(
                title: 'ربح اليوم',
                value: fmtUsd(roundTo(t.profitUsd, 2)),
                sub: '≈ ${fmtSyp(roundTo(t.profitUsd * rate, 0))}',
                icon: Icons.trending_up,
                color: kSuccess,
                onTap: () => go('التقارير والأرباح'),
              ),
              StatCard(
                title: 'مبيعات الشهر',
                value: fmtUsd(roundTo(m.netSalesUsd, 2)),
                sub: 'ربح ${fmtUsd(roundTo(m.profitUsd, 2))}',
                icon: Icons.calendar_month,
                color: Colors.indigo,
              ),
              StatCard(
                title: 'قيمة المخزون',
                value: fmtUsd(roundTo(_stock.$1, 0)),
                sub: 'بسعر البيع ${fmtUsd(roundTo(_stock.$2, 0))}',
                icon: Icons.inventory,
                color: Colors.blueGrey,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              StatCard(
                title: 'أدوية ناقصة',
                value: '$_low',
                icon: Icons.production_quantity_limits,
                color: _low > 0 ? kWarning : kSuccess,
                onTap: () => go('النواقص والانتهاء'),
              ),
              StatCard(
                title: 'تقترب من الانتهاء',
                value: '$_expiring',
                sub: _expired > 0 ? 'منها $_expired منتهية' : null,
                icon: Icons.event_busy,
                color: _expiring > 0 ? kDanger : kSuccess,
                onTap: () => go('النواقص والانتهاء'),
              ),
              StatCard(
                title: 'ديون الزبائن',
                value: fmtSyp(roundTo(_custDebt * rate, 0)),
                sub: fmtUsd(roundTo(_custDebt, 2)),
                icon: Icons.people,
                color: kWarning,
                onTap: () => go('الزبائن والديون'),
              ),
              StatCard(
                title: 'مستحق للموردين',
                value: fmtUsd(roundTo(_suppDebt, 2)),
                icon: Icons.warehouse,
                color: kDanger,
                onTap: () => go('الموردون'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('الورديات المفتوحة الآن', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    SimpleTable(
                      columns: const ['الصيدلي', 'منذ', 'في الدرج ليرة', 'في الدرج دولار'],
                      rows: [
                        for (final (sh, name, bal) in _open)
                          [Text(name), Text(fmtDateTime(sh.openedAt)), Text(fmtSyp(bal.syp)), Text(fmtUsd(bal.usd))],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('الأكثر مبيعاً اليوم', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    SimpleTable(
                      columns: const ['الدواء', 'المبيعات'],
                      rows: [
                        for (final i in _top) [Text(i.name), Text(fmtSyp(i.salesSyp))],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
