import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/money.dart';
import '../../core/units.dart';
import '../../data/database.dart';
import '../../services/inventory_service.dart';
import '../../services/party_service.dart';
import '../../services/purchase_service.dart';
import '../../services/shift_service.dart';
import '../widgets/common.dart';
import 'medicines_screen.dart';
import 'suppliers_screen.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({super.key});

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  List<(Purchase, Supplier)> _list = [];
  late DateTime _from = DateTime(DateTime.now().year, DateTime.now().month);
  late DateTime _to = DateTime(DateTime.now().year, DateTime.now().month + 1);

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final l = await AppState.I.s.purchases.list(from: _from, to: _to);
    if (mounted) setState(() => _list = l);
  }

  @override
  Widget build(BuildContext context) {
    final total = _list.fold<double>(0, (a, p) => a + p.$1.totalUsd);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SectionTitle('فواتير الشراء', icon: Icons.local_shipping_outlined, actions: [
          FilledButton.icon(
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => const NewPurchaseScreen()));
              _load();
            },
            icon: const Icon(Icons.add),
            label: const Text('فاتورة شراء جديدة'),
          ),
        ]),
        DateRangeBar(
          from: _from,
          to: _to,
          onChanged: (f, t) {
            _from = f;
            _to = t;
            _load();
          },
        ),
        const SizedBox(height: 8),
        Text('${_list.length} فاتورة  •  الإجمالي ${fmtUsd(roundTo(total, 2))}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Expanded(
          child: SimpleTable(
            columns: const ['#', 'المورد', 'رقم فاتورة المورد', 'التاريخ', 'الإجمالي', 'المدفوع', 'ملاحظات'],
            rows: [
              for (final (p, s) in _list)
                [
                  Text('${p.id}'),
                  Text(s.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(p.invoiceNumber ?? '-'),
                  Text(fmtDate(p.invoiceDate)),
                  Text(fmtUsd(roundTo(p.totalUsd, 2))),
                  Text(fmtUsd(roundTo(p.paidUsd, 2))),
                  Text(p.notes ?? ''),
                ],
            ],
            onTaps: [
              for (final (p, _) in _list) () => showDialog(context: context, builder: (_) => _PurchaseDetailsDialog(id: p.id)),
            ],
          ),
        ),
      ]),
    );
  }
}

class _PurchaseDetailsDialog extends StatelessWidget {
  final int id;
  const _PurchaseDetailsDialog({required this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppState.I.s.purchases.details(id),
      builder: (ctx, snap) {
        final d = snap.data;
        if (d == null) return const AlertDialog(content: SizedBox(height: 100, child: Center(child: CircularProgressIndicator())));
        return AlertDialog(
          title: Text('فاتورة شراء #${d.purchase.id} - ${d.supplier.name}'),
          content: SizedBox(
            width: 760,
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text('رقم فاتورة المورد: ${d.purchase.invoiceNumber ?? '-'}   •   التاريخ: ${fmtDate(d.purchase.invoiceDate)}'),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 380),
                child: SimpleTable(
                  columns: const ['الدواء', 'الكمية', 'بونص', 'سعر الشراء', 'المجموع', 'الانتهاء', 'التشغيلة'],
                  rows: [
                    for (final (it, m) in d.items)
                      [
                        Text(m.name),
                        Text('${it.quantityBoxes} ${m.boxName}'),
                        Text(it.bonusBoxes > 0 ? '${it.bonusBoxes}' : '-'),
                        Text(fmtUsd(it.costUsdPerBox)),
                        Text(fmtUsd(roundTo(it.totalUsd, 2))),
                        Text(fmtDate(it.expiryDate)),
                        Text(it.batchNumber ?? '-'),
                      ],
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Wrap(spacing: 24, children: [
                if (d.purchase.discountUsd > 0) Text('الخصم: ${fmtUsd(d.purchase.discountUsd)}'),
                Text('الإجمالي: ${fmtUsd(roundTo(d.purchase.totalUsd, 2))}', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('المدفوع: ${fmtUsd(roundTo(d.purchase.paidUsd, 2))}'),
              ]),
            ]),
          ),
          actions: [FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('إغلاق'))],
        );
      },
    );
  }
}

/// إدخال فاتورة شراء جديدة
class NewPurchaseScreen extends StatefulWidget {
  const NewPurchaseScreen({super.key});

  @override
  State<NewPurchaseScreen> createState() => _NewPurchaseScreenState();
}

class _LineCtrls {
  final PurchaseLine line;
  final qty = TextEditingController(text: '1');
  final bonus = TextEditingController(text: '0');
  final cost = TextEditingController();
  final expiry = TextEditingController();
  final batch = TextEditingController();
  final price = TextEditingController();
  _LineCtrls(this.line) {
    price.text = fmtUsdPlain(line.medicine.priceUsd).replaceAll(',', '');
  }
}

class _NewPurchaseScreenState extends State<NewPurchaseScreen> {
  List<SupplierWithBalance> _suppliers = [];
  Supplier? _supplier;
  final _invoice = TextEditingController();
  DateTime _date = DateTime.now();
  final _discount = TextEditingController(text: '0');
  final _paid = TextEditingController(text: '0');
  String _paidCurrency = currencyUsd;
  bool _fromDrawer = false;
  final _notes = TextEditingController();
  final _search = TextEditingController();
  final _searchFocus = FocusNode();
  List<MedicineStock> _results = [];
  final List<_LineCtrls> _lines = [];
  bool _busy = false;

  AppState get st => AppState.I;

  @override
  void initState() {
    super.initState();
    _loadSuppliers();
  }

  Future<void> _loadSuppliers() async {
    final l = await st.s.suppliers.list();
    if (mounted) setState(() => _suppliers = l);
  }

  Future<void> _onSearch(String v) async {
    if (v.trim().isEmpty) {
      setState(() => _results = []);
      return;
    }
    final r = await st.s.inventory.listWithStock(search: v, limit: 15);
    if (mounted) setState(() => _results = r);
  }

  Future<void> _onSubmit(String v) async {
    final t = normalizeDigits(v.trim());
    if (t.isEmpty) return;
    final m = await st.s.inventory.byBarcode(t);
    if (m != null) {
      _add(m);
      return;
    }
    final r = await st.s.inventory.listWithStock(search: t, limit: 15);
    if (r.length == 1) {
      _add(r.first.medicine);
    } else if (r.isEmpty && mounted) {
      final isCode = RegExp(r'^\d{6,}$').hasMatch(t);
      if (await confirm(context, 'دواء غير موجود', 'لا يوجد دواء "$t". هل تريد إضافته كدواء جديد؟', ok: 'إضافة دواء')) {
        if (!mounted) return;
        final nm = await showMedicineForm(context, barcode: isCode ? t : null);
        if (nm != null) _add(nm);
      }
    } else {
      setState(() => _results = r);
    }
  }

  void _add(Medicine m) {
    setState(() {
      _lines.insert(0, _LineCtrls(PurchaseLine(m)));
      _results = [];
      _search.clear();
    });
    _searchFocus.requestFocus();
  }

  double get _gross => _lines.fold(0.0, (a, l) => a + (parseInt(l.qty.text) ?? 0) * (parseNum(l.cost.text) ?? 0));

  Future<void> _save() async {
    if (_supplier == null) {
      showError(context, 'اختر المورد');
      return;
    }
    if (_lines.isEmpty) {
      showError(context, 'أضف أدوية للفاتورة');
      return;
    }
    for (final c in _lines) {
      final l = c.line;
      l.quantityBoxes = parseInt(c.qty.text) ?? 0;
      l.bonusBoxes = parseInt(c.bonus.text) ?? 0;
      l.costUsdPerBox = parseNum(c.cost.text) ?? 0;
      l.batchNumber = c.batch.text.trim().isEmpty ? null : c.batch.text.trim();
      if (c.expiry.text.trim().isNotEmpty) {
        l.expiryDate = parseDate(c.expiry.text);
        if (l.expiryDate == null) {
          showError(context, 'تاريخ انتهاء غير صحيح في "${l.medicine.name}". اكتب مثلاً 12/2027');
          return;
        }
      } else {
        l.expiryDate = null;
      }
      final np = parseNum(c.price.text);
      l.newPriceUsd = np != null && np != l.medicine.priceUsd ? np : null;
    }
    final missingExpiry = _lines.where((c) => c.line.expiryDate == null).length;
    if (missingExpiry > 0 &&
        !await confirm(context, 'تاريخ الانتهاء', 'يوجد $missingExpiry صنف بدون تاريخ انتهاء. هل تريد المتابعة؟')) {
      return;
    }
    if (!mounted) return;
    setState(() => _busy = true);
    final r = await guard(
      context,
      () => st.s.purchases.create(
        actor: st.user!,
        supplier: _supplier!,
        lines: _lines.map((c) => c.line).toList(),
        invoiceNumber: _invoice.text,
        invoiceDate: _date,
        discountUsd: parseNum(_discount.text) ?? 0,
        paidAmount: parseNum(_paid.text) ?? 0,
        paidCurrency: _paidCurrency,
        rate: st.rate,
        payFromShift: _fromDrawer ? st.shift : null,
        notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
      ),
      success: 'تم حفظ فاتورة الشراء وإضافة الكميات للمخزون',
    );
    if (mounted) setState(() => _busy = false);
    if (r != null && mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final gross = _gross;
    final net = gross - (parseNum(_discount.text) ?? 0);
    return Scaffold(
      appBar: AppBar(title: const Text('فاتورة شراء جديدة')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Expanded(
              flex: 3,
              child: DropdownButtonFormField<int>(
                initialValue: _supplier?.id,
                decoration: const InputDecoration(labelText: 'المورد *'),
                items: [for (final s in _suppliers) DropdownMenuItem(value: s.supplier.id, child: Text(s.supplier.name))],
                onChanged: (v) => setState(() => _supplier = _suppliers.firstWhere((s) => s.supplier.id == v).supplier),
              ),
            ),
            IconButton(
              tooltip: 'مورد جديد',
              icon: const Icon(Icons.add_business),
              onPressed: () async {
                final s = await showSupplierForm(context);
                if (s != null) {
                  await _loadSuppliers();
                  setState(() => _supplier = s);
                }
              },
            ),
            const SizedBox(width: 10),
            Expanded(flex: 2, child: TextField(controller: _invoice, decoration: const InputDecoration(labelText: 'رقم فاتورة المورد'))),
            const SizedBox(width: 10),
            OutlinedButton.icon(
              icon: const Icon(Icons.event),
              label: Text(fmtDate(_date)),
              onPressed: () async {
                final d = await pickDate(context, initial: _date);
                if (d != null) setState(() => _date = d);
              },
            ),
          ]),
          const SizedBox(height: 12),
          TextField(
            controller: _search,
            focusNode: _searchFocus,
            autofocus: true,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.qr_code_scanner), hintText: 'امسح باركود الدواء أو ابحث بالاسم لإضافته للفاتورة'),
            onChanged: _onSearch,
            onSubmitted: _onSubmit,
          ),
          if (_results.isNotEmpty)
            Card(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 220),
                child: ListView(shrinkWrap: true, children: [
                  for (final r in _results)
                    ListTile(
                      dense: true,
                      title: Text(r.medicine.name),
                      subtitle: Text('${r.medicine.manufacturer ?? ''}  •  المتوفر: ${r.medicine.describeQty(r.available)}'),
                      onTap: () => _add(r.medicine),
                    ),
                ]),
              ),
            ),
          const SizedBox(height: 10),
          Expanded(
            child: Card(
              child: _lines.isEmpty
                  ? const EmptyState('لم تتم إضافة أدوية بعد', icon: Icons.add_shopping_cart)
                  : ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: _lines.length,
                      separatorBuilder: (_, _) => const Divider(),
                      itemBuilder: (_, i) {
                        final c = _lines[i];
                        final m = c.line.medicine;
                        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          SizedBox(
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(m.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text('${m.boxName} = ${m.basePerBox} ${m.unitName}',
                                    style: const TextStyle(fontSize: 12, color: Colors.black54)),
                              ]),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: NumField(controller: c.qty, label: 'الكمية (${m.boxName})', decimal: false, onChanged: (_) => setState(() {}))),
                          const SizedBox(width: 8),
                          Expanded(child: NumField(controller: c.bonus, label: 'بونص', decimal: false)),
                          const SizedBox(width: 8),
                          Expanded(child: NumField(controller: c.cost, label: 'سعر الشراء \$', onChanged: (_) => setState(() {}))),
                          const SizedBox(width: 8),
                          Expanded(
                              child: TextField(
                                  controller: c.expiry,
                                  decoration: const InputDecoration(labelText: 'الانتهاء', hintText: '12/2027'))),
                          const SizedBox(width: 8),
                          Expanded(child: TextField(controller: c.batch, decoration: const InputDecoration(labelText: 'التشغيلة'))),
                          const SizedBox(width: 8),
                          Expanded(
                            child: NumField(
                              controller: c.price,
                              label: 'سعر البيع \$',
                              helper: _margin(c),
                              onChanged: (_) => setState(() {}),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: kDanger),
                            onPressed: () => setState(() => _lines.removeAt(i)),
                          ),
                        ]);
                      },
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(children: [
                SizedBox(width: 140, child: NumField(controller: _discount, label: 'خصم \$', onChanged: (_) => setState(() {}))),
                const SizedBox(width: 10),
                SizedBox(width: 160, child: NumField(controller: _paid, label: 'المدفوع الآن')),
                const SizedBox(width: 6),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: currencyUsd, label: Text('\$')),
                    ButtonSegment(value: currencySyp, label: Text('ل.س')),
                  ],
                  selected: {_paidCurrency},
                  onSelectionChanged: (v) => setState(() => _paidCurrency = v.first),
                ),
                const SizedBox(width: 10),
                if (st.shift != null)
                  FilterChip(
                    label: const Text('الدفع من درجي'),
                    selected: _fromDrawer,
                    onSelected: (v) => setState(() => _fromDrawer = v),
                  ),
                const SizedBox(width: 10),
                Expanded(child: TextField(controller: _notes, decoration: const InputDecoration(labelText: 'ملاحظات'))),
                const SizedBox(width: 16),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text('الإجمالي: ${fmtUsd(roundTo(net, 2))}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('≈ ${fmtSyp(roundTo(net * st.rate, 0))}', style: const TextStyle(color: Colors.black54)),
                ]),
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: _busy ? null : _save,
                  icon: const Icon(Icons.save),
                  label: const Text('حفظ الفاتورة'),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  String? _margin(_LineCtrls c) {
    final cost = parseNum(c.cost.text);
    final price = parseNum(c.price.text);
    if (cost == null || cost <= 0 || price == null) return null;
    return 'ربح ${roundTo((price - cost) / cost * 100, 1)}%';
  }
}
