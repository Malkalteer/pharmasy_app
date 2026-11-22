import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/money.dart';
import '../../core/permissions.dart';
import '../../data/database.dart';
import '../../printing/printer.dart';
import '../../services/shift_service.dart';
import '../widgets/common.dart';
import 'home_shell.dart';

/// الدرج المالي: الرصيد الحالي، الحركات، المصاريف، وإغلاق الوردية وتسليم النقود
class ShiftScreen extends StatefulWidget {
  const ShiftScreen({super.key});

  @override
  State<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
  ShiftSummary? _sum;
  List<CashMovement> _mv = [];
  List<Shift> _history = [];
  List<User> _users = [];

  AppState get st => AppState.I;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final u = st.user!;
    final users = await st.s.users.list();
    ShiftSummary? sum;
    var mv = <CashMovement>[];
    if (st.shift != null) {
      sum = await st.s.shifts.summary(st.shift!);
      mv = await st.s.shifts.movements(st.shift!.id);
    }
    final hist = await st.s.shifts.list(userId: u.can(Permission.viewAllShifts) ? null : u.id, limit: 100);
    if (mounted) {
      setState(() {
        _sum = sum;
        _mv = mv;
        _history = hist;
        _users = users;
      });
    }
  }

  String _name(int? id) => _users.where((u) => u.id == id).firstOrNull?.fullName ?? '-';

  Future<void> _movement(String type) async {
    final amount = TextEditingController();
    final note = TextEditingController();
    var currency = currencySyp;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setD) => AlertDialog(
          title: Text(CashTypes.label(type)),
          content: SizedBox(
            width: 380,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: currencySyp, label: Text('ليرة')),
                    ButtonSegment(value: currencyUsd, label: Text('دولار')),
                  ],
                  selected: {currency},
                  onSelectionChanged: (v) => setD(() => currency = v.first),
                ),
                const SizedBox(height: 12),
                NumField(
                  controller: amount,
                  label: 'المبلغ',
                  autofocus: true,
                  suffix: currency == currencyUsd ? '\$' : 'ل.س',
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: note,
                  decoration: const InputDecoration(labelText: 'البيان (مثلاً: كهرباء، أجرة...)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('حفظ')),
          ],
        ),
      ),
    );
    if (ok != true || !mounted) return;
    await guard(
      context,
      () => st.s.shifts.manualMovement(
        user: st.user!,
        shift: st.shift!,
        type: type,
        currency: currency,
        amount: parseNum(amount.text) ?? 0,
        note: note.text.trim().isEmpty ? null : note.text.trim(),
      ),
      success: 'تم التسجيل',
    );
    _load();
  }

  Future<void> _close() async {
    final sum = _sum!;
    final syp = TextEditingController();
    final usd = TextEditingController();
    final note = TextEditingController();
    final owners = _users.where((u) => u.active && u.id != st.user!.id).toList();
    int? receiver = owners.where((u) => u.isOwner).firstOrNull?.id;
    final ok = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setD) {
          final aS = parseNum(syp.text);
          final aU = parseNum(usd.text);
          Widget diff(double? actual, double expected, bool isSyp) {
            if (actual == null) return const SizedBox();
            final d = roundTo(actual - expected, 2);
            final f = isSyp ? fmtSyp(d.abs()) : fmtUsd(d.abs());
            if (d.abs() < 0.001)
              return const Text(
                '✔ مطابق',
                style: TextStyle(color: kSuccess, fontWeight: FontWeight.bold),
              );
            return Text(
              d > 0 ? 'زيادة $f' : 'عجز $f',
              style: TextStyle(color: d > 0 ? kWarning : kDanger, fontWeight: FontWeight.bold),
            );
          }

          return AlertDialog(
            title: const Text('إغلاق الوردية وتسليم الدرج'),
            content: SizedBox(
              width: 520,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('اعدد النقود الموجودة في الدرج وأدخلها:'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'المتوقع: ${fmtSyp(sum.balance.syp)}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            NumField(
                              controller: syp,
                              label: 'الموجود فعلياً بالليرة',
                              suffix: 'ل.س',
                              autofocus: true,
                              onChanged: (_) => setD(() {}),
                            ),
                            const SizedBox(height: 4),
                            diff(aS, sum.balance.syp, true),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'المتوقع: ${fmtUsd(sum.balance.usd)}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            NumField(
                              controller: usd,
                              label: 'الموجود فعلياً بالدولار',
                              suffix: '\$',
                              onChanged: (_) => setD(() {}),
                            ),
                            const SizedBox(height: 4),
                            diff(aU, sum.balance.usd, false),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<int?>(
                    initialValue: receiver,
                    decoration: const InputDecoration(labelText: 'المستلم'),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('-')),
                      for (final u in owners)
                        DropdownMenuItem(value: u.id, child: Text('${u.fullName} (${roleLabel(u.role)})')),
                    ],
                    onChanged: (v) => setD(() => receiver = v),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: note,
                    decoration: const InputDecoration(labelText: 'ملاحظة'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء')),
              FilledButton(
                onPressed: parseNum(syp.text) == null && parseNum(usd.text) == null
                    ? null
                    : () => Navigator.pop(ctx, true),
                child: const Text('إغلاق الوردية'),
              ),
            ],
          );
        },
      ),
    );
    if (ok != true || !mounted) return;
    final closed = await guard(
      context,
      () => st.s.shifts.close(
        user: st.user!,
        shift: st.shift!,
        actualSyp: parseNum(syp.text) ?? 0,
        actualUsd: parseNum(usd.text) ?? 0,
        receivedById: receiver,
        note: note.text.trim().isEmpty ? null : note.text.trim(),
      ),
      success: 'تم إغلاق الوردية وتصفير الدرج',
    );
    if (closed == null) return;
    final s2 = await st.s.shifts.summary(closed);
    try {
      await AppPrinter.printShiftReport(s2, st.user!.fullName, receiver == null ? null : _name(receiver));
    } catch (e) {
      if (mounted) showError(context, 'تعذّرت طباعة التقرير: $e');
    }
    await st.setShift(null);
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final u = st.user!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          SectionTitle(
            'الدرج والوردية',
            icon: Icons.account_balance_wallet_outlined,
            actions: [
              if (st.shift == null)
                FilledButton.icon(
                  onPressed: () async {
                    await showOpenShiftDialog(context);
                    _load();
                  },
                  icon: const Icon(Icons.lock_open),
                  label: const Text('فتح وردية'),
                ),
              if (st.shift != null) ...[
                OutlinedButton.icon(
                  onPressed: () => _movement(CashTypes.expense),
                  icon: const Icon(Icons.money_off),
                  label: const Text('مصروف'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _movement(CashTypes.withdrawal),
                  icon: const Icon(Icons.outbox),
                  label: const Text('سحب'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _movement(CashTypes.deposit),
                  icon: const Icon(Icons.move_to_inbox),
                  label: const Text('إيداع'),
                ),
                FilledButton.icon(
                  style: FilledButton.styleFrom(backgroundColor: kDanger),
                  onPressed: _sum == null ? null : _close,
                  icon: const Icon(Icons.lock),
                  label: const Text('إغلاق الوردية وتسليم الدرج'),
                ),
              ],
            ],
          ),
          if (_sum != null) ...[
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                StatCard(
                  title: 'في الدرج (ليرة)',
                  value: fmtSyp(_sum!.balance.syp),
                  icon: Icons.payments,
                  color: kPrimary,
                ),
                StatCard(
                  title: 'في الدرج (دولار)',
                  value: fmtUsd(_sum!.balance.usd),
                  icon: Icons.attach_money,
                  color: kSuccess,
                ),
                StatCard(
                  title: 'مبيعات الوردية',
                  value: fmtSyp(_sum!.salesTotalSyp),
                  sub: '${_sum!.salesCount} فاتورة',
                  icon: Icons.receipt_long,
                ),
                if (_sum!.debtSalesSyp > 0)
                  StatCard(
                    title: 'منها بالدين',
                    value: fmtSyp(_sum!.debtSalesSyp),
                    icon: Icons.person,
                    color: kWarning,
                  ),
                StatCard(
                  title: 'بداية الوردية',
                  value: fmtDateTime(_sum!.shift.openedAt),
                  icon: Icons.schedule,
                  color: Colors.blueGrey,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('حركات الدرج', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            SizedBox(
              height: 320,
              child: SimpleTable(
                columns: const ['الوقت', 'النوع', 'المبلغ', 'مرجع', 'البيان'],
                rows: [
                  for (final m in _mv.reversed)
                    [
                      Text(fmtDateTime(m.createdAt)),
                      Text(CashTypes.label(m.type)),
                      Text(
                        m.currency == currencyUsd ? fmtUsd(m.amount) : fmtSyp(m.amount),
                        style: TextStyle(color: m.amount < 0 ? kDanger : kSuccess, fontWeight: FontWeight.w600),
                      ),
                      Text(m.refId == null ? '' : '#${m.refId}'),
                      Text(m.note ?? ''),
                    ],
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          Text(
            u.can(Permission.viewAllShifts) ? 'سجل الورديات (جميع الصيادلة)' : 'سجل وردياتي',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 420,
            child: SimpleTable(
              columns: const ['#', 'الصيدلي', 'البداية', 'النهاية', 'المتوقع', 'الفعلي', 'الفرق', 'المستلم'],
              rows: [
                for (final s in _history)
                  [
                    Text('${s.id}'),
                    Text(_name(s.userId)),
                    Text(fmtDateTime(s.openedAt)),
                    s.status == 'open' ? const Badge2('مفتوحة', color: kSuccess) : Text(fmtDateTime(s.closedAt)),
                    Text(s.expectedSyp == null ? '-' : '${fmtSyp(s.expectedSyp!)}\n${fmtUsd(s.expectedUsd ?? 0)}'),
                    Text(s.actualSyp == null ? '-' : '${fmtSyp(s.actualSyp!)}\n${fmtUsd(s.actualUsd ?? 0)}'),
                    _diffText(s),
                    Text(_name(s.receivedById)),
                  ],
              ],
              onTaps: [
                for (final s in _history)
                  () async {
                    final sum = await st.s.shifts.summary(s);
                    if (!context.mounted) return;
                    await AppPrinter.printShiftReport(
                      sum,
                      _name(s.userId),
                      s.receivedById == null ? null : _name(s.receivedById),
                    );
                  },
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text('اضغط على أي وردية لطباعة تقريرها.', style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _diffText(Shift s) {
    if (s.diffSyp == null) return const Text('-');
    final parts = <String>[];
    if ((s.diffSyp ?? 0).abs() > 0.001) parts.add('${s.diffSyp! > 0 ? '+' : ''}${fmtSyp(s.diffSyp!)}');
    if ((s.diffUsd ?? 0).abs() > 0.001) parts.add('${s.diffUsd! > 0 ? '+' : ''}${fmtUsd(s.diffUsd!)}');
    if (parts.isEmpty) return const Text('مطابق', style: TextStyle(color: kSuccess));
    final neg = (s.diffSyp ?? 0) < 0 || (s.diffUsd ?? 0) < 0;
    return Text(
      parts.join('\n'),
      style: TextStyle(color: neg ? kDanger : kWarning, fontWeight: FontWeight.bold),
    );
  }
}
