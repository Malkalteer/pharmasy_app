import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/permissions.dart';
import '../../data/database.dart';
import '../widgets/common.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<User> _users = [];

  AppState get st => AppState.I;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final l = await st.s.users.list();
    if (mounted) setState(() => _users = l);
  }

  Future<void> _edit([User? u]) async {
    final name = TextEditingController(text: u?.fullName);
    final username = TextEditingController(text: u?.username);
    final pass = TextEditingController();
    var role = u?.role ?? rolePharmacist;
    var active = u?.active ?? true;
    final perms = u?.permissionSet ?? {...defaultPharmacistPermissions};
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setD) => AlertDialog(
          title: Text(u == null ? 'مستخدم جديد' : 'تعديل: ${u.fullName}'),
          content: SizedBox(
            width: 560,
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Row(children: [
                  Expanded(child: TextField(controller: name, decoration: const InputDecoration(labelText: 'الاسم الكامل'))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: username,
                      enabled: u == null,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(labelText: 'اسم المستخدم'),
                    ),
                  ),
                ]),
                if (u == null) ...[
                  const SizedBox(height: 10),
                  TextField(controller: pass, obscureText: true, decoration: const InputDecoration(labelText: 'كلمة المرور')),
                ],
                const SizedBox(height: 12),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: rolePharmacist, label: Text('صيدلي'), icon: Icon(Icons.person)),
                    ButtonSegment(value: roleOwner, label: Text('مالك (كل الصلاحيات)'), icon: Icon(Icons.admin_panel_settings)),
                  ],
                  selected: {role},
                  onSelectionChanged: (v) => setD(() => role = v.first),
                ),
                if (role == rolePharmacist) ...[
                  const SizedBox(height: 12),
                  const Text('الصلاحيات (البيع متاح دائماً):', style: TextStyle(fontWeight: FontWeight.bold)),
                  for (final p in Permission.values)
                    CheckboxListTile(
                      dense: true,
                      value: perms.contains(p),
                      title: Text(p.label),
                      onChanged: (v) => setD(() => v == true ? perms.add(p) : perms.remove(p)),
                    ),
                ],
                if (u != null)
                  SwitchListTile(
                    value: active,
                    title: const Text('الحساب فعّال'),
                    onChanged: (v) => setD(() => active = v),
                  ),
              ]),
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
    await guard(context, () async {
      if (u == null) {
        await st.s.users.create(
          actor: st.user,
          username: username.text,
          fullName: name.text,
          password: pass.text,
          role: role,
          permissions: perms,
        );
      } else {
        await st.s.users.update(
            actor: st.user!, user: u, fullName: name.text, role: role, permissions: perms, active: active);
      }
    }, success: 'تم الحفظ');
    await st.reloadUser();
    _load();
  }

  Future<void> _resetPassword(User u) async {
    final p = await promptText(context, 'كلمة مرور جديدة لـ ${u.fullName}', label: 'كلمة المرور', obscure: true);
    if (p == null || !mounted) return;
    await guard(context, () => st.s.users.changePassword(actor: st.user!, user: u, newPassword: p),
        success: 'تم تغيير كلمة المرور');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SectionTitle('المستخدمون والصلاحيات', icon: Icons.manage_accounts_outlined, actions: [
          FilledButton.icon(onPressed: () => _edit(), icon: const Icon(Icons.person_add), label: const Text('مستخدم جديد')),
        ]),
        Expanded(
          child: SimpleTable(
            columns: const ['الاسم', 'اسم المستخدم', 'الدور', 'الصلاحيات', 'الحالة', ''],
            rows: [
              for (final u in _users)
                [
                  Text(u.fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(u.username),
                  Badge2(roleLabel(u.role), color: u.isOwner ? kPrimary : Colors.blueGrey),
                  SizedBox(
                    width: 360,
                    child: Text(u.isOwner ? 'جميع الصلاحيات' : u.permissionSet.map((p) => p.label).join('، '),
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                  ),
                  u.active ? const Badge2('فعّال', color: kSuccess) : const Badge2('موقوف', color: kDanger),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(tooltip: 'تعديل', icon: const Icon(Icons.edit), onPressed: () => _edit(u)),
                    IconButton(tooltip: 'تغيير كلمة المرور', icon: const Icon(Icons.key), onPressed: () => _resetPassword(u)),
                  ]),
                ],
            ],
          ),
        ),
      ]),
    );
  }
}
