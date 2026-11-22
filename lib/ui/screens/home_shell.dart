import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/money.dart';
import '../../core/permissions.dart';
import '../../data/database.dart';
import '../../services/audit_service.dart';
import '../widgets/common.dart';
import 'alerts_screen.dart';
import 'audit_screen.dart';
import 'customers_screen.dart';
import 'dashboard_screen.dart';
import 'medicines_screen.dart';
import 'pos_screen.dart';
import 'purchases_screen.dart';
import 'reports_screen.dart';
import 'returns_screen.dart';
import 'sales_screen.dart';
import 'settings_screen.dart';
import 'shift_screen.dart';
import 'suppliers_screen.dart';
import 'users_screen.dart';

class _Page {
  final String label;
  final IconData icon;
  final bool Function(User u) visible;
  final Widget Function() build;
  const _Page(this.label, this.icon, this.visible, this.build);
}

bool _all(User u) => true;

final _pages = <_Page>[
  _Page('لوحة اليوم', Icons.dashboard_outlined, (u) => u.can(Permission.viewReports), () => const DashboardScreen()),
  _Page('البيع', Icons.point_of_sale, _all, () => const PosScreen()),
  _Page('الفواتير', Icons.receipt_long_outlined, _all, () => const SalesScreen()),
  _Page('الأدوية والمخزون', Icons.medication_outlined, _all, () => const MedicinesScreen()),
  _Page('النواقص والانتهاء', Icons.notification_important_outlined, _all, () => const AlertsScreen()),
  _Page(
    'المشتريات',
    Icons.local_shipping_outlined,
    (u) => u.can(Permission.managePurchases),
    () => const PurchasesScreen(),
  ),
  _Page('الموردون', Icons.warehouse_outlined, (u) => u.can(Permission.managePurchases), () => const SuppliersScreen()),
  _Page('الزبائن والديون', Icons.people_alt_outlined, _all, () => const CustomersScreen()),
  _Page(
    'المرتجعات',
    Icons.assignment_return_outlined,
    (u) => u.can(Permission.returns) || u.can(Permission.managePurchases),
    () => const ReturnsScreen(),
  ),
  _Page('الدرج والوردية', Icons.account_balance_wallet_outlined, _all, () => const ShiftScreen()),
  _Page('التقارير والأرباح', Icons.bar_chart, (u) => u.can(Permission.viewReports), () => const ReportsScreen()),
  _Page('المستخدمون', Icons.manage_accounts_outlined, (u) => u.isOwner, () => const UsersScreen()),
  _Page('سجل العمليات', Icons.history, (u) => u.isOwner, () => const AuditScreen()),
  _Page('الإعدادات', Icons.settings_outlined, _all, () => const SettingsScreen()),
];

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  /// الانتقال إلى صفحة بالاسم من أي مكان
  static void Function(String label)? navigate;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  String _current = 'البيع';

  @override
  void initState() {
    super.initState();
    HomeShell.navigate = (l) => setState(() => _current = l);
    AppState.I.addListener(_onChange);
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeOpenShift());
  }

  @override
  void dispose() {
    AppState.I.removeListener(_onChange);
    HomeShell.navigate = null;
    super.dispose();
  }

  void _onChange() {
    if (mounted) setState(() {});
  }

  Future<void> _maybeOpenShift() async {
    if (AppState.I.shift == null && mounted) {
      await showOpenShiftDialog(context);
    }
  }

  Future<void> _editRate() async {
    final st = AppState.I;
    if (!st.user!.can(Permission.editPrices)) {
      showError(context, PermissionDenied(Permission.editPrices));
      return;
    }
    final v = await promptText(
      context,
      'تعديل سعر صرف الدولار',
      label: 'سعر الدولار بالليرة',
      initial: fmtSypPlain(st.rate).replaceAll(',', ''),
    );
    final r = parseNum(v);
    if (r == null || r <= 0) return;
    if (!mounted) return;
    await guard(context, () async {
      final old = st.rate;
      await st.s.settings.setExchangeRate(r, st.user!.id);
      await st.s.audit.log(st.user, AuditActions.rateChanged, details: {'old': old, 'new': r});
      st.refresh();
    }, success: 'تم تحديث سعر الصرف. جميع الأسعار بالليرة تُحسب الآن على السعر الجديد');
  }

  @override
  Widget build(BuildContext context) {
    final st = AppState.I;
    final user = st.user!;
    final visible = _pages.where((p) => p.visible(user)).toList();
    final page = visible.firstWhere((p) => p.label == _current, orElse: () => visible[1 < visible.length ? 1 : 0]);
    final lic = st.licenseStatus;

    return Scaffold(
      body: Row(
        children: [
          // الشريط الجانبي
          Container(
            width: 220,
            color: const Color(0xFF0B3B37),
            child: Column(
              children: [
                const SizedBox(height: 18),
                const Icon(Icons.local_pharmacy, color: Colors.white, size: 40),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    st.s.settings.pharmacyName,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    children: [
                      for (final p in visible)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Material(
                            color: p == page ? Colors.white.withValues(alpha: 0.14) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            child: ListTile(
                              dense: true,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              leading: Icon(p.icon, color: p == page ? Colors.white : Colors.white70, size: 22),
                              title: Text(
                                p.label,
                                style: TextStyle(
                                  color: p == page ? Colors.white : Colors.white70,
                                  fontWeight: p == page ? FontWeight.bold : FontWeight.normal,
                                  fontSize: 14.5,
                                ),
                              ),
                              onTap: () => setState(() => _current = p.label),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (lic?.state.name == 'development')
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('نسخة تطوير', style: TextStyle(color: Colors.amber)),
                  ),
              ],
            ),
          ),
          // المحتوى
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 58,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                  ),
                  child: Row(
                    children: [
                      Text(page.label, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Tooltip(
                        message: 'اضغط لتعديل سعر الصرف',
                        child: ActionChip(
                          avatar: const Icon(Icons.currency_exchange, size: 18, color: kPrimary),
                          label: Text(
                            '1\$ = ${fmtSyp(st.rate)}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: kPrimary),
                          ),
                          onPressed: _editRate,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ActionChip(
                        avatar: Icon(
                          st.shift == null ? Icons.lock_outline : Icons.lock_open,
                          size: 18,
                          color: st.shift == null ? kWarning : kSuccess,
                        ),
                        label: Text(st.shift == null ? 'لا توجد وردية مفتوحة' : 'وردية #${st.shift!.id} مفتوحة'),
                        onPressed: () => setState(() => _current = 'الدرج والوردية'),
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: kPrimary,
                        child: Text(
                          user.fullName.isEmpty ? '?' : user.fullName.characters.first,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(roleLabel(user.role), style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                        ],
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        tooltip: 'تسجيل خروج',
                        icon: const Icon(Icons.logout),
                        onPressed: () async {
                          if (st.shift != null) {
                            final ok = await confirm(
                              context,
                              'تسجيل خروج',
                              'ورديتك ما زالت مفتوحة. إذا انتهى دوامك يجب إغلاق الوردية وتسليم الدرج أولاً.\nهل تريد الخروج مع إبقاء الوردية مفتوحة؟',
                              ok: 'خروج',
                            );
                            if (!ok) return;
                          }
                          await st.logout();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: KeyedSubtree(key: ValueKey(page.label), child: page.build()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// نافذة فتح وردية جديدة
Future<void> showOpenShiftDialog(BuildContext context) async {
  final syp = TextEditingController(text: '0');
  final usd = TextEditingController(text: '0');
  final ok = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      title: const Text('فتح وردية جديدة'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('أدخل المبلغ الموجود في الدرج عند بداية الدوام (فكّة):'),
            const SizedBox(height: 12),
            NumField(controller: syp, label: 'ليرة سورية', suffix: 'ل.س', autofocus: true),
            const SizedBox(height: 10),
            NumField(controller: usd, label: 'دولار', suffix: '\$'),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('لاحقاً')),
        FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('فتح الوردية')),
      ],
    ),
  );
  if (ok != true || !context.mounted) return;
  final st = AppState.I;
  await guard(context, () async {
    final sh = await st.s.shifts.open(
      user: st.user!,
      openingSyp: parseNum(syp.text) ?? 0,
      openingUsd: parseNum(usd.text) ?? 0,
    );
    await st.setShift(sh);
  }, success: 'تم فتح الوردية');
}

/// غلاف للصفحات التي تحتاج وردية مفتوحة
class RequireShift extends StatelessWidget {
  final Widget child;
  const RequireShift({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (AppState.I.shift != null) return child;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock_clock, size: 64, color: kWarning),
          const SizedBox(height: 12),
          const Text('يجب فتح وردية قبل البيع أو استلام النقود', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => showOpenShiftDialog(context),
            icon: const Icon(Icons.lock_open),
            label: const Text('فتح وردية'),
          ),
        ],
      ),
    );
  }
}
