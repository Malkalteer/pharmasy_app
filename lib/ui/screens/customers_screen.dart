import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/money.dart';
import '../../core/permissions.dart';
import '../../data/database.dart';
import '../../printing/printer.dart';
import '../../services/party_service.dart';
import '../../services/shift_service.dart';
import '../widgets/common.dart';
import 'home_shell.dart';

Future<Customer?> showCustomerForm(BuildContext context, {Customer? existing, String? initialName}) async {
  final name = TextEditingController(text: existing?.name ?? initialName ?? '');
  final phone = TextEditingController(text: existing?.phone ?? '');
  final notes = TextEditingController(text: existing?.notes ?? '');
  final limit = TextEditingController(text: existing?.creditLimitUsd == null ? '' : '${existing!.creditLimitUsd}');
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(existing == null ? 'زبون جديد' : 'تعديل زبون'),
      content: SizedBox(
        width: 420,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: name, autofocus: true, decoration: const InputDecoration(labelText: 'الاسم *')),
          const SizedBox(height: 10),
          TextField(controller: phone, decoration: const InputDecoration(labelText: 'الهاتف')),
          const SizedBox(height: 10),
          NumField(controller: limit, label: 'سقف الدين بالدولار (اختياري)', suffix: '\$'),
          const SizedBox(height: 10),
          TextField(controller: notes, decoration: const InputDecoration(labelText: 'ملاحظات')),
        ]),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء')),
        FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('حفظ')),
      ],
    ),
  );
  if (ok != true || !context.mounted) return null;
  final st = AppState.I;
  return guard(
    context,
    () => st.s.customers.save(
      actor: st.user!,
      existing: existing,
      name: name.text,
      phone: phone.text,
      notes: notes.text,
      creditLimitUsd: parseNum(limit.text),
    ),
  );
}

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final _q = TextEditingController();
  bool _debtorsOnly = false;
  List<CustomerWithBalance> _list = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final l = await AppState.I.s.customers.list(search: _q.text, onlyDebtors: _debtorsOnly);
    if (mounted) setState(() => _list = l);
  }

  @override
  Widget build(BuildContext context) {
    final rate = AppState.I.rate;
    final totalDebt = _list.fold<double>(0, (s, c) => s + (c.balanceUsd > 0 ? c.balanceUsd : 0));
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SectionTitle('الزبائن والديون', icon: Icons.people_alt_outlined, actions: [
          FilledButton.icon(
            onPressed: () async {
              await showCustomerForm(context);
              _load();
            },
            icon: const Icon(Icons.person_add),
            label: const Text('زبون جديد'),
          ),
          OutlinedButton.icon(
            onPressed: () => AppPrinter.printTable(
              title: 'ديون الزبائن',
              headers: ['الزبون', 'الهاتف', 'الدين بالليرة', 'الدين بالدولار'],
              rows: [
                for (final c in _list.where((c) => c.balanceUsd > 0.0001))
                  [c.customer.name, c.customer.phone ?? '', fmtSyp(roundTo(c.balanceUsd * rate, 0)), fmtUsd(roundTo(c.balanceUsd, 2))],
              ],
              summary: [('الإجمالي', '${fmtSyp(roundTo(totalDebt * rate, 0))} (${fmtUsd(roundTo(totalDebt, 2))})')],
            ),
            icon: const Icon(Icons.print),
            label: const Text('طباعة الديون'),
          ),
        ]),
        Row(children: [
          SizedBox(
            width: 340,
            child: TextField(
              controller: _q,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'بحث بالاسم أو الهاتف'),
              onChanged: (_) => _load(),
            ),
          ),
          const SizedBox(width: 12),
          FilterChip(
            label: const Text('المدينون فقط'),
            selected: _debtorsOnly,
            onSelected: (v) {
              _debtorsOnly = v;
              _load();
            },
          ),
          const Spacer(),
          Text('إجمالي الديون: ${fmtSyp(roundTo(totalDebt * rate, 0))}  (${fmtUsd(roundTo(totalDebt, 2))})',
              style: const TextStyle(fontWeight: FontWeight.bold, color: kDanger)),
        ]),
        const SizedBox(height: 12),
        Expanded(
          child: SimpleTable(
            columns: const ['الزبون', 'الهاتف', 'الدين', 'سقف الدين', 'ملاحظات'],
            rows: [
              for (final c in _list)
                [
                  Text(c.customer.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(c.customer.phone ?? ''),
                  c.balanceUsd.abs() < 0.0001
                      ? const Text('-')
                      : MoneyText(
                          usd: c.balanceUsd,
                          rate: rate,
                          style: TextStyle(color: c.balanceUsd > 0 ? kDanger : kSuccess, fontWeight: FontWeight.bold)),
                  Text(c.customer.creditLimitUsd == null ? '-' : fmtUsd(c.customer.creditLimitUsd!)),
                  Text(c.customer.notes ?? ''),
                ],
            ],
            onTaps: [
              for (final c in _list)
                () async {
                  await Navigator.push(
                      context, MaterialPageRoute(builder: (_) => CustomerStatementScreen(customer: c.customer)));
                  _load();
                },
            ],
          ),
        ),
      ]),
    );
  }
}

class CustomerStatementScreen extends StatefulWidget {
  final Customer customer;
  const CustomerStatementScreen({super.key, required this.customer});

  @override
  State<CustomerStatementScreen> createState() => _CustomerStatementScreenState();
}

class _CustomerStatementScreenState extends State<CustomerStatementScreen> {
  late Customer _c = widget.customer;
  List<CustomerTransaction> _tx = [];
  double _balance = 0;

  AppState get st => AppState.I;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final tx = await st.s.customers.statement(_c.id);
    final b = await st.s.customers.balanceUsd(_c.id);
    if (mounted) {
      setState(() {
        _tx = tx;
        _balance = b;
      });
    }
  }

  Future<void> _receive() async {
    if (st.shift == null) {
      await showOpenShiftDialog(context);
      if (st.shift == null) return;
    }
    if (!mounted) return;
    final amount = TextEditingController(text: fmtSypPlain(roundTo(_balance * st.rate, 0)).replaceAll(',', ''));
    var currency = currencySyp;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setD) => AlertDialog(
          title: const Text('تحصيل دفعة'),
          content: SizedBox(
            width: 380,
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text('الدين الحالي: ${fmtSyp(roundTo(_balance * st.rate, 0))} (${fmtUsd(roundTo(_balance, 2))})'),
              const SizedBox(height: 12),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: currencySyp, label: Text('ليرة')),
                  ButtonSegment(value: currencyUsd, label: Text('دولار')),
                ],
                selected: {currency},
                onSelectionChanged: (v) => setD(() {
                  currency = v.first;
                  amount.text = currency == currencyUsd
                      ? roundTo(_balance, 2).toString()
                      : fmtSypPlain(roundTo(_balance * st.rate, 0)).replaceAll(',', '');
                }),
              ),
              const SizedBox(height: 12),
              NumField(controller: amount, label: 'المبلغ', suffix: currency == currencyUsd ? '\$' : 'ل.س', autofocus: true),
            ]),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('تحصيل')),
          ],
        ),
      ),
    );
    if (ok != true || !mounted) return;
    await guard(
      context,
      () => st.s.customers.receivePayment(
        actor: st.user!,
        shift: st.shift!,
        customer: _c,
        currency: currency,
        amount: parseNum(amount.text) ?? 0,
        rate: st.rate,
      ),
      success: 'تم تسجيل الدفعة في درجك',
    );
    _load();
  }

  Future<void> _adjust() async {
    final v = await promptText(context, 'تسوية / دين سابق',
        label: 'المبلغ بالدولار (موجب = إضافة دين، سالب = إسقاط دين)');
    final a = parseNum(v);
    if (a == null || a == 0 || !mounted) return;
    final note = await promptText(context, 'سبب التسوية', label: 'السبب');
    if (note == null || !mounted) return;
    await guard(context, () => st.s.customers.adjustDebt(actor: st.user!, customer: _c, amountUsd: a, note: note),
        success: 'تم');
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final rate = st.rate;
    var running = 0.0;
    final rows = <List<Widget>>[];
    for (final t in _tx) {
      running += t.amountUsd;
      rows.add([
        Text(fmtDateTime(t.createdAt)),
        Text(customerTxLabel(t.type)),
        Text(t.note ?? ''),
        Text(t.amountUsd > 0 ? fmtUsd(roundTo(t.amountUsd, 2)) : '', style: const TextStyle(color: kDanger)),
        Text(t.amountUsd < 0 ? fmtUsd(roundTo(-t.amountUsd, 2)) : '', style: const TextStyle(color: kSuccess)),
        Text(t.originalAmount == 0 ? '' : (t.currency == currencyUsd ? fmtUsd(t.originalAmount.abs()) : fmtSyp(t.originalAmount.abs()))),
        Text(fmtUsd(roundTo(running, 2)), style: const TextStyle(fontWeight: FontWeight.bold)),
      ]);
    }
    return Scaffold(
      appBar: AppBar(title: Text('كشف حساب: ${_c.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Wrap(spacing: 12, runSpacing: 12, crossAxisAlignment: WrapCrossAlignment.center, children: [
            StatCard(
              title: 'الدين الحالي',
              value: fmtSyp(roundTo(_balance * rate, 0)),
              sub: fmtUsd(roundTo(_balance, 2)),
              icon: Icons.account_balance_wallet,
              color: _balance > 0 ? kDanger : kSuccess,
            ),
            if (st.user!.can(Permission.manageCustomers))
              FilledButton.icon(onPressed: _receive, icon: const Icon(Icons.payments), label: const Text('تحصيل دفعة')),
            OutlinedButton.icon(
              onPressed: () async {
                final c = await showCustomerForm(context, existing: _c);
                if (c != null) setState(() => _c = c);
              },
              icon: const Icon(Icons.edit),
              label: const Text('تعديل البيانات'),
            ),
            if (st.user!.isOwner)
              OutlinedButton.icon(onPressed: _adjust, icon: const Icon(Icons.tune), label: const Text('تسوية')),
            OutlinedButton.icon(
              onPressed: () {
                var r = 0.0;
                AppPrinter.printTable(
                  title: 'كشف حساب الزبون: ${_c.name}',
                  subtitle: 'المبالغ بالدولار. الدين بالليرة حسب سعر الصرف الحالي: ${fmtSyp(rate)}',
                  headers: ['التاريخ', 'البيان', 'ملاحظة', 'مدين', 'دائن', 'الرصيد'],
                  rows: [
                    for (final t in _tx)
                      [
                        fmtDateTime(t.createdAt),
                        customerTxLabel(t.type),
                        t.note ?? '',
                        t.amountUsd > 0 ? fmtUsd(roundTo(t.amountUsd, 2)) : '',
                        t.amountUsd < 0 ? fmtUsd(roundTo(-t.amountUsd, 2)) : '',
                        fmtUsd(roundTo(r += t.amountUsd, 2)),
                      ],
                  ],
                  summary: [('الدين الحالي', '${fmtSyp(roundTo(_balance * rate, 0))} (${fmtUsd(roundTo(_balance, 2))})')],
                );
              },
              icon: const Icon(Icons.print),
              label: const Text('طباعة الكشف'),
            ),
          ]),
          const SizedBox(height: 8),
          Text('الديون محفوظة بالدولار وتُعرض بالليرة حسب سعر الصرف الحالي.',
              style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 12),
          Expanded(
            child: SimpleTable(
              columns: const ['التاريخ', 'البيان', 'ملاحظة', 'مدين', 'دائن', 'المبلغ الأصلي', 'الرصيد'],
              rows: rows.reversed.toList(),
            ),
          ),
        ]),
      ),
    );
  }
}
