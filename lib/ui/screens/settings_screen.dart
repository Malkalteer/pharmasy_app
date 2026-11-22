import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/money.dart';
import '../../core/permissions.dart';
import '../../data/database.dart';
import '../../printing/printer.dart';
import '../../services/audit_service.dart';
import '../../services/sales_service.dart';
import '../../services/settings_service.dart';
import '../widgets/common.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AppState get st => AppState.I;
  SettingsService get set => st.s.settings;

  late final _name = TextEditingController(text: set.pharmacyName);
  late final _address = TextEditingController(text: set.pharmacyAddress);
  late final _phone = TextEditingController(text: set.pharmacyPhone);
  late final _footer = TextEditingController(text: set.receiptFooter);
  late final _rate = TextEditingController(text: fmtSypPlain(set.exchangeRate).replaceAll(',', ''));
  late double _step = set.rounding.step;
  late RoundingMode _mode = set.rounding.mode;
  late String _paper = set.paperSize;
  late String? _printer = set.printerName;
  late bool _autoPrint = set.autoPrint;
  late int _expiryMonths = set.expiryAlertMonths;
  late String? _backupFolder = set.get(SettingKeys.backupFolder);
  late bool _autoBackup = set.getBool(SettingKeys.autoBackup, true);
  List<String> _printers = [];
  List<ExchangeRate> _rates = [];

  @override
  void initState() {
    super.initState();
    AppPrinter.printers().then((p) {
      if (mounted) setState(() => _printers = p.map((e) => e.name).toList());
    });
    set.rateHistory(limit: 10).then((r) {
      if (mounted) setState(() => _rates = r);
    });
  }

  Widget _section(String title, IconData icon, List<Widget> children) => Card(
    margin: const EdgeInsets.only(bottom: 16),
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: kPrimary),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    ),
  );

  Future<void> _saveGeneral() async {
    await guard(context, () async {
      await set.setAll({
        SettingKeys.pharmacyName: _name.text.trim(),
        SettingKeys.pharmacyAddress: _address.text.trim(),
        SettingKeys.pharmacyPhone: _phone.text.trim(),
        SettingKeys.receiptFooter: _footer.text.trim(),
        SettingKeys.paperSize: _paper,
        SettingKeys.printerName: _printer ?? '',
        SettingKeys.autoPrint: _autoPrint ? '1' : '0',
        SettingKeys.expiryAlertMonths: '$_expiryMonths',
        SettingKeys.backupFolder: _backupFolder ?? '',
        SettingKeys.autoBackup: _autoBackup ? '1' : '0',
      });
      await st.s.audit.log(st.user, AuditActions.settingsChanged);
      st.refresh();
    }, success: 'تم حفظ الإعدادات');
  }

  Future<void> _savePricing() async {
    final r = parseNum(_rate.text);
    if (r == null || r <= 0) {
      showError(context, 'سعر الصرف غير صحيح');
      return;
    }
    await guard(context, () async {
      final old = set.exchangeRate;
      if (r != old) {
        await set.setExchangeRate(r, st.user!.id);
        await st.s.audit.log(st.user, AuditActions.rateChanged, details: {'old': old, 'new': r});
      }
      await set.setAll({SettingKeys.roundingStep: '$_step', SettingKeys.roundingMode: _mode.name});
      _rates = await set.rateHistory(limit: 10);
      st.refresh();
    }, success: 'تم حفظ التسعير');
    setState(() {});
  }

  Future<void> _testPrint() async {
    final now = DateTime.now();
    final fake = SaleDetails(
      Sale(
        id: 0,
        shiftId: 0,
        userId: st.user!.id,
        createdAt: now,
        rate: set.exchangeRate,
        subtotalSyp: set.toSyp(2),
        discountSyp: 0,
        totalSyp: set.toSyp(2),
        totalUsd: 2,
        costUsd: 0,
        paidSyp: set.toSyp(2),
        paidUsd: 0,
        changeSyp: 0,
        debtSyp: 0,
        status: 'completed',
      ),
      [
        SaleItem(
          id: 0,
          saleId: 0,
          medicineId: 0,
          medicineName: 'دواء تجريبي',
          unit: 0,
          unitLabel: 'علبة',
          quantity: 1,
          baseQuantity: 1,
          unitPriceUsd: 2,
          unitPriceSyp: set.toSyp(2),
          totalSyp: set.toSyp(2),
          costUsd: 0,
          returnedBase: 0,
        ),
      ],
      st.user,
      null,
    );
    await guard(context, () => AppPrinter.printReceipt(fake));
  }

  Future<void> _restore() async {
    final f = await openFile(
      acceptedTypeGroups: [
        const XTypeGroup(label: 'نسخة احتياطية', extensions: ['phdb']),
      ],
    );
    if (f == null || !mounted) return;
    if (!await confirm(
      context,
      'استعادة نسخة احتياطية',
      'سيتم استبدال جميع البيانات الحالية بالنسخة المختارة عند إعادة تشغيل البرنامج.\n(سيتم أخذ نسخة من البيانات الحالية أولاً)',
      danger: true,
      ok: 'استعادة',
    )) {
      return;
    }
    if (!mounted) return;
    final ok = await guard(context, () async {
      await st.backup.scheduleRestore(File(f.path), st.user!);
      return true;
    });
    if (ok == true && mounted) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('أعد تشغيل البرنامج'),
          content: const Text('تم تجهيز الاستعادة. أغلق البرنامج وافتحه من جديد لتطبيق النسخة الاحتياطية.'),
          actions: [FilledButton(onPressed: () => exit(0), child: const Text('إغلاق البرنامج الآن'))],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final u = st.user!;
    final lic = st.licenseStatus;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionTitle('الإعدادات', icon: Icons.settings_outlined),
        if (u.can(Permission.editPrices))
          _section('سعر الصرف والتسعير', Icons.currency_exchange, [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: NumField(
                    controller: _rate,
                    label: 'سعر الدولار بالليرة السورية',
                    suffix: 'ل.س',
                    helper: 'كل الأسعار مسجلة بالدولار وتُضرب بهذا السعر',
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<double>(
                    initialValue: _step,
                    decoration: const InputDecoration(labelText: 'التقريب إلى أقرب'),
                    items: const [
                      DropdownMenuItem(value: 0, child: Text('بدون تقريب')),
                      DropdownMenuItem(value: 1, child: Text('1 ليرة')),
                      DropdownMenuItem(value: 5, child: Text('5 ليرات')),
                      DropdownMenuItem(value: 10, child: Text('10 ليرات')),
                      DropdownMenuItem(value: 25, child: Text('25 ليرة')),
                      DropdownMenuItem(value: 50, child: Text('50 ليرة')),
                      DropdownMenuItem(value: 100, child: Text('100 ليرة')),
                      DropdownMenuItem(value: 500, child: Text('500 ليرة')),
                    ],
                    onChanged: (v) => setState(() => _step = v ?? 1),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<RoundingMode>(
                    initialValue: _mode,
                    decoration: const InputDecoration(labelText: 'طريقة التقريب'),
                    items: const [
                      DropdownMenuItem(value: RoundingMode.nearest, child: Text('للأقرب')),
                      DropdownMenuItem(value: RoundingMode.up, child: Text('للأعلى دائماً')),
                      DropdownMenuItem(value: RoundingMode.down, child: Text('للأدنى دائماً')),
                    ],
                    onChanged: (v) => setState(() => _mode = v ?? RoundingMode.nearest),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Builder(
              builder: (_) {
                final r = parseNum(_rate.text) ?? 0;
                final cfg = RoundingConfig(step: _step, mode: _mode);
                return Text(
                  'مثال: دواء بسعر 2.35\$ × ${fmtSypPlain(r)} = ${fmtSypPlain(roundTo(2.35 * r, 2))} ← يُباع بـ ${fmtSyp(usdToSyp(2.35, r, cfg))}',
                  style: const TextStyle(color: kPrimary),
                );
              },
            ),
            const SizedBox(height: 10),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: FilledButton(onPressed: _savePricing, child: const Text('حفظ التسعير')),
            ),
            if (_rates.isNotEmpty) ...[
              const Divider(),
              const Text('آخر تغييرات سعر الصرف:', style: TextStyle(fontWeight: FontWeight.bold)),
              for (final r in _rates) Text('${fmtDateTime(r.createdAt)}  —  ${fmtSyp(r.rate)}'),
            ],
          ]),
        if (u.isOwner) ...[
          _section('بيانات الصيدلية والفاتورة', Icons.store, [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _name,
                    decoration: const InputDecoration(labelText: 'اسم الصيدلية'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _phone,
                    decoration: const InputDecoration(labelText: 'الهاتف'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _address,
              decoration: const InputDecoration(labelText: 'العنوان'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _footer,
              decoration: const InputDecoration(labelText: 'نص أسفل الفاتورة'),
            ),
          ]),
          _section('الطباعة', Icons.print, [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _paper,
                    decoration: const InputDecoration(labelText: 'حجم ورق الفاتورة'),
                    items: const [
                      DropdownMenuItem(value: 'roll80', child: Text('طابعة حرارية 80 مم')),
                      DropdownMenuItem(value: 'roll58', child: Text('طابعة حرارية 58 مم')),
                      DropdownMenuItem(value: 'a5', child: Text('A5')),
                      DropdownMenuItem(value: 'a4', child: Text('A4')),
                    ],
                    onChanged: (v) => setState(() => _paper = v ?? 'roll80'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String?>(
                    initialValue: _printers.contains(_printer) ? _printer : null,
                    decoration: const InputDecoration(labelText: 'طابعة الفواتير'),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('اسأل في كل مرة (نافذة الطباعة)')),
                      for (final p in _printers) DropdownMenuItem(value: p, child: Text(p)),
                    ],
                    onChanged: (v) => setState(() => _printer = v),
                  ),
                ),
              ],
            ),
            SwitchListTile(
              value: _autoPrint,
              title: const Text('الطباعة تلقائياً عند الضغط على Enter في نافذة الدفع'),
              onChanged: (v) => setState(() => _autoPrint = v),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: OutlinedButton.icon(
                onPressed: _testPrint,
                icon: const Icon(Icons.print),
                label: const Text('طباعة تجريبية'),
              ),
            ),
          ]),
          _section('التنبيهات', Icons.notifications_active_outlined, [
            DropdownButtonFormField<int>(
              initialValue: _expiryMonths,
              decoration: const InputDecoration(labelText: 'التنبيه قبل انتهاء الصلاحية بـ'),
              items: const [
                DropdownMenuItem(value: 1, child: Text('شهر')),
                DropdownMenuItem(value: 2, child: Text('شهرين')),
                DropdownMenuItem(value: 3, child: Text('3 أشهر')),
                DropdownMenuItem(value: 6, child: Text('6 أشهر')),
                DropdownMenuItem(value: 12, child: Text('سنة')),
              ],
              onChanged: (v) => setState(() => _expiryMonths = v ?? 3),
            ),
          ]),
          _section('النسخ الاحتياطي', Icons.backup_outlined, [
            Text('آخر نسخة: ${fmtDateTime(st.backup.lastBackupAt)}'),
            const SizedBox(height: 6),
            Text(
              'يتم حفظ نسخة يومية تلقائياً داخل مجلد البرنامج، وأيضاً في المجلد الخارجي إن وُجد (فلاشة USB أو مجلد Google Drive / OneDrive للنسخ السحابي).',
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InputDecorator(
                    decoration: const InputDecoration(labelText: 'مجلد النسخ الخارجي'),
                    child: Text(
                      _backupFolder == null || _backupFolder!.isEmpty ? 'غير محدد' : _backupFolder!,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () async {
                    final d = await getDirectoryPath(confirmButtonText: 'اختيار');
                    if (d != null) setState(() => _backupFolder = d);
                  },
                  icon: const Icon(Icons.folder_open),
                  label: const Text('اختيار'),
                ),
                if (_backupFolder != null && _backupFolder!.isNotEmpty)
                  IconButton(onPressed: () => setState(() => _backupFolder = null), icon: const Icon(Icons.clear)),
              ],
            ),
            SwitchListTile(
              value: _autoBackup,
              title: const Text('نسخ احتياطي تلقائي يومي'),
              onChanged: (v) => setState(() => _autoBackup = v),
            ),
            Wrap(
              spacing: 10,
              children: [
                FilledButton.icon(
                  onPressed: () async {
                    final r = await guard(context, () => st.backup.backup(actor: u, extraFolder: _backupFolder));
                    if (r == null || !context.mounted) return;
                    if (r.errors.isNotEmpty) showError(context, r.errors.join('\n'));
                    if (r.ok) showOk(context, 'تم حفظ النسخة في ${r.written.length} مكان');
                    setState(() {});
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('نسخة احتياطية الآن'),
                ),
                OutlinedButton.icon(
                  onPressed: _restore,
                  icon: const Icon(Icons.restore),
                  label: const Text('استعادة نسخة'),
                ),
              ],
            ),
            const SizedBox(height: 6),
            SelectableText(
              'مجلد البيانات: ${st.dataDir.path}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ]),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: FilledButton.icon(
              onPressed: _saveGeneral,
              icon: const Icon(Icons.save),
              label: const Text('حفظ الإعدادات'),
            ),
          ),
          const SizedBox(height: 16),
        ],
        _section('حسابي', Icons.person, [
          Text('${u.fullName} (${u.username}) — ${roleLabel(u.role)}'),
          const SizedBox(height: 10),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.key),
              label: const Text('تغيير كلمة المرور'),
              onPressed: () async {
                final old = await promptText(context, 'كلمة المرور الحالية', obscure: true);
                if (old == null || !context.mounted) return;
                if (!await st.s.users.verifyPassword(u, old)) {
                  if (context.mounted) showError(context, 'كلمة المرور الحالية غير صحيحة');
                  return;
                }
                if (!context.mounted) return;
                final p = await promptText(context, 'كلمة المرور الجديدة', obscure: true);
                if (p == null || !context.mounted) return;
                await guard(
                  context,
                  () => st.s.users.changePassword(actor: u, user: u, newPassword: p),
                  success: 'تم التغيير',
                );
                await st.reloadUser();
              },
            ),
          ),
        ]),
        _section('الترخيص', Icons.verified_user_outlined, [
          Text(lic?.message ?? ''),
          if (lic?.data != null) ...[
            Text('مرخّص لـ: ${lic!.data!.customer}'),
            Text('نوع الترخيص: ${lic.data!.type == 'lifetime' ? 'دائم' : 'اشتراك'}'),
            if (lic.data!.expiresAt != null) Text('ينتهي في: ${fmtDate(lic.data!.expiresAt)}'),
          ],
          SelectableText('رمز الجهاز: ${lic?.machineCode ?? ''}', textDirection: TextDirection.ltr),
        ]),
      ],
    );
  }
}
