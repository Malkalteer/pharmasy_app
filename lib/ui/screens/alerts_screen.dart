import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/money.dart';
import '../../core/permissions.dart';
import '../../core/units.dart';
import '../../printing/printer.dart';
import '../../services/inventory_service.dart';
import '../widgets/common.dart';
import 'medicines_screen.dart';

/// قائمة النواقص وتنبيهات انتهاء الصلاحية
class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  List<MedicineStock> _short = [];
  List<BatchWithMedicine> _expiring = [];
  late int _months = AppState.I.s.settings.expiryAlertMonths;

  AppState get st => AppState.I;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final s = await st.s.inventory.shortages();
    final e = await st.s.inventory.expiring(months: _months);
    if (mounted) {
      setState(() {
        _short = s;
        _expiring = e;
      });
    }
  }

  String _shortageText() {
    final b = StringBuffer('قائمة نواقص - ${st.s.settings.pharmacyName} - ${fmtDate(DateTime.now())}\n');
    var i = 1;
    for (final s in _short) {
      final need = s.shortageBoxes.ceil();
      b.writeln('${i++}. ${s.medicine.name}${s.medicine.manufacturer != null ? ' (${s.medicine.manufacturer})' : ''} : $need ${s.medicine.boxName}');
    }
    return b.toString();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TabBar(
            isScrollable: true,
            labelStyle: const TextStyle(fontFamily: 'Tajawal', fontWeight: FontWeight.bold, fontSize: 16),
            tabs: [
              Tab(text: 'النواقص (${_short.length})', icon: const Icon(Icons.production_quantity_limits)),
              Tab(text: 'انتهاء الصلاحية (${_expiring.length})', icon: const Icon(Icons.event_busy)),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: TabBarView(children: [
              // ----- النواقص -----
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Wrap(spacing: 8, children: [
                  FilledButton.icon(
                    onPressed: _short.isEmpty
                        ? null
                        : () {
                            Clipboard.setData(ClipboardData(text: _shortageText()));
                            showOk(context, 'تم نسخ القائمة. يمكنك لصقها في واتساب وإرسالها للمستودع');
                          },
                    icon: const Icon(Icons.copy),
                    label: const Text('نسخ القائمة (لواتساب)'),
                  ),
                  OutlinedButton.icon(
                    onPressed: _short.isEmpty
                        ? null
                        : () => AppPrinter.printTable(
                              title: 'قائمة النواقص',
                              headers: ['#', 'الدواء', 'الشركة', 'المتوفر', 'الحد الأدنى', 'المطلوب'],
                              rows: [
                                for (var i = 0; i < _short.length; i++)
                                  [
                                    '${i + 1}',
                                    _short[i].medicine.name,
                                    _short[i].medicine.manufacturer ?? '',
                                    _short[i].medicine.describeQty(_short[i].available),
                                    '${fmtQty(_short[i].medicine.minStockBoxes)} ${_short[i].medicine.boxName}',
                                    '${_short[i].shortageBoxes.ceil()} ${_short[i].medicine.boxName}',
                                  ],
                              ],
                            ),
                    icon: const Icon(Icons.print),
                    label: const Text('طباعة / حفظ PDF'),
                  ),
                ]),
                const SizedBox(height: 6),
                Text('تظهر هنا الأدوية التي كميتها أقل من الحد الأدنى المحدد في بطاقة الدواء.',
                    style: TextStyle(color: Colors.grey.shade600)),
                const SizedBox(height: 10),
                Expanded(
                  child: SimpleTable(
                    columns: const ['الدواء', 'الشركة', 'المتوفر', 'الحد الأدنى', 'المطلوب طلبه'],
                    rows: [
                      for (final s in _short)
                        [
                          Text(s.medicine.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(s.medicine.manufacturer ?? ''),
                          Text(s.medicine.describeQty(s.available),
                              style: TextStyle(color: s.available <= 0 ? kDanger : kWarning)),
                          Text('${fmtQty(s.medicine.minStockBoxes)} ${s.medicine.boxName}'),
                          Text('${s.shortageBoxes.ceil()} ${s.medicine.boxName}',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                    ],
                    onTaps: [
                      for (final s in _short)
                        () async {
                          await showDialog(context: context, builder: (_) => MedicineDetailsDialog(medicineId: s.medicine.id));
                          _load();
                        },
                    ],
                  ),
                ),
              ]),
              // ----- الانتهاء -----
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Row(children: [
                  const Text('عرض الدفعات التي تنتهي خلال: '),
                  const SizedBox(width: 8),
                  SegmentedButton<int>(
                    segments: const [
                      ButtonSegment(value: 0, label: Text('المنتهية')),
                      ButtonSegment(value: 1, label: Text('شهر')),
                      ButtonSegment(value: 3, label: Text('3 أشهر')),
                      ButtonSegment(value: 6, label: Text('6 أشهر')),
                      ButtonSegment(value: 12, label: Text('سنة')),
                    ],
                    selected: {_months},
                    onSelectionChanged: (v) {
                      _months = v.first;
                      _load();
                    },
                  ),
                  const Spacer(),
                  OutlinedButton.icon(
                    onPressed: () => AppPrinter.printTable(
                      title: 'الأدوية القريبة من الانتهاء',
                      headers: ['الدواء', 'التشغيلة', 'تاريخ الانتهاء', 'الكمية'],
                      rows: [
                        for (final e in _expiring)
                          [e.medicine.name, e.batch.batchNumber ?? '', fmtDate(e.batch.expiryDate), e.medicine.describeQty(e.batch.quantity)],
                      ],
                    ),
                    icon: const Icon(Icons.print),
                    label: const Text('طباعة'),
                  ),
                ]),
                const SizedBox(height: 10),
                Expanded(
                  child: SimpleTable(
                    columns: const ['الدواء', 'التشغيلة', 'تاريخ الانتهاء', 'المتبقي', 'الكمية', ''],
                    rows: [
                      for (final e in _expiring)
                        () {
                          final exp = e.batch.expiryDate!;
                          final days = exp.difference(DateTime(today.year, today.month, today.day)).inDays;
                          final expired = days < 0;
                          return <Widget>[
                            Text(e.medicine.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(e.batch.batchNumber ?? '-'),
                            Text(fmtDate(exp)),
                            Badge2(expired ? 'منتهي منذ ${-days} يوم' : 'بعد $days يوم',
                                color: expired ? kDanger : (days < 30 ? kWarning : kPrimary)),
                            Text(e.medicine.describeQty(e.batch.quantity)),
                            if (expired && st.user!.can(Permission.manageMedicines))
                              TextButton.icon(
                                style: TextButton.styleFrom(foregroundColor: kDanger),
                                icon: const Icon(Icons.delete_forever),
                                label: const Text('إتلاف'),
                                onPressed: () async {
                                  if (!await confirm(context, 'إتلاف دفعة منتهية',
                                      'سيتم تصفير كمية ${e.medicine.describeQty(e.batch.quantity)} من "${e.medicine.name}" وتسجيلها كتالف منتهي الصلاحية.',
                                      danger: true, ok: 'إتلاف')) {
                                    return;
                                  }
                                  if (!context.mounted) return;
                                  await guard(
                                    context,
                                    () => st.s.inventory.adjustBatch(
                                        actor: st.user!, batch: e.batch, newQuantity: 0, reason: 'expired', note: 'إتلاف منتهي'),
                                    success: 'تم الإتلاف',
                                  );
                                  _load();
                                },
                              )
                            else
                              const SizedBox(),
                          ];
                        }(),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text('يمكنك أيضاً إرجاع الأدوية القريبة من الانتهاء إلى المورد من صفحة المرتجعات.',
                    style: TextStyle(color: Colors.grey.shade600)),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}
