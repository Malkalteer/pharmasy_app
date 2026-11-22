import 'dart:io';

import 'package:material_ui/material_ui.dart';

import 'core/app_state.dart';
import 'dev/demo_seed.dart';
import 'ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppState.I.init();
  // بيانات تجريبية للعرض فقط: PHARMACY_DEMO=1
  if (Platform.environment['PHARMACY_DEMO'] == '1' && AppState.I.startupError == null) {
    await seedDemo(AppState.I.s);
    await AppState.I.s.settings.load();
  }
  runApp(const PharmacyApp());
}
