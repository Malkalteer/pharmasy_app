import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/money.dart';
import '../../core/permissions.dart';
import '../../core/units.dart';
import '../../data/database.dart';
import '../../services/inventory_service.dart';
import '../../services/party_service.dart';
import '../../services/returns_service.dart';
import '../../services/sales_service.dart';
import '../../services/shift_service.dart';
import '../widgets/common.dart';
import 'home_shell.dart';

class ReturnsScreen extends StatelessWidget {
  const ReturnsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final u = AppState.I.user!;
    final tabs = <(String, IconData, Widget)>[
      if (u.can(Permission.returns)) ('مرتجع من زبون', Icons.person, const RequireShift(child: _CustomerReturnTab())),
      if (u.can(Permission.managePurchases)) ('مرتجع إلى مورد', Icons.warehouse, const _SupplierReturnTab()),
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TabBar(
            isScrollable: true,
            labelStyle: const TextStyle(fontFamily: 'Tajawal', fontWeight: FontWeight.bold, fontSize: 16),
            tabs: [for (final t in tabs) Tab(text: t.$1, icon: Icon(t.$2))],
          ),
          const SizedBox(height: 12),
          Expanded(child: TabBarView(children: [for (final t in tabs) t.$3])),
        ]),
      ),
    );
  }
}

class _CustomerReturnTab extends StatefulWidget {
  const _CustomerReturnTab();

  @override
  State<_CustomerReturnTab> createState() => _CustomerReturnTabState();
}

class _CustomerReturnTabState extends State<_CustomerReturnTab> {
  final _invoice = TextEditingController();
  SaleDetails? _d;
  final Map<int, TextEditingController> _qty = {};
  final Map<int, bool> _restock = {};
  double _debtLeft = 0;

  AppState get st => AppState.I;

  Future<void> _load() async {
    final id = parseInt(_invoice.text);
    if (id == null) return;
    final d = await st.s.sales.details(id);
    if (d == null) {
      if (mounted) showError(context, 'لا توجد فاتورة بهذا الرقم');
      setState(() => _d = null);
      return;
    }
    final rets = await st.s.returns.customerReturnsOf(id);
    _qty.clear();
    _restock.clear();
    for (final it in d.items) {
      _qty[it.id] = TextEditingController(text: '0');
      _restock[it.id] = true;
    }
    setState(() {
      _d = d;
      _debtLeft = d.sale.debtSyp - rets.fold<double>(0, (a, r) => a + r.debtReducedSyp);
    });
  }

  double get _total {
    final d = _d;
    if (d == null) return 0;
    var t = 0.0;
    for (final it in d.items) {
      final q = parseInt(_qty[it.id]?.text) ?? 0;
      if (q > 0) t += ReturnsService.lineRefund(d.sale, it, q);
    }
    return roundTo(t, 2);
  }

  Future<void> _save() async {
    final d = _d!;
    final lines = <CustomerReturnLine>[];
    for (final it in d.items) {
      final q = parseInt(_qty[it.id]?.text) ?? 0;
      if (q > 0) lines.add(CustomerReturnLine(it, q, restock: _restock[it.id] ?? true));
    }
    if (lines.isEmpty) {
      showError(context, 'حدد الكمية المرتجعة');
      return;
    }
    final total = _total;
    final debtPart = _debtLeft > 0 ? (total < _debtLeft ? total : _debtLeft) : 0.0;
    final cash = roundTo(total - debtPart, 2);
    if (!await confirm(
        context,
        'تأكيد المرتجع',
        'قيمة المرتجع: ${fmtSyp(total)}\n'
            '${debtPart > 0 ? 'يُخصم من دين الزبون: ${fmtSyp(debtPart)}\n' : ''}'
            '${cash > 0 ? 'يُعاد للزبون نقداً من الدرج: ${fmtSyp(cash)}' : ''}')) {
      return;
    }
    if (!mounted) return;
    final r = await guard(
      context,
      () => st.s.returns.customerReturn(actor: st.user!, shift: st.shift!, sale: d.sale, lines: lines),
      success: 'تم تسجيل المرتجع',
    );
    if (r != null) _load();
  }

  @override
  Widget build(BuildContext context) {
    final d = _d;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        SizedBox(
          width: 240,
          child: NumField(controller: _invoice, label: 'رقم الفاتورة', decimal: false, autofocus: true, onSubmitted: (_) => _load()),
        ),
        const SizedBox(width: 10),
        FilledButton.icon(onPressed: _load, icon: const Icon(Icons.search), label: const Text('عرض الفاتورة')),
      ]),
      const SizedBox(height: 12),
      if (d == null)
        const Expanded(child: EmptyState('أدخل رقم الفاتورة المطبوع على إيصال الزبون', icon: Icons.receipt))
      else if (d.sale.status != 'completed')
        const Expanded(child: EmptyState('هذه الفاتورة ملغاة', icon: Icons.block))
      else ...[
        Text('تاريخ الفاتورة: ${fmtDateTime(d.sale.createdAt)}   •   الإجمالي: ${fmtSyp(d.sale.totalSyp)}'
            '${d.customer != null ? '   •   الزبون: ${d.customer!.name}' : ''}'
            '${_debtLeft > 0 ? '   •   دين متبقٍ على الفاتورة: ${fmtSyp(_debtLeft)}' : ''}'),
        const SizedBox(height: 10),
        Expanded(
          child: SimpleTable(
            columns: const ['الصنف', 'المباع', 'القابل للإرجاع', 'الكمية المرتجعة', 'يعود للمخزون', 'القيمة'],
            rows: [
              for (final it in d.items)
                [
                  Text(it.medicineName),
                  Text('${it.quantity} ${it.unitLabel}'),
                  Text('${ReturnsService.returnableQty(it)} ${it.unitLabel}'),
                  SizedBox(
                    width: 90,
                    child: NumField(
                      controller: _qty[it.id]!,
                      label: '',
                      decimal: false,
                      enabled: ReturnsService.returnableQty(it) > 0,
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  Checkbox(value: _restock[it.id], onChanged: (v) => setState(() => _restock[it.id] = v ?? true)),
                  Text(fmtSyp(ReturnsService.lineRefund(d.sale, it, parseInt(_qty[it.id]!.text) ?? 0))),
                ],
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(children: [
          Text('قيمة المرتجع: ${fmtSyp(_total)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Spacer(),
          FilledButton.icon(onPressed: _save, icon: const Icon(Icons.assignment_return), label: const Text('تسجيل المرتجع')),
        ]),
        const SizedBox(height: 4),
        Text('ألغِ تحديد "يعود للمخزون" إذا كان الدواء المرتجع تالفاً ولا يصلح للبيع.',
            style: TextStyle(color: Colors.grey.shade600)),
      ],
    ]);
  }
}

class _SupplierReturnTab extends StatefulWidget {
  const _SupplierReturnTab();

  @override
  State<_SupplierReturnTab> createState() => _SupplierReturnTabState();
}

class _SRLine {
  final StockBatch batch;
  final Medicine medicine;
  final boxes = TextEditingController(text: '0');
  final units = TextEditingController(text: '0');
  _SRLine(this.batch, this.medicine);
  int get base => (parseInt(boxes.text) ?? 0) * medicine.basePerBox + (parseInt(units.text) ?? 0);
}

class _SupplierReturnTabState extends State<_SupplierReturnTab> {
  List<SupplierWithBalance> _suppliers = [];
  Supplier? _supplier;
  final _search = TextEditingController();
  List<MedicineStock> _results = [];
  final List<_SRLine> _lines = [];
  String _settlement = 'credit';
  String _cashCurrency = currencyUsd;
  final _note = TextEditingController();

  AppState get st => AppState.I;

  @override
  void initState() {
    super.initState();
    st.s.suppliers.list().then((l) {
      if (mounted) setState(() => _suppliers = l);
    });
  }

  Future<void> _pickBatch(Medicine m) async {
    final batches = await st.s.inventory.batchesOf(m.id, onlyAvailable: true);
    if (!mounted) return;
    if (batches.isEmpty) {
      showError(context, 'لا توجد كمية من هذا الدواء');
      return;
    }
    final b = batches.length == 1
        ? batches.first
        : await showDialog<StockBatch>(
            context: context,
            builder: (ctx) => SimpleDialog(
              title: Text('اختر الدفعة: ${m.name}'),
              children: [
                for (final b in batches)
                  SimpleDialogOption(
                    onPressed: () => Navigator.pop(ctx, b),
                    child: Text('انتهاء ${fmtDate(b.expiryDate)}  •  ${m.describeQty(b.quantity)}  •  تشغيلة ${b.batchNumber ?? '-'}'),
                  ),
              ],
            ),
          );
    if (b == null) return;
    setState(() {
      _lines.add(_SRLine(b, m));
      _results = [];
      _search.clear();
    });
  }

  Future<void> _save() async {
    if (_supplier == null) {
      showError(context, 'اختر المورد');
      return;
    }
    final lines = [
      for (final l in _lines)
        if (l.base > 0) SupplierReturnLine(l.batch, l.medicine, l.base),
    ];
    if (lines.isEmpty) {
      showError(context, 'حدد الكميات');
      return;
    }
    if (_settlement == 'cash' && st.shift == null) {
      await showOpenShiftDialog(context);
      if (st.shift == null) return;
    }
    if (!mounted) return;
    final r = await guard(
      context,
      () => st.s.returns.supplierReturn(
        actor: st.user!,
        supplier: _supplier!,
        lines: lines,
        settlement: _settlement,
        shift: st.shift,
        cashCurrency: _cashCurrency,
        rate: st.rate,
        note: _note.text.trim().isEmpty ? null : _note.text.trim(),
      ),
      success: 'تم تسجيل المرتجع إلى المورد',
    );
    if (r != null) setState(_lines.clear);
  }

  @override
  Widget build(BuildContext context) {
    final total = _lines.fold<double>(0, (a, l) => a + l.medicine.costOf(l.base, l.batch.costUsdPerBox));
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        SizedBox(
          width: 300,
          child: DropdownButtonFormField<int>(
            initialValue: _supplier?.id,
            decoration: const InputDecoration(labelText: 'المورد'),
            items: [for (final s in _suppliers) DropdownMenuItem(value: s.supplier.id, child: Text(s.supplier.name))],
            onChanged: (v) => setState(() => _supplier = _suppliers.firstWhere((s) => s.supplier.id == v).supplier),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _search,
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'ابحث عن الدواء المراد إرجاعه'),
            onChanged: (v) async {
              final r = v.trim().isEmpty ? <MedicineStock>[] : await st.s.inventory.listWithStock(search: v, limit: 12);
              if (mounted) setState(() => _results = r);
            },
          ),
        ),
      ]),
      if (_results.isNotEmpty)
        Card(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView(shrinkWrap: true, children: [
              for (final r in _results)
                ListTile(
                  dense: true,
                  title: Text(r.medicine.name),
                  subtitle: Text('المتوفر: ${r.medicine.describeQty(r.available + r.expired)}'),
                  onTap: () => _pickBatch(r.medicine),
                ),
            ]),
          ),
        ),
      const SizedBox(height: 10),
      Expanded(
        child: SimpleTable(
          columns: const ['الدواء', 'الدفعة', 'المتوفر', 'علب', 'حبات', 'القيمة (تكلفة)', ''],
          rows: [
            for (final l in _lines)
              [
                Text(l.medicine.name),
                Text('${fmtDate(l.batch.expiryDate)} / ${l.batch.batchNumber ?? '-'}'),
                Text(l.medicine.describeQty(l.batch.quantity)),
                SizedBox(width: 80, child: NumField(controller: l.boxes, label: '', decimal: false, onChanged: (_) => setState(() {}))),
                SizedBox(width: 80, child: NumField(controller: l.units, label: '', decimal: false, onChanged: (_) => setState(() {}))),
                Text(fmtUsd(roundTo(l.medicine.costOf(l.base, l.batch.costUsdPerBox), 2))),
                IconButton(icon: const Icon(Icons.close, color: kDanger), onPressed: () => setState(() => _lines.remove(l))),
              ],
          ],
        ),
      ),
      const SizedBox(height: 10),
      Row(children: [
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'credit', label: Text('خصم من حساب المورد')),
            ButtonSegment(value: 'cash', label: Text('استلام نقدي')),
          ],
          selected: {_settlement},
          onSelectionChanged: (v) => setState(() => _settlement = v.first),
        ),
        if (_settlement == 'cash') ...[
          const SizedBox(width: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: currencyUsd, label: Text('\$')),
              ButtonSegment(value: currencySyp, label: Text('ل.س')),
            ],
            selected: {_cashCurrency},
            onSelectionChanged: (v) => setState(() => _cashCurrency = v.first),
          ),
        ],
        const SizedBox(width: 10),
        Expanded(child: TextField(controller: _note, decoration: const InputDecoration(labelText: 'ملاحظة / السبب'))),
        const SizedBox(width: 16),
        Text('القيمة: ${fmtUsd(roundTo(total, 2))}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        const SizedBox(width: 16),
        FilledButton.icon(onPressed: _save, icon: const Icon(Icons.save), label: const Text('حفظ المرتجع')),
      ]),
    ]);
  }
}
