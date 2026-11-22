import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/money.dart';
import '../../core/permissions.dart';
import '../../services/settings_service.dart';
import '../widgets/common.dart';

/// الإعداد الأول: بيانات الصيدلية وحساب المالك وسعر الصرف
class SetupScreen extends StatefulWidget {
  final VoidCallback onDone;
  const SetupScreen({super.key, required this.onDone});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final _pharmacy = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();
  final _name = TextEditingController();
  final _user = TextEditingController(text: 'admin');
  final _pass = TextEditingController();
  final _pass2 = TextEditingController();
  final _rate = TextEditingController();
  bool _busy = false;

  Future<void> _save() async {
    if (_pharmacy.text.trim().isEmpty || _name.text.trim().isEmpty) {
      showError(context, 'يرجى إدخال اسم الصيدلية واسم المالك');
      return;
    }
    if (_pass.text != _pass2.text) {
      showError(context, 'كلمتا المرور غير متطابقتين');
      return;
    }
    final rate = parseNum(_rate.text);
    if (rate == null || rate <= 0) {
      showError(context, 'يرجى إدخال سعر صرف الدولار');
      return;
    }
    setState(() => _busy = true);
    final s = AppState.I.s;
    final ok = await guard(context, () async {
      final u = await s.users.create(
        actor: null,
        username: _user.text,
        fullName: _name.text,
        password: _pass.text,
        role: roleOwner,
      );
      await s.settings.setAll({
        SettingKeys.pharmacyName: _pharmacy.text.trim(),
        SettingKeys.pharmacyAddress: _address.text.trim(),
        SettingKeys.pharmacyPhone: _phone.text.trim(),
      });
      await s.settings.setExchangeRate(rate, u.id);
      return true;
    });
    if (mounted) setState(() => _busy = false);
    if (ok == true) widget.onDone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: 640,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.local_pharmacy, size: 56, color: kPrimary),
                    const SizedBox(height: 8),
                    const Text(
                      'مرحباً بك! إعداد الصيدلية لأول مرة',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'بيانات الصيدلية',
                      style: TextStyle(fontWeight: FontWeight.bold, color: kPrimary),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _pharmacy,
                      decoration: const InputDecoration(labelText: 'اسم الصيدلية *'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _address,
                            decoration: const InputDecoration(labelText: 'العنوان'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _phone,
                            decoration: const InputDecoration(labelText: 'الهاتف'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'حساب المالك (المدير)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: kPrimary),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _name,
                            decoration: const InputDecoration(labelText: 'الاسم الكامل *'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _user,
                            textDirection: TextDirection.ltr,
                            decoration: const InputDecoration(labelText: 'اسم المستخدم *'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _pass,
                            obscureText: true,
                            decoration: const InputDecoration(labelText: 'كلمة المرور *'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _pass2,
                            obscureText: true,
                            decoration: const InputDecoration(labelText: 'تأكيد كلمة المرور *'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'سعر الصرف',
                      style: TextStyle(fontWeight: FontWeight.bold, color: kPrimary),
                    ),
                    const SizedBox(height: 8),
                    NumField(controller: _rate, label: 'سعر الدولار بالليرة السورية *', suffix: 'ل.س'),
                    const SizedBox(height: 24),
                    FilledButton(onPressed: _busy ? null : _save, child: const Text('حفظ والبدء')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
