import 'dart:async';

import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/money.dart';
import '../../core/permissions.dart';
import '../../core/units.dart';
import '../../data/database.dart';
import '../../printing/printer.dart';
import '../../services/inventory_service.dart';
import '../../services/party_service.dart';
import '../../services/sales_service.dart';
import '../widgets/common.dart';
import 'customers_screen.dart';
import 'home_shell.dart';

/// سلة البيع الحالية (تبقى محفوظة عند التنقل بين الصفحات)
class PosCart extends ChangeNotifier {
  static final PosCart I = PosCart._();
  PosCart._();

  final List<CartLine> lines = [];

  /// المخزون المتاح لكل دواء (بأصغر وحدة) وقت الإضافة
  final Map<int, int> available = {};
  Customer? customer;

  void add(Medicine m, int avail, {SaleUnit unit = SaleUnit.box}) {
    available[m.id] = avail;
    final existing = lines.where((l) => l.medicine.id == m.id && l.unit == unit).firstOrNull;
    if (existing != null) {
      existing.quantity++;
      lines.remove(existing);
      lines.insert(0, existing);
    } else {
      lines.insert(0, CartLine(m, unit: unit));
    }
    notifyListeners();
  }

  void remove(CartLine l) {
    lines.remove(l);
    notifyListeners();
  }

  void clear() {
    lines.clear();
    available.clear();
    customer = null;
    notifyListeners();
  }

  void changed() => notifyListeners();

  int requestedBase(int medicineId) =>
      lines.where((l) => l.medicine.id == medicineId).fold(0, (s, l) => s + l.baseQuantity);

  bool overStock(int medicineId) => requestedBase(medicineId) > (available[medicineId] ?? 0);
}

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  final _search = TextEditingController();
  final _searchFocus = FocusNode();
  List<MedicineStock> _results = [];
  Timer? _debounce;
  bool _busy = false;

  AppState get st => AppState.I;
  PosCart get cart => PosCart.I;

  @override
  void initState() {
    super.initState();
    cart.addListener(_onCart);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _searchFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    cart.removeListener(_onCart);
    _debounce?.cancel();
    super.dispose();
  }

  void _onCart() {
    if (mounted) setState(() {});
  }

  void _onSearchChanged(String v) {
    _debounce?.cancel();
    if (v.trim().isEmpty) {
      setState(() => _results = []);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 180), () async {
      final r = await st.s.inventory.listWithStock(search: v, limit: 25);
      if (mounted && _search.text == v) setState(() => _results = r);
    });
  }

  Future<void> _onSubmit(String v) async {
    final text = normalizeDigits(v.trim());
    if (text.isEmpty) {
      if (cart.lines.isNotEmpty) _pay();
      return;
    }
    // الماسح الضوئي يكتب الباركود ثم Enter
    final byCode = await st.s.inventory.byBarcode(text);
    if (byCode != null) {
      final stock = await st.s.inventory.stockOf(byCode.id);
      await _addMedicine(stock!);
      return;
    }
    final r = await st.s.inventory.listWithStock(search: text, limit: 25);
    if (r.length == 1) {
      await _addMedicine(r.first);
    } else if (r.isEmpty) {
      if (mounted) showError(context, 'لا يوجد دواء بهذا الاسم أو الباركود: $text');
      _search.selection = TextSelection(baseOffset: 0, extentOffset: _search.text.length);
    } else {
      setState(() => _results = r);
    }
  }

  Future<void> _addMedicine(MedicineStock s) async {
    _search.clear();
    setState(() => _results = []);
    if (s.available <= 0) {
      await _showOutOfStock(s);
    } else {
      cart.add(s.medicine, s.available);
      if (cart.overStock(s.medicine.id) && mounted) {
        showError(context, 'تنبيه: الكمية المطلوبة من "${s.medicine.name}" أكبر من المتوفر');
      }
    }
    _searchFocus.requestFocus();
  }

  Future<void> _showOutOfStock(MedicineStock s) async {
    final alts = await st.s.inventory.alternatives(s.medicine);
    if (!mounted) return;
    final picked = await showDialog<MedicineStock>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(children: [
          const Icon(Icons.warning_amber, color: kWarning),
          const SizedBox(width: 8),
          Expanded(child: Text('"${s.medicine.name}" غير متوفر')),
        ]),
        content: SizedBox(
          width: 520,
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            if (s.expired > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('يوجد ${s.medicine.describeQty(s.expired)} منتهية الصلاحية (لا يمكن بيعها)',
                    style: const TextStyle(color: kDanger)),
              ),
            if (alts.isEmpty)
              Text(s.medicine.scientificName == null
                  ? 'لم يتم تحديد المادة الفعالة لهذا الدواء لاقتراح البدائل.'
                  : 'لا توجد بدائل متوفرة بنفس المادة الفعالة (${s.medicine.scientificName}).')
            else ...[
              Text('البدائل المتوفرة (${s.medicine.scientificName}):',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 320),
                child: ListView(shrinkWrap: true, children: [
                  for (final a in alts)
                    Card(
                      child: ListTile(
                        title: Text(a.medicine.name),
                        subtitle: Text(
                            '${a.medicine.manufacturer ?? ''}  •  المتوفر: ${a.medicine.describeQty(a.available)}'),
                        trailing: Text(fmtSyp(st.s.settings.toSyp(a.medicine.priceUsd)),
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        onTap: () => Navigator.pop(ctx, a),
                      ),
                    ),
                ]),
              ),
            ],
          ]),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إغلاق'))],
      ),
    );
    if (picked != null) cart.add(picked.medicine, picked.available);
  }

  Future<void> _pay() async {
    if (st.shift == null) {
      await showOpenShiftDialog(context);
      if (st.shift == null) return;
    }
    if (cart.lines.isEmpty || !mounted) return;
    final res = await showDialog<_PayResult>(
      context: context,
      builder: (_) => _PaymentDialog(lines: cart.lines, initialCustomer: cart.customer),
    );
    if (res == null || !mounted) return;
    setState(() => _busy = true);
    final details = await guard(context, () => st.s.sales.checkout(
          actor: st.user!,
          shift: st.shift!,
          lines: List.of(cart.lines),
          payment: res.input,
          rate: st.rate,
          rounding: st.s.settings.rounding,
        ));
    setState(() => _busy = false);
    if (details == null) return;
    cart.clear();
    if (mounted) {
      final msg = details.sale.changeSyp > 0
          ? 'تم البيع. الباقي للزبون: ${fmtSyp(details.sale.changeSyp)}'
          : details.sale.debtSyp > 0
              ? 'تم البيع. سُجّل دين ${fmtSyp(details.sale.debtSyp)} على ${details.customer?.name}'
              : 'تم البيع بنجاح - فاتورة رقم ${details.sale.id}';
      showOk(context, msg);
    }
    if (res.print) {
      try {
        await AppPrinter.printReceipt(details);
      } catch (e) {
        if (mounted) showError(context, 'تعذّرت الطباعة: $e');
      }
    }
    _searchFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final rate = st.rate;
    final rounding = st.s.settings.rounding;
    final totals = CheckoutTotals.compute(lines: cart.lines, rate: rate, rounding: rounding);

    return RequireShift(
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.f2): () => _searchFocus.requestFocus(),
          const SingleActivator(LogicalKeyboardKey.f12): _pay,
          const SingleActivator(LogicalKeyboardKey.f9): _pay,
          const SingleActivator(LogicalKeyboardKey.escape): () {
            _search.clear();
            setState(() => _results = []);
          },
        },
        child: Focus(
          autofocus: true,
          // أي كتابة (من الماسح الضوئي) تذهب لحقل البحث حتى لو لم يكن محدداً
          onKeyEvent: (node, event) {
            if (_searchFocus.hasFocus || event is! KeyDownEvent) return KeyEventResult.ignored;
            final ch = event.character;
            if (ch == null || ch.isEmpty || ch.codeUnitAt(0) < 32) return KeyEventResult.ignored;
            _searchFocus.requestFocus();
            _search.text += ch;
            _search.selection = TextSelection.collapsed(offset: _search.text.length);
            _onSearchChanged(_search.text);
            return KeyEventResult.handled;
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              // ---------- السلة ----------
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  TextField(
                    controller: _search,
                    focusNode: _searchFocus,
                    autofocus: true,
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'امسح الباركود أو اكتب اسم الدواء / المادة الفعالة ثم Enter   (F2)',
                      prefixIcon: const Icon(Icons.qr_code_scanner, size: 28),
                      suffixIcon: _search.text.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _search.clear();
                                setState(() => _results = []);
                              }),
                      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                    ),
                    onChanged: _onSearchChanged,
                    onSubmitted: _onSubmit,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Stack(children: [
                      Positioned.fill(child: _cartTable(rate, rounding)),
                      if (_results.isNotEmpty)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Material(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(10),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 420),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: _results.length,
                                separatorBuilder: (_, _) => const Divider(height: 1),
                                itemBuilder: (_, i) => _resultTile(_results[i]),
                              ),
                            ),
                          ),
                        ),
                    ]),
                  ),
                ]),
              ),
              const SizedBox(width: 14),
              // ---------- الإجمالي ----------
              SizedBox(
                width: 330,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                      const Text('الإجمالي', style: TextStyle(fontSize: 18, color: Colors.black54)),
                      const SizedBox(height: 6),
                      FittedBox(
                        alignment: AlignmentDirectional.centerStart,
                        fit: BoxFit.scaleDown,
                        child: Text(fmtSyp(totals.totalSyp),
                            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: kPrimary)),
                      ),
                      Text('≈ ${fmtUsd(roundTo(sypToUsd(totals.totalSyp, rate), 2))}',
                          style: const TextStyle(fontSize: 18, color: Colors.black54)),
                      const Divider(height: 28),
                      _kv('عدد الأصناف', '${cart.lines.length}'),
                      _kv('سعر الصرف', '1\$ = ${fmtSyp(rate)}'),
                      const SizedBox(height: 14),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.person_outline),
                        label: Text(cart.customer == null ? 'اختيار زبون (اختياري)' : 'الزبون: ${cart.customer!.name}'),
                        onPressed: () async {
                          final c = await pickCustomer(context);
                          if (c != null) {
                            cart.customer = c;
                            cart.changed();
                          }
                        },
                      ),
                      if (cart.customer != null)
                        TextButton(
                            onPressed: () {
                              cart.customer = null;
                              cart.changed();
                            },
                            child: const Text('إزالة الزبون')),
                      const Spacer(),
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 22),
                            textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Tajawal')),
                        onPressed: cart.lines.isEmpty || _busy ? null : _pay,
                        icon: const Icon(Icons.payments_outlined, size: 28),
                        label: const Text('الدفع (F12)'),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(foregroundColor: kDanger),
                        onPressed: cart.lines.isEmpty
                            ? null
                            : () async {
                                if (await confirm(context, 'إفراغ السلة', 'هل تريد حذف جميع الأصناف؟', danger: true)) {
                                  cart.clear();
                                }
                              },
                        icon: const Icon(Icons.delete_sweep_outlined),
                        label: const Text('إفراغ السلة'),
                      ),
                    ]),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _kv(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(children: [Text(k, style: const TextStyle(color: Colors.black54)), const Spacer(), Text(v)]),
      );

  Widget _resultTile(MedicineStock s) {
    final m = s.medicine;
    return ListTile(
      dense: true,
      leading: Icon(Icons.medication, color: s.available > 0 ? kPrimary : Colors.grey),
      title: Text(m.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      subtitle: Text([
        if (m.scientificName != null) m.scientificName!,
        if (m.manufacturer != null) m.manufacturer!,
        if (m.form != null) m.form!,
      ].join(' • ')),
      trailing: Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(fmtSyp(st.s.settings.toSyp(m.priceUsd)), style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(s.available > 0 ? 'متوفر: ${m.describeQty(s.available)}' : 'غير متوفر',
            style: TextStyle(fontSize: 12, color: s.available > 0 ? kSuccess : kDanger)),
      ]),
      onTap: () => _addMedicine(s),
    );
  }

  Widget _cartTable(double rate, RoundingConfig rounding) {
    if (cart.lines.isEmpty) {
      return const Card(child: EmptyState('السلة فارغة - امسح باركود الدواء للبدء', icon: Icons.shopping_cart_outlined));
    }
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        Container(
          color: kPrimary.withValues(alpha: 0.08),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: const Row(children: [
            Expanded(flex: 5, child: Text('الدواء', style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 2, child: Text('الوحدة', style: TextStyle(fontWeight: FontWeight.bold))),
            SizedBox(width: 150, child: Text('الكمية', style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 2, child: Text('السعر', style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 2, child: Text('المجموع', style: TextStyle(fontWeight: FontWeight.bold))),
            SizedBox(width: 40),
          ]),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: cart.lines.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final l = cart.lines[i];
              final m = l.medicine;
              final over = cart.overStock(m.id);
              return Container(
                color: over ? kDanger.withValues(alpha: 0.06) : null,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(children: [
                  Expanded(
                    flex: 5,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        Flexible(child: Text(m.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                        if (m.requiresPrescription) ...[const SizedBox(width: 6), const Badge2('وصفة', color: kWarning)],
                      ]),
                      Text(
                        over
                            ? 'الكمية أكبر من المتوفر (${m.describeQty(cart.available[m.id] ?? 0)})'
                            : 'المتوفر: ${m.describeQty(cart.available[m.id] ?? 0)}',
                        style: TextStyle(fontSize: 12, color: over ? kDanger : Colors.black54),
                      ),
                    ]),
                  ),
                  Expanded(
                    flex: 2,
                    child: m.sellableUnits.length <= 1
                        ? Text(m.unitLabel(l.unit))
                        : DropdownButton<SaleUnit>(
                            value: l.unit,
                            isDense: true,
                            underline: const SizedBox(),
                            items: [
                              for (final u in m.sellableUnits) DropdownMenuItem(value: u, child: Text(m.unitLabel(u))),
                            ],
                            onChanged: (u) {
                              if (u == null) return;
                              l.unit = u;
                              cart.changed();
                            },
                          ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Row(children: [
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (l.quantity > 1) {
                            l.quantity--;
                            cart.changed();
                          }
                        },
                      ),
                      SizedBox(
                        width: 54,
                        child: _QtyField(
                          key: ValueKey('q${m.id}-${l.unit}-${l.quantity}'),
                          value: l.quantity,
                          onChanged: (v) {
                            l.quantity = v;
                            cart.changed();
                          },
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          l.quantity++;
                          cart.changed();
                        },
                      ),
                    ]),
                  ),
                  Expanded(flex: 2, child: Text(fmtSypPlain(l.unitPriceSyp(rate, rounding)))),
                  Expanded(
                      flex: 2,
                      child: Text(fmtSypPlain(l.totalSyp(rate, rounding)),
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(
                    width: 40,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: kDanger),
                      onPressed: () => cart.remove(l),
                    ),
                  ),
                ]),
              );
            },
          ),
        ),
      ]),
    );
  }
}

class _QtyField extends StatefulWidget {
  final int value;
  final ValueChanged<int> onChanged;
  const _QtyField({super.key, required this.value, required this.onChanged});

  @override
  State<_QtyField> createState() => _QtyFieldState();
}

class _QtyFieldState extends State<_QtyField> {
  late final _c = TextEditingController(text: '${widget.value}');

  void _commit() {
    final v = parseInt(_c.text);
    if (v != null && v > 0 && v != widget.value) widget.onChanged(v);
  }

  @override
  Widget build(BuildContext context) => Focus(
        onFocusChange: (f) {
          if (!f) _commit();
        },
        child: TextField(
          controller: _c,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 8)),
          onSubmitted: (_) => _commit(),
        ),
      );
}

class _PayResult {
  final PaymentInput input;
  final bool print;
  _PayResult(this.input, this.print);
}

/// نافذة الدفع: ليرة و/أو دولار، خصم، زبون للدين
class _PaymentDialog extends StatefulWidget {
  final List<CartLine> lines;
  final Customer? initialCustomer;
  const _PaymentDialog({required this.lines, this.initialCustomer});

  @override
  State<_PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<_PaymentDialog> {
  final _syp = TextEditingController();
  final _usd = TextEditingController(text: '0');
  final _discount = TextEditingController(text: '0');
  final _note = TextEditingController();
  Customer? _customer;
  double? _customerDebt;

  AppState get st => AppState.I;

  @override
  void initState() {
    super.initState();
    _customer = widget.initialCustomer;
    _syp.text = fmtSypPlain(_totals().totalSyp).replaceAll(',', '');
    // تحديد المبلغ كاملاً ليكتب الصيدلي المبلغ المستلم مباشرة فوقه
    _syp.selection = TextSelection(baseOffset: 0, extentOffset: _syp.text.length);
    _loadDebt();
  }

  Future<void> _loadDebt() async {
    if (_customer == null) {
      setState(() => _customerDebt = null);
      return;
    }
    final d = await st.s.customers.balanceUsd(_customer!.id);
    if (mounted) setState(() => _customerDebt = d);
  }

  CheckoutTotals _totals() => CheckoutTotals.compute(
        lines: widget.lines,
        rate: st.rate,
        rounding: st.s.settings.rounding,
        discountSyp: parseNum(_discount.text) ?? 0,
        paidSyp: parseNum(_syp.text) ?? 0,
        paidUsd: parseNum(_usd.text) ?? 0,
      );

  void _submit(bool print) {
    final t = _totals();
    if (t.debtSyp > 0 && _customer == null) {
      showError(context, 'المبلغ المدفوع أقل من الإجمالي. اختر زبوناً لتسجيل الباقي ديناً');
      return;
    }
    Navigator.pop(
      context,
      _PayResult(
        PaymentInput(
          discountSyp: parseNum(_discount.text) ?? 0,
          paidSyp: parseNum(_syp.text) ?? 0,
          paidUsd: parseNum(_usd.text) ?? 0,
          customer: _customer,
          note: _note.text.trim().isEmpty ? null : _note.text.trim(),
        ),
        print,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = _totals();
    final canDiscount = st.user!.can(Permission.giveDiscount);
    final autoPrint = st.s.settings.autoPrint;
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.f12): () => _submit(autoPrint),
        const SingleActivator(LogicalKeyboardKey.enter, control: true): () => _submit(autoPrint),
      },
      child: AlertDialog(
        title: const Text('الدفع'),
        content: SizedBox(
          width: 520,
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: kPrimary.withValues(alpha: 0.07), borderRadius: BorderRadius.circular(10)),
              child: Row(children: [
                const Text('المطلوب:', style: TextStyle(fontSize: 18)),
                const Spacer(),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(fmtSyp(t.totalSyp),
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: kPrimary)),
                  Text('≈ ${fmtUsd(roundTo(sypToUsd(t.totalSyp, st.rate), 2))}'),
                ]),
              ]),
            ),
            const SizedBox(height: 14),
            if (canDiscount) ...[
              NumField(
                controller: _discount,
                label: 'خصم',
                suffix: 'ل.س',
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 10),
            ],
            Row(children: [
              Expanded(
                child: NumField(
                  controller: _syp,
                  label: 'المدفوع بالليرة',
                  suffix: 'ل.س',
                  autofocus: true,
                  onChanged: (_) => setState(() {}),
                  onSubmitted: (_) => _submit(autoPrint),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: NumField(
                  controller: _usd,
                  label: 'المدفوع بالدولار',
                  suffix: '\$',
                  onChanged: (_) => setState(() {}),
                  onSubmitted: (_) => _submit(autoPrint),
                ),
              ),
            ]),
            const SizedBox(height: 6),
            Wrap(spacing: 6, children: [
              ActionChip(
                  label: const Text('المبلغ كاملاً بالليرة'),
                  onPressed: () => setState(() {
                        _usd.text = '0';
                        _syp.text = fmtSypPlain(t.totalSyp).replaceAll(',', '');
                      })),
              ActionChip(
                  label: const Text('بدون دفع (دين)'),
                  onPressed: () => setState(() {
                        _usd.text = '0';
                        _syp.text = '0';
                      })),
            ]),
            const SizedBox(height: 12),
            if (t.changeSyp > 0)
              _bigRow('الباقي للزبون', fmtSyp(t.changeSyp), kSuccess)
            else if (t.debtSyp > 0)
              _bigRow('المتبقي (دين)', fmtSyp(t.debtSyp), kDanger),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              icon: const Icon(Icons.person_outline),
              label: Text(_customer == null ? 'اختيار زبون' : 'الزبون: ${_customer!.name}'),
              onPressed: () async {
                final c = await pickCustomer(context);
                if (c != null) {
                  setState(() => _customer = c);
                  _loadDebt();
                }
              },
            ),
            if (_customer != null && _customerDebt != null && _customerDebt! > 0.0001)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text('دين سابق على الزبون: ${fmtSyp(roundTo(_customerDebt! * st.rate, 0))} (${fmtUsd(roundTo(_customerDebt!, 2))})',
                    style: const TextStyle(color: kWarning)),
              ),
            const SizedBox(height: 10),
            TextField(controller: _note, decoration: const InputDecoration(labelText: 'ملاحظة (اختياري)')),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('رجوع')),
          OutlinedButton(onPressed: () => _submit(false), child: const Text('حفظ بدون طباعة')),
          FilledButton.icon(
            onPressed: () => _submit(true),
            icon: const Icon(Icons.print),
            label: const Text('حفظ وطباعة'),
          ),
        ],
      ),
    );
  }

  Widget _bigRow(String k, String v, Color c) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: c.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(8)),
        child: Row(children: [
          Text(k, style: TextStyle(fontSize: 17, color: c)),
          const Spacer(),
          Text(v, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: c)),
        ]),
      );
}

/// اختيار زبون مع البحث وإمكانية إضافة زبون جديد
Future<Customer?> pickCustomer(BuildContext context) {
  return showDialog<Customer>(context: context, builder: (_) => const _CustomerPicker());
}

class _CustomerPicker extends StatefulWidget {
  const _CustomerPicker();

  @override
  State<_CustomerPicker> createState() => _CustomerPickerState();
}

class _CustomerPickerState extends State<_CustomerPicker> {
  final _q = TextEditingController();
  List<CustomerWithBalance> _list = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final l = await AppState.I.s.customers.list(search: _q.text);
    if (mounted) setState(() => _list = l);
  }

  @override
  Widget build(BuildContext context) {
    final rate = AppState.I.rate;
    return AlertDialog(
      title: const Text('اختيار زبون'),
      content: SizedBox(
        width: 480,
        height: 440,
        child: Column(children: [
          TextField(
            controller: _q,
            autofocus: true,
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'بحث بالاسم أو الهاتف'),
            onChanged: (_) => _load(),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _list.isEmpty
                ? const EmptyState('لا يوجد زبائن')
                : ListView(children: [
                    for (final c in _list)
                      ListTile(
                        title: Text(c.customer.name),
                        subtitle: Text(c.customer.phone ?? ''),
                        trailing: c.balanceUsd > 0.0001
                            ? Text('دين: ${fmtSyp(roundTo(c.balanceUsd * rate, 0))}', style: const TextStyle(color: kDanger))
                            : null,
                        onTap: () => Navigator.pop(context, c.customer),
                      ),
                  ]),
          ),
        ]),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
        FilledButton.icon(
          icon: const Icon(Icons.person_add),
          label: const Text('زبون جديد'),
          onPressed: () async {
            final c = await showCustomerForm(context, initialName: _q.text);
            if (c != null && context.mounted) Navigator.pop(context, c);
          },
        ),
      ],
    );
  }
}
