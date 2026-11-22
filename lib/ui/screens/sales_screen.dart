import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/money.dart';
import '../../core/permissions.dart';
import '../../data/database.dart';
import '../../printing/printer.dart';
import '../widgets/common.dart';
import 'home_shell.dart';

/// سجل الفواتير: عرض، إعادة طباعة، إلغاء
class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  late DateTime _from = DateRangeBar.dayStart(DateTime.now());
  late DateTime _to = _from.add(const Duration(days: 1));
  int? _userId;
  List<Sale> _sales = [];
  List<User> _users = [];
  final _invoice = TextEditingController();

  AppState get st => AppState.I;
  bool get _canSeeAll => st.user!.can(Permission.viewAllShifts);

  @override
  void initState() {
    super.initState();
    if (!_canSeeAll) _userId = st.user!.id;
    _load();
  }

  Future<void> _load() async {
    final users = await st.s.users.list();
    final id = parseInt(_invoice.text);
    List<Sale> sales;
    if (id != null) {
      final d = await st.s.sales.details(id);
      sales = d == null || (!_canSeeAll && d.sale.userId != st.user!.id) ? [] : [d.sale];
    } else {
      sales = await st.s.sales.list(from: _from, to: _to, userId: _userId);
    }
    if (mounted) {
      setState(() {
        _sales = sales;
        _users = users;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final names = {for (final u in _users) u.id: u.fullName};
    final completed = _sales.where((s) => s.status == 'completed');
    final total = completed.fold<double>(0, (a, s) => a + s.totalSyp);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SectionTitle('الفواتير', icon: Icons.receipt_long_outlined),
        Row(children: [
          Expanded(
            child: DateRangeBar(
              from: _from,
              to: _to,
              onChanged: (f, t) {
                _from = f;
                _to = t;
                _invoice.clear();
                _load();
              },
            ),
          ),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          SizedBox(
            width: 200,
            child: NumField(
              controller: _invoice,
              label: 'رقم الفاتورة',
              decimal: false,
              onSubmitted: (_) => _load(),
              onChanged: (v) {
                if (v.isEmpty) _load();
              },
            ),
          ),
          const SizedBox(width: 10),
          IconButton(onPressed: _load, icon: const Icon(Icons.search)),
          const SizedBox(width: 10),
          if (_canSeeAll)
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
          const Spacer(),
          Text('${completed.length} فاتورة  •  ${fmtSyp(total)}', style: const TextStyle(fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 12),
        Expanded(
          child: SimpleTable(
            columns: const ['رقم', 'التاريخ', 'الصيدلي', 'الإجمالي', 'مدفوع ل.س', 'مدفوع \$', 'دين', 'الحالة'],
            rows: [
              for (final s in _sales)
                [
                  Text('${s.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(fmtDateTime(s.createdAt)),
                  Text(names[s.userId] ?? ''),
                  Text(fmtSyp(s.totalSyp), style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text(s.paidSyp > 0 ? fmtSypPlain(s.paidSyp - s.changeSyp) : '-'),
                  Text(s.paidUsd > 0 ? fmtUsd(s.paidUsd) : '-'),
                  Text(s.debtSyp > 0 ? fmtSyp(s.debtSyp) : '-', style: const TextStyle(color: kDanger)),
                  s.status == 'voided' ? const Badge2('ملغاة', color: kDanger) : const Badge2('مكتملة', color: kSuccess),
                ],
            ],
            onTaps: [
              for (final s in _sales)
                () async {
                  await showDialog(context: context, builder: (_) => SaleDetailsDialog(saleId: s.id));
                  _load();
                },
            ],
          ),
        ),
      ]),
    );
  }
}

class SaleDetailsDialog extends StatefulWidget {
  final int saleId;
  const SaleDetailsDialog({super.key, required this.saleId});

  @override
  State<SaleDetailsDialog> createState() => _SaleDetailsDialogState();
}

class _SaleDetailsDialogState extends State<SaleDetailsDialog> {
  AppState get st => AppState.I;

  Future<void> _void(Sale sale) async {
    if (st.shift == null) {
      await showOpenShiftDialog(context);
      if (st.shift == null) return;
    }
    if (!mounted) return;
    final reason = await promptText(context, 'إلغاء الفاتورة رقم ${sale.id}', label: 'سبب الإلغاء');
    if (reason == null || !mounted) return;
    final ok = await guard(context, () async {
      await st.s.sales.voidSale(actor: st.user!, currentShift: st.shift!, sale: sale, reason: reason);
      return true;
    }, success: 'تم إلغاء الفاتورة وإرجاع الكميات للمخزون');
    if (ok == true && mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: st.s.sales.details(widget.saleId),
      builder: (context, snap) {
        final d = snap.data;
        if (d == null) {
          return const AlertDialog(content: SizedBox(height: 100, child: Center(child: CircularProgressIndicator())));
        }
        final s = d.sale;
        return AlertDialog(
          title: Row(children: [
            Text('فاتورة رقم ${s.id}'),
            const SizedBox(width: 10),
            if (s.status == 'voided') const Badge2('ملغاة', color: kDanger),
          ]),
          content: SizedBox(
            width: 640,
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text('التاريخ: ${fmtDateTime(s.createdAt)}   •   الصيدلي: ${d.user?.fullName ?? '-'}'
                  '${d.customer != null ? '   •   الزبون: ${d.customer!.name}' : ''}'),
              if (s.status == 'voided')
                Text('سبب الإلغاء: ${s.voidReason ?? ''} (${fmtDateTime(s.voidedAt)})', style: const TextStyle(color: kDanger)),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 320),
                child: SimpleTable(
                  columns: const ['الصنف', 'الكمية', 'السعر', 'المجموع', 'مرتجع'],
                  rows: [
                    for (final it in d.items)
                      [
                        Text(it.medicineName),
                        Text('${it.quantity} ${it.unitLabel}'),
                        Text(fmtSypPlain(it.unitPriceSyp)),
                        Text(fmtSypPlain(it.totalSyp)),
                        Text(it.returnedBase > 0 ? '${it.returnedBase * it.quantity ~/ it.baseQuantity} ${it.unitLabel}' : ''),
                      ],
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Wrap(spacing: 24, runSpacing: 6, children: [
                if (s.discountSyp > 0) Text('الخصم: ${fmtSyp(s.discountSyp)}'),
                Text('الإجمالي: ${fmtSyp(s.totalSyp)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('سعر الصرف: ${fmtSypPlain(s.rate)}'),
                if (s.paidSyp > 0) Text('دفع ليرة: ${fmtSyp(s.paidSyp)}'),
                if (s.paidUsd > 0) Text('دفع دولار: ${fmtUsd(s.paidUsd)}'),
                if (s.changeSyp > 0) Text('الباقي: ${fmtSyp(s.changeSyp)}'),
                if (s.debtSyp > 0) Text('دين: ${fmtSyp(s.debtSyp)}', style: const TextStyle(color: kDanger)),
                if (st.user!.can(Permission.viewReports))
                  Text('الربح: ${fmtUsd(roundTo(s.totalUsd - s.costUsd, 2))}', style: const TextStyle(color: kSuccess)),
              ]),
              if (s.note != null) Padding(padding: const EdgeInsets.only(top: 6), child: Text('ملاحظة: ${s.note}')),
            ]),
          ),
          actions: [
            if (s.status == 'completed' && st.user!.can(Permission.voidSales))
              TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: kDanger),
                onPressed: () => _void(s),
                icon: const Icon(Icons.block),
                label: const Text('إلغاء الفاتورة'),
              ),
            OutlinedButton.icon(
              onPressed: () => guard(context, () => AppPrinter.printReceipt(d, copy: true)),
              icon: const Icon(Icons.print),
              label: const Text('إعادة طباعة'),
            ),
            FilledButton(onPressed: () => Navigator.pop(context), child: const Text('إغلاق')),
          ],
        );
      },
    );
  }
}
