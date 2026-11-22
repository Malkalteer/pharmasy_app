import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/money.dart';
import '../../data/database.dart';
import '../../printing/printer.dart';
import '../../services/report_service.dart';
import '../widgets/common.dart';

/// تقارير المبيعات والأرباح اليومية والشهرية
class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late DateTime _from = DateTime(DateTime.now().year, DateTime.now().month);
  late DateTime _to = DateTime(DateTime.now().year, DateTime.now().month + 1);
  String _group = 'day';
  int? _userId;
  List<User> _users = [];
  List<PeriodRow> _rows = [];
  PeriodRow? _total;
  List<TopItem> _top = [];
  List<UserSalesRow> _byUser = [];
  (double, double) _expenses = (0, 0);

  AppState get st => AppState.I;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final r = st.s.reports;
    final rows = await r.byPeriod(_from, _to, group: _group, userId: _userId);
    final total = await r.total(_from, _to, userId: _userId);
    final top = await r.topMedicines(_from, _to);
    final bu = await r.byUser(_from, _to);
    final ex = await r.expenses(_from, _to);
    final users = await st.s.users.list();
    if (mounted) {
      setState(() {
        _rows = rows;
        _total = total;
        _top = top;
        _byUser = bu;
        _expenses = ex;
        _users = users;
      });
    }
  }

  void _print() {
    final t = _total!;
    AppPrinter.printTable(
      title: _group == 'day' ? 'تقرير المبيعات والأرباح اليومي' : 'تقرير المبيعات والأرباح الشهري',
      subtitle: 'من ${fmtDate(_from)} إلى ${fmtDate(_to.subtract(const Duration(days: 1)))}',
      landscape: true,
      headers: [
        'الفترة',
        'الفواتير',
        'المبيعات ل.س',
        'المبيعات \$',
        'المرتجعات ل.س',
        'التكلفة \$',
        'الربح \$',
        'نسبة الربح',
      ],
      rows: [
        for (final r in _rows)
          [
            r.period,
            '${r.count}',
            fmtSypPlain(r.salesSyp),
            fmtUsdPlain(roundTo(r.salesUsd, 2)),
            fmtSypPlain(r.returnsSyp),
            fmtUsdPlain(roundTo(r.costUsd - r.returnsCostUsd, 2)),
            fmtUsdPlain(roundTo(r.profitUsd, 2)),
            '${roundTo(r.marginPct, 1)}%',
          ],
      ],
      summary: [
        ('صافي المبيعات', '${fmtSyp(t.netSalesSyp)} (${fmtUsd(roundTo(t.netSalesUsd, 2))})'),
        ('إجمالي الربح', fmtUsd(roundTo(t.profitUsd, 2))),
        ('المصاريف', '${fmtSyp(_expenses.$1)} + ${fmtUsd(_expenses.$2)}'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = _total;
    final rate = st.rate;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionTitle(
          'التقارير والأرباح',
          icon: Icons.bar_chart,
          actions: [
            OutlinedButton.icon(
              onPressed: t == null ? null : _print,
              icon: const Icon(Icons.print),
              label: const Text('طباعة'),
            ),
          ],
        ),
        DateRangeBar(
          from: _from,
          to: _to,
          onChanged: (f, to) {
            _from = f;
            _to = to;
            _load();
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'day', label: Text('يومي')),
                ButtonSegment(value: 'month', label: Text('شهري')),
              ],
              selected: {_group},
              onSelectionChanged: (v) {
                _group = v.first;
                _load();
              },
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 220,
              child: DropdownButtonFormField<int?>(
                initialValue: _userId,
                decoration: const InputDecoration(labelText: 'الصيدلي'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('الكل')),
                  for (final u in _users) DropdownMenuItem(value: u.id, child: Text(u.fullName)),
                ],
                onChanged: (v) {
                  _userId = v;
                  _load();
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        if (t != null)
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              StatCard(
                title: 'صافي المبيعات',
                value: fmtSyp(t.netSalesSyp),
                sub: '${t.count} فاتورة • ${fmtUsd(roundTo(t.netSalesUsd, 2))}',
                icon: Icons.point_of_sale,
              ),
              StatCard(
                title: 'تكلفة البضاعة المباعة',
                value: fmtUsd(roundTo(t.costUsd - t.returnsCostUsd, 2)),
                icon: Icons.shopping_bag,
                color: Colors.blueGrey,
              ),
              StatCard(
                title: 'إجمالي الربح',
                value: fmtUsd(roundTo(t.profitUsd, 2)),
                sub: '≈ ${fmtSyp(roundTo(t.profitUsd * rate, 0))} • ${roundTo(t.marginPct, 1)}%',
                icon: Icons.trending_up,
                color: kSuccess,
              ),
              StatCard(title: 'المرتجعات', value: fmtSyp(t.returnsSyp), icon: Icons.assignment_return, color: kWarning),
              StatCard(
                title: 'المصاريف من الدرج',
                value: fmtSyp(_expenses.$1),
                sub: _expenses.$2 > 0 ? '+ ${fmtUsd(_expenses.$2)}' : null,
                icon: Icons.money_off,
                color: kDanger,
              ),
            ],
          ),
        const SizedBox(height: 18),
        const Text('حسب الفترة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _bars(),
        const SizedBox(height: 8),
        SizedBox(
          height: 360,
          child: SimpleTable(
            columns: const ['الفترة', 'الفواتير', 'المبيعات', 'المرتجعات', 'التكلفة', 'الربح', 'النسبة'],
            rows: [
              for (final r in _rows.reversed)
                [
                  Text(r.period),
                  Text('${r.count}'),
                  Text(fmtSyp(r.salesSyp)),
                  Text(r.returnsSyp > 0 ? fmtSyp(r.returnsSyp) : '-'),
                  Text(fmtUsd(roundTo(r.costUsd - r.returnsCostUsd, 2))),
                  Text(
                    fmtUsd(roundTo(r.profitUsd, 2)),
                    style: const TextStyle(color: kSuccess, fontWeight: FontWeight.bold),
                  ),
                  Text('${roundTo(r.marginPct, 1)}%'),
                ],
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('الأدوية الأكثر مبيعاً', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 380,
                    child: SimpleTable(
                      columns: const ['الدواء', 'المبيعات', 'الربح \$'],
                      rows: [
                        for (final i in _top)
                          [
                            Text(i.name),
                            Text(fmtSyp(i.salesSyp)),
                            Text(fmtUsd(roundTo(i.salesSyp / (rate <= 0 ? 1 : rate) - i.costUsd, 2))),
                          ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('حسب الصيدلي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 380,
                    child: SimpleTable(
                      columns: const ['الصيدلي', 'الفواتير', 'المبيعات', 'الربح'],
                      rows: [
                        for (final u in _byUser)
                          [
                            Text(u.name),
                            Text('${u.count}'),
                            Text(fmtSyp(u.salesSyp)),
                            Text(fmtUsd(roundTo(u.profitUsd, 2))),
                          ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// رسم أعمدة بسيط للمبيعات والربح
  Widget _bars() {
    if (_rows.isEmpty) return const SizedBox();
    final maxV = _rows.map((r) => r.netSalesUsd).fold<double>(0, (a, b) => b > a ? b : a);
    if (maxV <= 0) return const SizedBox();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: 180,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final r in _rows.length > 31 ? _rows.sublist(_rows.length - 31) : _rows)
                Expanded(
                  child: Tooltip(
                    message:
                        '${r.period}\nمبيعات: ${fmtUsd(roundTo(r.netSalesUsd, 2))}\nربح: ${fmtUsd(roundTo(r.profitUsd, 2))}',
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                height: 150 * (r.netSalesUsd / maxV).clamp(0, 1),
                                decoration: BoxDecoration(
                                  color: kPrimary.withValues(alpha: 0.35),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              Container(
                                height: 150 * (r.profitUsd / maxV).clamp(0, 1),
                                decoration: BoxDecoration(color: kSuccess, borderRadius: BorderRadius.circular(3)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(r.period.split('/').last, style: const TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
