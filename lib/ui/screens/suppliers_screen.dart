import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/money.dart';
import '../../data/database.dart';
import '../../printing/printer.dart';
import '../../services/party_service.dart';
import '../../services/shift_service.dart';
import '../widgets/common.dart';

Future<Supplier?> showSupplierForm(BuildContext context, {Supplier? existing}) async {
  final name = TextEditingController(text: existing?.name);
  final phone = TextEditingController(text: existing?.phone);
  final address = TextEditingController(text: existing?.address);
  final notes = TextEditingController(text: existing?.notes);
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(existing == null ? 'مورد جديد' : 'تعديل مورد'),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'اسم المورد / المستودع *'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phone,
              decoration: const InputDecoration(labelText: 'الهاتف'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: address,
              decoration: const InputDecoration(labelText: 'العنوان'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: notes,
              decoration: const InputDecoration(labelText: 'ملاحظات'),
            ),
          ],
        ),
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
    () => st.s.suppliers.save(
      actor: st.user!,
      existing: existing,
      name: name.text,
      phone: phone.text,
      address: address.text,
      notes: notes.text,
    ),
  );
}

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  List<SupplierWithBalance> _list = [];
  final _q = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final l = await AppState.I.s.suppliers.list(search: _q.text);
    if (mounted) setState(() => _list = l);
  }

  @override
  Widget build(BuildContext context) {
    final total = _list.fold<double>(0, (a, s) => a + s.balanceUsd);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionTitle(
            'الموردون والمستودعات',
            icon: Icons.warehouse_outlined,
            actions: [
              FilledButton.icon(
                onPressed: () async {
                  await showSupplierForm(context);
                  _load();
                },
                icon: const Icon(Icons.add_business),
                label: const Text('مورد جديد'),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 340,
                child: TextField(
                  controller: _q,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'بحث'),
                  onChanged: (_) => _load(),
                ),
              ),
              const Spacer(),
              Text(
                'إجمالي المستحق للموردين: ${fmtUsd(roundTo(total, 2))}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: kDanger),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: SimpleTable(
              columns: const ['المورد', 'الهاتف', 'العنوان', 'المستحق له'],
              rows: [
                for (final s in _list)
                  [
                    Text(s.supplier.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(s.supplier.phone ?? ''),
                    Text(s.supplier.address ?? ''),
                    Text(
                      fmtUsd(roundTo(s.balanceUsd, 2)),
                      style: TextStyle(color: s.balanceUsd > 0.001 ? kDanger : kSuccess, fontWeight: FontWeight.bold),
                    ),
                  ],
              ],
              onTaps: [
                for (final s in _list)
                  () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SupplierStatementScreen(supplier: s.supplier)),
                    );
                    _load();
                  },
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SupplierStatementScreen extends StatefulWidget {
  final Supplier supplier;
  const SupplierStatementScreen({super.key, required this.supplier});

  @override
  State<SupplierStatementScreen> createState() => _SupplierStatementScreenState();
}

class _SupplierStatementScreenState extends State<SupplierStatementScreen> {
  late Supplier _s = widget.supplier;
  List<SupplierTransaction> _tx = [];
  double _balance = 0;

  AppState get st => AppState.I;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final tx = await st.s.suppliers.statement(_s.id);
    final b = await st.s.suppliers.balanceUsd(_s.id);
    if (mounted) {
      setState(() {
        _tx = tx;
        _balance = b;
      });
    }
  }

  Future<void> _pay() async {
    final amount = TextEditingController(text: roundTo(_balance > 0 ? _balance : 0, 2).toString());
    var currency = currencyUsd;
    var fromDrawer = st.shift != null;
    final note = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setD) => AlertDialog(
          title: Text('دفعة للمورد: ${_s.name}'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('المستحق: ${fmtUsd(roundTo(_balance, 2))}'),
                const SizedBox(height: 12),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: currencyUsd, label: Text('دولار')),
                    ButtonSegment(value: currencySyp, label: Text('ليرة')),
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
                if (st.shift != null)
                  CheckboxListTile(
                    value: fromDrawer,
                    title: const Text('الدفع من درج ورديتي الحالية'),
                    onChanged: (v) => setD(() => fromDrawer = v ?? false),
                  ),
                TextField(
                  controller: note,
                  decoration: const InputDecoration(labelText: 'ملاحظة'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('دفع')),
          ],
        ),
      ),
    );
    if (ok != true || !mounted) return;
    await guard(
      context,
      () => st.s.suppliers.pay(
        actor: st.user!,
        supplier: _s,
        currency: currency,
        amount: parseNum(amount.text) ?? 0,
        rate: st.rate,
        fromShift: fromDrawer ? st.shift : null,
        note: note.text.trim().isEmpty ? null : note.text.trim(),
      ),
      success: 'تم تسجيل الدفعة',
    );
    _load();
  }

  @override
  Widget build(BuildContext context) {
    var running = 0.0;
    final rows = <List<String>>[];
    for (final t in _tx) {
      running += t.amountUsd;
      rows.add([
        fmtDateTime(t.createdAt),
        supplierTxLabel(t.type),
        t.note ?? '',
        t.amountUsd > 0 ? fmtUsd(roundTo(t.amountUsd, 2)) : '',
        t.amountUsd < 0 ? fmtUsd(roundTo(-t.amountUsd, 2)) : '',
        t.currency == currencySyp && t.originalAmount != 0 ? fmtSyp(t.originalAmount) : '',
        fmtUsd(roundTo(running, 2)),
      ]);
    }
    return Scaffold(
      appBar: AppBar(title: Text('كشف حساب المورد: ${_s.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                StatCard(
                  title: 'المستحق للمورد',
                  value: fmtUsd(roundTo(_balance, 2)),
                  sub: '≈ ${fmtSyp(roundTo(_balance * st.rate, 0))}',
                  icon: Icons.account_balance,
                  color: _balance > 0 ? kDanger : kSuccess,
                ),
                FilledButton.icon(onPressed: _pay, icon: const Icon(Icons.payments), label: const Text('تسجيل دفعة')),
                OutlinedButton.icon(
                  onPressed: () async {
                    final s = await showSupplierForm(context, existing: _s);
                    if (s != null) setState(() => _s = s);
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('تعديل البيانات'),
                ),
                OutlinedButton.icon(
                  onPressed: () => AppPrinter.printTable(
                    title: 'كشف حساب المورد: ${_s.name}',
                    headers: ['التاريخ', 'البيان', 'ملاحظة', 'له', 'دُفع', 'بالليرة', 'الرصيد'],
                    rows: rows,
                    summary: [('المستحق', fmtUsd(roundTo(_balance, 2)))],
                  ),
                  icon: const Icon(Icons.print),
                  label: const Text('طباعة'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SimpleTable(
                columns: const ['التاريخ', 'البيان', 'ملاحظة', 'له (مدين)', 'دُفع', 'بالليرة', 'الرصيد'],
                rows: [for (final r in rows.reversed) r.map((e) => Text(e)).toList()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
