import 'package:drift/drift.dart' show Value;
import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/money.dart';
import '../../core/permissions.dart';
import '../../core/units.dart';
import '../../data/database.dart';
import '../../printing/printer.dart';
import '../../services/inventory_service.dart';
import '../widgets/common.dart';

class MedicinesScreen extends StatefulWidget {
  const MedicinesScreen({super.key});

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  final _q = TextEditingController();
  String _filter = 'all';
  List<MedicineStock> _list = [];
  bool _loading = true;

  AppState get st => AppState.I;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final l = await st.s.inventory.listWithStock(search: _q.text);
    if (mounted) {
      setState(() {
        _list = l;
        _loading = false;
      });
    }
  }

  List<MedicineStock> get _filtered {
    switch (_filter) {
      case 'low':
        return _list.where((s) => s.isLow).toList();
      case 'out':
        return _list.where((s) => s.available <= 0).toList();
      case 'expired':
        return _list.where((s) => s.expired > 0).toList();
      default:
        return _list;
    }
  }

  @override
  Widget build(BuildContext context) {
    final u = st.user!;
    final items = _filtered;
    final now = DateTime.now();
    final alertLimit = DateTime(now.year, now.month + st.s.settings.expiryAlertMonths, now.day);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionTitle(
            'الأدوية والمخزون',
            icon: Icons.medication_outlined,
            actions: [
              if (u.can(Permission.manageMedicines))
                FilledButton.icon(
                  onPressed: () async {
                    final m = await showMedicineForm(context);
                    if (m != null) {
                      _load();
                      if (context.mounted &&
                          await confirm(
                            context,
                            'إضافة كمية',
                            'هل تريد إضافة كمية افتتاحية لهذا الدواء الآن؟',
                            ok: 'إضافة كمية',
                          )) {
                        if (context.mounted) await showAddStockDialog(context, m);
                        _load();
                      }
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('دواء جديد'),
                ),
              OutlinedButton.icon(
                onPressed: () => AppPrinter.printTable(
                  title: 'جرد المخزون',
                  landscape: true,
                  headers: [
                    'الدواء',
                    'المادة الفعالة',
                    'الباركود',
                    'الكمية',
                    'سعر العلبة \$',
                    'سعر العلبة ل.س',
                    'أقرب انتهاء',
                  ],
                  rows: [
                    for (final s in items)
                      [
                        s.medicine.name,
                        s.medicine.scientificName ?? '',
                        s.medicine.barcode ?? '',
                        s.medicine.describeQty(s.available),
                        fmtUsdPlain(s.medicine.priceUsd),
                        fmtSypPlain(st.s.settings.toSyp(s.medicine.priceUsd)),
                        fmtDate(s.nearestExpiry),
                      ],
                  ],
                ),
                icon: const Icon(Icons.print),
                label: const Text('طباعة الجرد'),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 380,
                child: TextField(
                  controller: _q,
                  autofocus: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'بحث بالاسم، المادة الفعالة، الشركة أو الباركود',
                  ),
                  onChanged: (_) => _load(),
                ),
              ),
              const SizedBox(width: 12),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'all', label: Text('الكل')),
                  ButtonSegment(value: 'low', label: Text('تحت الحد الأدنى')),
                  ButtonSegment(value: 'out', label: Text('نفد')),
                  ButtonSegment(value: 'expired', label: Text('فيه منتهي')),
                ],
                selected: {_filter},
                onSelectionChanged: (v) => setState(() => _filter = v.first),
              ),
              const Spacer(),
              Text('${items.length} صنف'),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : SimpleTable(
                    columns: const [
                      'الدواء',
                      'المادة الفعالة',
                      'الشركة',
                      'الباركود',
                      'المخزون',
                      'السعر',
                      'أقرب انتهاء',
                    ],
                    rows: [
                      for (final s in items)
                        [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(s.medicine.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              if (s.isLow) ...[const SizedBox(width: 6), const Badge2('ناقص', color: kWarning)],
                            ],
                          ),
                          Text(s.medicine.scientificName ?? ''),
                          Text(s.medicine.manufacturer ?? ''),
                          Text(s.medicine.barcode ?? ''),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.medicine.describeQty(s.available),
                                style: TextStyle(color: s.available <= 0 ? kDanger : null, fontWeight: FontWeight.w600),
                              ),
                              if (s.expired > 0)
                                Text(
                                  'منتهي: ${s.medicine.describeQty(s.expired)}',
                                  style: const TextStyle(color: kDanger, fontSize: 12),
                                ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fmtSyp(st.s.settings.toSyp(s.medicine.priceUsd)),
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                fmtUsd(s.medicine.priceUsd),
                                style: const TextStyle(fontSize: 12, color: Colors.black54),
                              ),
                            ],
                          ),
                          Text(
                            fmtDate(s.nearestExpiry),
                            style: TextStyle(
                              color: s.nearestExpiry != null && s.nearestExpiry!.isBefore(alertLimit) ? kDanger : null,
                            ),
                          ),
                        ],
                    ],
                    onTaps: [
                      for (final s in items)
                        () async {
                          await showDialog(
                            context: context,
                            builder: (_) => MedicineDetailsDialog(medicineId: s.medicine.id),
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

/// نموذج إضافة/تعديل دواء
Future<Medicine?> showMedicineForm(BuildContext context, {Medicine? existing, String? barcode}) => showDialog<Medicine>(
  context: context,
  builder: (_) => _MedicineForm(existing: existing, barcode: barcode),
);

class _MedicineForm extends StatefulWidget {
  final Medicine? existing;
  final String? barcode;
  const _MedicineForm({this.existing, this.barcode});

  @override
  State<_MedicineForm> createState() => _MedicineFormState();
}

class _MedicineFormState extends State<_MedicineForm> {
  late final m = widget.existing;
  late final _name = TextEditingController(text: m?.name);
  late final _sci = TextEditingController(text: m?.scientificName);
  late final _maker = TextEditingController(text: m?.manufacturer);
  late final _form = TextEditingController(text: m?.form);
  late final _cat = TextEditingController(text: m?.category);
  late final _barcode = TextEditingController(text: m?.barcode ?? widget.barcode);
  late final _strips = TextEditingController(text: '${m?.stripsPerBox ?? 1}');
  late final _perStrip = TextEditingController(text: '${m?.unitsPerStrip ?? 1}');
  late final _boxName = TextEditingController(text: m?.boxName ?? 'علبة');
  late final _stripName = TextEditingController(text: m?.stripName ?? 'ظرف');
  late final _unitName = TextEditingController(text: m?.unitName ?? 'حبة');
  late final _price = TextEditingController(text: m == null ? '' : fmtUsdPlain(m!.priceUsd).replaceAll(',', ''));
  late final _stripPrice = TextEditingController(text: m?.stripPriceUsd?.toString() ?? '');
  late final _unitPrice = TextEditingController(text: m?.unitPriceUsd?.toString() ?? '');
  late final _min = TextEditingController(text: m == null ? '0' : fmtQty(m!.minStockBoxes));
  late final _notes = TextEditingController(text: m?.notes);
  late bool _allowStrip = m?.allowStripSale ?? false;
  late bool _allowUnit = m?.allowUnitSale ?? false;
  late bool _rx = m?.requiresPrescription ?? false;
  late bool _active = m?.active ?? true;
  List<String> _sciOptions = [];
  List<String> _formOptions = [];
  List<String> _makerOptions = [];

  AppState get st => AppState.I;

  @override
  void initState() {
    super.initState();
    () async {
      final a = await st.s.inventory.distinctValues('scientific_name');
      final b = await st.s.inventory.distinctValues('form');
      final c = await st.s.inventory.distinctValues('manufacturer');
      if (mounted) {
        setState(() {
          _sciOptions = a;
          _formOptions = b;
          _makerOptions = c;
        });
      }
    }();
  }

  final Map<TextEditingController, FocusNode> _focus = {};

  Widget _auto(TextEditingController c, String label, List<String> options) => RawAutocomplete<String>(
    textEditingController: c,
    focusNode: _focus.putIfAbsent(c, FocusNode.new),
    optionsBuilder: (v) => v.text.isEmpty
        ? const Iterable<String>.empty()
        : options.where((o) => o.toLowerCase().contains(v.text.toLowerCase()) && o != v.text),
    onSelected: (v) => c.text = v,
    fieldViewBuilder: (ctx, ctrl, focus, onSubmit) => TextField(
      controller: ctrl,
      focusNode: focus,
      decoration: InputDecoration(labelText: label),
    ),
    optionsViewBuilder: (ctx, onSelected, opts) => Align(
      alignment: AlignmentDirectional.topStart,
      child: Material(
        elevation: 4,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200, maxWidth: 340),
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [for (final o in opts) ListTile(dense: true, title: Text(o), onTap: () => onSelected(o))],
          ),
        ),
      ),
    ),
  );

  Future<void> _save() async {
    final price = parseNum(_price.text) ?? 0;
    final strips = parseInt(_strips.text) ?? 1;
    final perStrip = parseInt(_perStrip.text) ?? 1;
    if (_name.text.trim().isEmpty) {
      showError(context, 'اسم الدواء مطلوب');
      return;
    }
    if (strips < 1 || perStrip < 1) {
      showError(context, 'عدد الأشرطة والحبات يجب أن يكون 1 على الأقل');
      return;
    }
    String? t(TextEditingController c) => c.text.trim().isEmpty ? null : c.text.trim();
    final data = MedicinesCompanion(
      name: Value(_name.text.trim()),
      scientificName: Value(t(_sci)),
      manufacturer: Value(t(_maker)),
      form: Value(t(_form)),
      category: Value(t(_cat)),
      barcode: Value(t(_barcode)),
      stripsPerBox: Value(strips),
      unitsPerStrip: Value(perStrip),
      boxName: Value(t(_boxName) ?? 'علبة'),
      stripName: Value(t(_stripName) ?? 'ظرف'),
      unitName: Value(t(_unitName) ?? 'حبة'),
      allowStripSale: Value(_allowStrip),
      allowUnitSale: Value(_allowUnit),
      priceUsd: Value(price),
      stripPriceUsd: Value(parseNum(_stripPrice.text)),
      unitPriceUsd: Value(parseNum(_unitPrice.text)),
      minStockBoxes: Value(parseNum(_min.text) ?? 0),
      requiresPrescription: Value(_rx),
      active: Value(_active),
      notes: Value(t(_notes)),
    );
    final r = await guard(context, () => st.s.inventory.saveMedicine(actor: st.user!, existing: m, data: data));
    if (r != null && mounted) Navigator.pop(context, r);
  }

  @override
  Widget build(BuildContext context) {
    final rate = st.rate;
    final price = parseNum(_price.text) ?? 0;
    final strips = parseInt(_strips.text) ?? 1;
    final perStrip = parseInt(_perStrip.text) ?? 1;
    final canPrice = st.user!.can(Permission.editPrices) || m == null;
    Widget row(List<Widget> children) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(width: 10),
            Expanded(child: children[i]),
          ],
        ],
      ),
    );
    return AlertDialog(
      title: Text(m == null ? 'دواء جديد' : 'تعديل: ${m!.name}'),
      content: SizedBox(
        width: 760,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              row([
                TextField(
                  controller: _name,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'الاسم التجاري *'),
                ),
                _auto(_sci, 'المادة الفعالة (للبدائل)', _sciOptions),
              ]),
              row([
                TextField(
                  controller: _barcode,
                  textDirection: TextDirection.ltr,
                  decoration: const InputDecoration(labelText: 'الباركود', prefixIcon: Icon(Icons.qr_code)),
                ),
                _auto(_maker, 'الشركة المصنعة', _makerOptions),
              ]),
              row([
                _auto(_form, 'الشكل (حب، شراب، حقن...)', _formOptions),
                TextField(
                  controller: _cat,
                  decoration: const InputDecoration(labelText: 'التصنيف'),
                ),
              ]),
              const Divider(),
              const Text(
                'وحدات البيع',
                style: TextStyle(fontWeight: FontWeight.bold, color: kPrimary),
              ),
              const SizedBox(height: 8),
              row([
                TextField(
                  controller: _boxName,
                  decoration: const InputDecoration(labelText: 'اسم الوحدة الكبرى'),
                ),
                NumField(
                  controller: _strips,
                  label: 'عدد الأشرطة في العلبة',
                  decimal: false,
                  onChanged: (_) => setState(() {}),
                ),
                TextField(
                  controller: _stripName,
                  decoration: const InputDecoration(labelText: 'اسم الشريط'),
                ),
              ]),
              row([
                NumField(
                  controller: _perStrip,
                  label: 'عدد الحبات في الشريط',
                  decimal: false,
                  onChanged: (_) => setState(() {}),
                ),
                TextField(
                  controller: _unitName,
                  decoration: const InputDecoration(labelText: 'اسم الوحدة الصغرى'),
                ),
                const SizedBox(),
              ]),
              Wrap(
                spacing: 16,
                children: [
                  FilterChip(
                    label: const Text('يُباع بالشريط'),
                    selected: _allowStrip,
                    onSelected: strips > 1 ? (v) => setState(() => _allowStrip = v) : null,
                  ),
                  FilterChip(
                    label: const Text('يُباع بالحبة'),
                    selected: _allowUnit,
                    onSelected: strips * perStrip > 1 ? (v) => setState(() => _allowUnit = v) : null,
                  ),
                  FilterChip(
                    label: const Text('يحتاج وصفة طبية'),
                    selected: _rx,
                    onSelected: (v) => setState(() => _rx = v),
                  ),
                  if (m != null)
                    FilterChip(
                      label: const Text('فعّال'),
                      selected: _active,
                      onSelected: (v) => setState(() => _active = v),
                    ),
                ],
              ),
              const Divider(height: 24),
              const Text(
                'السعر (بالدولار)',
                style: TextStyle(fontWeight: FontWeight.bold, color: kPrimary),
              ),
              const SizedBox(height: 8),
              row([
                NumField(
                  controller: _price,
                  label: 'سعر العلبة *',
                  suffix: '\$',
                  enabled: canPrice,
                  helper: '= ${fmtSyp(st.s.settings.toSyp(price))}',
                  onChanged: (_) => setState(() {}),
                ),
                NumField(
                  controller: _stripPrice,
                  label: 'سعر الشريط (اختياري)',
                  suffix: '\$',
                  enabled: canPrice && _allowStrip,
                  helper: 'تلقائي: ${fmtUsd(roundTo(price / (strips < 1 ? 1 : strips), 4))}',
                ),
                NumField(
                  controller: _unitPrice,
                  label: 'سعر الحبة (اختياري)',
                  suffix: '\$',
                  enabled: canPrice && _allowUnit,
                  helper:
                      'تلقائي: ${fmtUsd(roundTo(price / ((strips < 1 ? 1 : strips) * (perStrip < 1 ? 1 : perStrip)), 4))}',
                ),
              ]),
              if (!canPrice)
                const Text('لا تملك صلاحية تعديل الأسعار', style: TextStyle(color: kWarning, fontSize: 12)),
              Text(
                'سعر الصرف الحالي: 1\$ = ${fmtSyp(rate)}',
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
              const SizedBox(height: 10),
              row([
                NumField(controller: _min, label: 'الحد الأدنى للمخزون (علب)', helper: 'للتنبيه وقائمة النواقص'),
                TextField(
                  controller: _notes,
                  decoration: const InputDecoration(labelText: 'ملاحظات'),
                ),
              ]),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
        FilledButton(onPressed: _save, child: const Text('حفظ')),
      ],
    );
  }
}

/// إضافة كمية لدواء (مخزون افتتاحي أو بدون فاتورة)
Future<void> showAddStockDialog(BuildContext context, Medicine m) async {
  final boxes = TextEditingController(text: '1');
  final loose = TextEditingController(text: '0');
  final cost = TextEditingController(text: '0');
  final batch = TextEditingController();
  final expiry = TextEditingController();
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('إضافة كمية: ${m.name}'),
      content: SizedBox(
        width: 460,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: NumField(controller: boxes, label: 'عدد ${m.boxName}', decimal: false, autofocus: true),
                ),
                if (m.basePerBox > 1) ...[
                  const SizedBox(width: 10),
                  Expanded(
                    child: NumField(controller: loose, label: 'عدد ${m.unitName} إضافية', decimal: false),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: expiry,
                    decoration: const InputDecoration(labelText: 'تاريخ الانتهاء', hintText: 'مثال: 12/2027'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: batch,
                    decoration: const InputDecoration(labelText: 'رقم التشغيلة'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            NumField(controller: cost, label: 'تكلفة العلبة (سعر الشراء)', suffix: '\$'),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء')),
        FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('إضافة')),
      ],
    ),
  );
  if (ok != true || !context.mounted) return;
  final exp = parseDate(expiry.text);
  if (expiry.text.trim().isNotEmpty && exp == null) {
    showError(context, 'صيغة التاريخ غير صحيحة. اكتب مثلاً 12/2027 أو 2027-12-31');
    return;
  }
  final st = AppState.I;
  await guard(
    context,
    () => st.s.inventory.addBatch(
      actor: st.user!,
      medicine: m,
      baseQuantity: (parseInt(boxes.text) ?? 0) * m.basePerBox + (parseInt(loose.text) ?? 0),
      expiryDate: exp,
      batchNumber: batch.text,
      costUsdPerBox: parseNum(cost.text) ?? 0,
    ),
    success: 'تمت إضافة الكمية',
  );
}

/// تفاصيل الدواء: الدفعات، الجرد، البدائل
class MedicineDetailsDialog extends StatefulWidget {
  final int medicineId;
  const MedicineDetailsDialog({super.key, required this.medicineId});

  @override
  State<MedicineDetailsDialog> createState() => _MedicineDetailsDialogState();
}

class _MedicineDetailsDialogState extends State<MedicineDetailsDialog> {
  MedicineStock? _s;
  List<StockBatch> _batches = [];
  List<MedicineStock> _alts = [];
  bool _showEmpty = false;

  AppState get st => AppState.I;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final s = await st.s.inventory.stockOf(widget.medicineId);
    final b = await st.s.inventory.batchesOf(widget.medicineId);
    final a = await st.s.inventory.alternatives(s!.medicine);
    if (mounted) {
      setState(() {
        _s = s;
        _batches = b;
        _alts = a;
      });
    }
  }

  Future<void> _adjust(StockBatch b) async {
    final m = _s!.medicine;
    final boxes = TextEditingController(text: '${b.quantity ~/ m.basePerBox}');
    final loose = TextEditingController(text: '${b.quantity % m.basePerBox}');
    final note = TextEditingController();
    var reason = 'count';
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setD) => AlertDialog(
          title: const Text('جرد / تعديل الكمية'),
          content: SizedBox(
            width: 440,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('الكمية المسجلة: ${m.describeQty(b.quantity)}'),
                const SizedBox(height: 12),
                const Text('الكمية الفعلية الموجودة:'),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: NumField(controller: boxes, label: m.boxName, decimal: false, autofocus: true),
                    ),
                    if (m.basePerBox > 1) ...[
                      const SizedBox(width: 10),
                      Expanded(
                        child: NumField(controller: loose, label: m.unitName, decimal: false),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: reason,
                  decoration: const InputDecoration(labelText: 'السبب'),
                  items: const [
                    DropdownMenuItem(value: 'count', child: Text('جرد')),
                    DropdownMenuItem(value: 'damaged', child: Text('تالف')),
                    DropdownMenuItem(value: 'expired', child: Text('منتهي الصلاحية (إتلاف)')),
                    DropdownMenuItem(value: 'other', child: Text('أخرى')),
                  ],
                  onChanged: (v) => setD(() => reason = v!),
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
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('حفظ')),
          ],
        ),
      ),
    );
    if (ok != true || !mounted) return;
    await guard(
      context,
      () => st.s.inventory.adjustBatch(
        actor: st.user!,
        batch: b,
        newQuantity: (parseInt(boxes.text) ?? 0) * m.basePerBox + (parseInt(loose.text) ?? 0),
        reason: reason,
        note: note.text,
      ),
      success: 'تم تعديل الكمية',
    );
    _load();
  }

  Future<void> _editBatch(StockBatch b) async {
    final exp = TextEditingController(text: b.expiryDate == null ? '' : fmtDate(b.expiryDate));
    final num = TextEditingController(text: b.batchNumber ?? '');
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تعديل بيانات الدفعة'),
        content: SizedBox(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: exp,
                decoration: const InputDecoration(labelText: 'تاريخ الانتهاء', hintText: '12/2027'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: num,
                decoration: const InputDecoration(labelText: 'رقم التشغيلة'),
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
    if (ok != true || !mounted) return;
    final d = parseDate(exp.text);
    if (exp.text.trim().isNotEmpty && d == null) {
      showError(context, 'صيغة التاريخ غير صحيحة');
      return;
    }
    await guard(
      context,
      () => st.s.inventory.updateBatchInfo(actor: st.user!, batch: b, expiryDate: d, batchNumber: num.text.trim()),
    );
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final s = _s;
    if (s == null)
      return const AlertDialog(
        content: SizedBox(height: 120, child: Center(child: CircularProgressIndicator())),
      );
    final m = s.medicine;
    final u = st.user!;
    final today = DateTime.now();
    final batches = _showEmpty ? _batches : _batches.where((b) => b.quantity > 0).toList();
    return AlertDialog(
      title: Row(
        children: [
          Expanded(child: Text(m.name)),
          if (u.can(Permission.manageMedicines) || u.can(Permission.editPrices))
            IconButton(
              tooltip: 'تعديل',
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await showMedicineForm(context, existing: m);
                _load();
              },
            ),
        ],
      ),
      content: SizedBox(
        width: 820,
        height: 560,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                StatCard(
                  title: 'المتوفر',
                  value: m.describeQty(s.available),
                  icon: Icons.inventory_2,
                  color: s.isLow ? kWarning : kPrimary,
                ),
                StatCard(
                  title: 'سعر ${m.boxName}',
                  value: fmtSyp(st.s.settings.toSyp(m.priceUsd)),
                  sub: fmtUsd(m.priceUsd),
                  icon: Icons.sell_outlined,
                ),
                if (s.expired > 0)
                  StatCard(
                    title: 'منتهي الصلاحية',
                    value: m.describeQty(s.expired),
                    icon: Icons.dangerous,
                    color: kDanger,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              [
                if (m.scientificName != null) 'المادة الفعالة: ${m.scientificName}',
                if (m.manufacturer != null) 'الشركة: ${m.manufacturer}',
                '${m.boxName} = ${m.stripsPerBox} ${m.stripName} × ${m.unitsPerStrip} ${m.unitName}',
                if (m.minStockBoxes > 0) 'الحد الأدنى: ${fmtQty(m.minStockBoxes)} ${m.boxName}',
              ].join('   •   '),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('الدفعات', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(width: 12),
                FilterChip(
                  label: const Text('إظهار الدفعات الفارغة'),
                  selected: _showEmpty,
                  onSelected: (v) => setState(() => _showEmpty = v),
                ),
                const Spacer(),
                if (u.can(Permission.manageMedicines))
                  FilledButton.icon(
                    onPressed: () async {
                      await showAddStockDialog(context, m);
                      _load();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('إضافة كمية'),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SimpleTable(
                columns: const ['رقم التشغيلة', 'تاريخ الانتهاء', 'الكمية', 'تكلفة العلبة', 'تاريخ الإدخال', ''],
                rows: [
                  for (final b in batches)
                    [
                      Text(b.batchNumber ?? '-'),
                      Text(
                        fmtDate(b.expiryDate),
                        style: TextStyle(
                          color: b.expiryDate != null && b.expiryDate!.isBefore(today) ? kDanger : null,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(m.describeQty(b.quantity)),
                      Text(u.can(Permission.viewReports) ? fmtUsd(b.costUsdPerBox) : '-'),
                      Text(fmtDate(b.createdAt)),
                      if (u.can(Permission.manageMedicines))
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              tooltip: 'جرد / تعديل الكمية',
                              icon: const Icon(Icons.fact_check_outlined),
                              onPressed: () => _adjust(b),
                            ),
                            IconButton(
                              tooltip: 'تعديل التاريخ',
                              icon: const Icon(Icons.event),
                              onPressed: () => _editBatch(b),
                            ),
                          ],
                        )
                      else
                        const SizedBox(),
                    ],
                ],
              ),
            ),
            if (_alts.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'البدائل المتوفرة: ${_alts.map((a) => '${a.medicine.name} (${a.medicine.describeQty(a.available)})').join('، ')}',
                style: const TextStyle(color: kPrimary),
              ),
            ],
          ],
        ),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('إغلاق'))],
    );
  }
}
