import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../widgets/common.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _user = TextEditingController();
  final _pass = TextEditingController();
  final _passFocus = FocusNode();
  bool _busy = false;
  String? _error;

  Future<void> _login() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final u = await AppState.I.s.users.authenticate(_user.text, _pass.text);
    if (u == null) {
      setState(() {
        _busy = false;
        _error = 'اسم المستخدم أو كلمة المرور غير صحيحة';
      });
      _pass.clear();
      _passFocus.requestFocus();
      return;
    }
    await AppState.I.login(u);
  }

  @override
  Widget build(BuildContext context) {
    final st = AppState.I;
    return Scaffold(
      body: Row(children: [
        Expanded(
          child: Container(
            color: kPrimary,
            child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.local_pharmacy, size: 96, color: Colors.white),
                const SizedBox(height: 16),
                Text(st.s.settings.pharmacyName,
                    style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('نظام إدارة الصيدلية', style: TextStyle(color: Colors.white70, fontSize: 18)),
                if (st.licenseStatus?.data != null) ...[
                  const SizedBox(height: 24),
                  Text('مرخّص لـ: ${st.licenseStatus!.data!.customer}',
                      style: const TextStyle(color: Colors.white60)),
                ],
                if (st.restoredOnStartup) ...[
                  const SizedBox(height: 24),
                  const Text('تمت استعادة النسخة الاحتياطية بنجاح', style: TextStyle(color: Colors.white)),
                ],
              ]),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SizedBox(
              width: 380,
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const Text('تسجيل الدخول', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                TextField(
                  controller: _user,
                  autofocus: true,
                  textDirection: TextDirection.ltr,
                  decoration: const InputDecoration(labelText: 'اسم المستخدم', prefixIcon: Icon(Icons.person)),
                  onSubmitted: (_) => _passFocus.requestFocus(),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _pass,
                  focusNode: _passFocus,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'كلمة المرور', prefixIcon: Icon(Icons.lock)),
                  onSubmitted: (_) => _login(),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 10),
                  Text(_error!, style: const TextStyle(color: kDanger)),
                ],
                const SizedBox(height: 20),
                FilledButton(onPressed: _busy ? null : _login, child: const Text('دخول')),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
