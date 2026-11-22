import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/license/license_service.dart';
import '../widgets/common.dart';

class ActivationScreen extends StatefulWidget {
  const ActivationScreen({super.key});

  @override
  State<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  final _code = TextEditingController();
  bool _busy = false;
  String? _error;

  Future<void> _activate() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final st = await AppState.I.license.activate(_code.text);
    if (st.state == LicenseState.valid) {
      await AppState.I.refreshLicense();
    } else {
      setState(() => _error = st.message);
    }
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final status = AppState.I.licenseStatus!;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 560,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.verified_user_outlined, size: 64, color: kPrimary),
                  const SizedBox(height: 12),
                  const Text(
                    'تفعيل البرنامج',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    status.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 24),
                  const Text('رمز هذا الجهاز:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kPrimary.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: kPrimary.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SelectableText(
                            status.machineCode,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 22, letterSpacing: 2, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          tooltip: 'نسخ',
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: status.machineCode));
                            showOk(context, 'تم نسخ رمز الجهاز');
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _code,
                    maxLines: 4,
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(labelText: 'كود التفعيل'),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 8),
                    Text(_error!, style: const TextStyle(color: kDanger)),
                  ],
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _busy ? null : _activate,
                    icon: const Icon(Icons.lock_open),
                    label: const Text('تفعيل'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
