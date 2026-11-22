import 'package:material_ui/material_ui.dart';

import '../core/app_state.dart';
import 'screens/activation_screen.dart';
import 'screens/home_shell.dart';
import 'screens/login_screen.dart';
import 'screens/setup_screen.dart';
import 'widgets/common.dart';

class PharmacyApp extends StatelessWidget {
  const PharmacyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: kPrimary, brightness: Brightness.light);
    return MaterialApp(
      title: 'نظام إدارة الصيدلية',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: ThemeData(
        colorScheme: scheme,
        fontFamily: 'Tajawal',
        scaffoldBackgroundColor: const Color(0xFFF3F6F6),
        visualDensity: VisualDensity.standard,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          isDense: true,
          filled: true,
          fillColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            textStyle: const TextStyle(fontFamily: 'Tajawal', fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
      ),
      builder: (context, child) => Directionality(textDirection: TextDirection.rtl, child: child!),
      home: const RootScreen(),
    );
  }
}

/// يحدد الشاشة المناسبة: التفعيل، الإعداد الأول، الدخول، أو البرنامج
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  bool? _hasUsers;

  @override
  void initState() {
    super.initState();
    AppState.I.addListener(_onChange);
    _check();
  }

  @override
  void dispose() {
    AppState.I.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    if (mounted) setState(() {});
  }

  Future<void> _check() async {
    if (AppState.I.startupError != null) return;
    final h = await AppState.I.s.users.hasUsers();
    if (mounted) setState(() => _hasUsers = h);
  }

  @override
  Widget build(BuildContext context) {
    final st = AppState.I;
    if (st.startupError != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.error_outline, size: 64, color: kDanger),
              const SizedBox(height: 12),
              const Text('تعذّر فتح قاعدة البيانات', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SelectableText(st.startupError!, textAlign: TextAlign.center),
            ]),
          ),
        ),
      );
    }
    if (st.licenseStatus == null || _hasUsers == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (!st.licenseStatus!.isUsable) return const ActivationScreen();
    if (_hasUsers == false) return SetupScreen(onDone: _check);
    if (!st.loggedIn) return const LoginScreen();
    return const HomeShell();
  }
}
