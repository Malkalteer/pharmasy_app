import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'dart:convert';

import '../data/database.dart';
import '../services/audit_service.dart';
import '../services/backup_service.dart';
import '../services/inventory_service.dart';
import '../services/party_service.dart';
import '../services/purchase_service.dart';
import '../services/report_service.dart';
import '../services/returns_service.dart';
import '../services/sales_service.dart';
import '../services/settings_service.dart';
import '../services/shift_service.dart';
import '../services/user_service.dart';
import 'license/license_service.dart';

/// جميع الخدمات المرتبطة بقاعدة البيانات
class Services {
  final AppDatabase db;
  late final SettingsService settings = SettingsService(db);
  late final AuditService audit = AuditService(db);
  late final UserService users = UserService(db, audit);
  late final InventoryService inventory = InventoryService(db, audit);
  late final ShiftService shifts = ShiftService(db, audit);
  late final CustomerService customers = CustomerService(db, audit, shifts);
  late final SupplierService suppliers = SupplierService(db, audit, shifts);
  late final SalesService sales = SalesService(db, audit, inventory, shifts, customers);
  late final PurchaseService purchases = PurchaseService(db, audit, inventory, suppliers, shifts);
  late final ReturnsService returns = ReturnsService(db, audit, inventory, shifts, customers, suppliers);
  late final ReportService reports = ReportService(db);

  Services(this.db);
}

/// مفتاح تشفير قاعدة البيانات (مشتق من ثوابت داخل البرنامج المُشوَّش)
String _dbKey() {
  const parts = ['ph4rm', 'Ac7-', 'S3cr', '3t-', 'Db#', '2026'];
  final seed = parts.reversed.join('~');
  return sha256.convert(utf8.encode('pharmacy::$seed::v1')).toString();
}

class AppState extends ChangeNotifier {
  static final AppState I = AppState._();
  AppState._();

  late Directory dataDir;
  late File dbFile;
  late Services s;
  late BackupService backup;
  late LicenseService license;
  LicenseStatus? licenseStatus;

  User? user;
  Shift? shift;
  Timer? _timer;
  String? startupError;
  bool restoredOnStartup = false;

  bool get loggedIn => user != null;
  double get rate => s.settings.exchangeRate;

  Future<void> init({Directory? overrideDir}) async {
    try {
      final base = overrideDir ?? await getApplicationSupportDirectory();
      dataDir = Directory(p.join(base.path, 'data'));
      await dataDir.create(recursive: true);
      dbFile = File(p.join(dataDir.path, 'pharmacy.phdb'));
      restoredOnStartup = await BackupService.applyPendingRestore(dbFile);
      final db = AppDatabase.open(dbFile, _dbKey());
      s = Services(db);
      await s.settings.load();
      backup = BackupService(db, dbFile, Directory(p.join(base.path, 'backups')), s.settings, s.audit);
      license = LicenseService(dataDir);
      await refreshLicense();
      _timer = Timer.periodic(const Duration(minutes: 30), (_) => _periodic());
      unawaited(_periodic());
    } catch (e, st) {
      startupError = '$e';
      debugPrint('$e\n$st');
    }
  }

  Future<void> refreshLicense() async {
    final lastSeen = DateTime.tryParse(s.settings.get(SettingKeys.lastSeenAt) ?? '');
    licenseStatus = await license.check(lastSeen: lastSeen);
    if (licenseStatus!.isUsable) {
      final now = DateTime.now();
      if (lastSeen == null || now.isAfter(lastSeen)) {
        await s.settings.set(SettingKeys.lastSeenAt, now.toIso8601String());
      }
    }
    notifyListeners();
  }

  Future<void> _periodic() async {
    try {
      if (backup.isDue) await backup.backup(actor: user);
      await refreshLicense();
    } catch (e) {
      debugPrint('periodic: $e');
    }
  }

  Future<void> login(User u) async {
    user = u;
    shift = await s.shifts.openShiftOf(u.id);
    notifyListeners();
  }

  Future<void> reloadUser() async {
    if (user == null) return;
    user = await s.users.byId(user!.id);
    notifyListeners();
  }

  Future<void> setShift(Shift? sh) async {
    shift = sh;
    notifyListeners();
  }

  Future<void> logout() async {
    if (user != null) await s.audit.log(user, AuditActions.logout);
    user = null;
    shift = null;
    notifyListeners();
  }

  void refresh() => notifyListeners();

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
