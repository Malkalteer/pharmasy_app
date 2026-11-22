import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

import 'license_format.dart';
import 'machine_id.dart';
import 'public_key.dart';

enum LicenseState { valid, missing, invalid, wrongMachine, expired, clockTampered, development }

class LicenseStatus {
  final LicenseState state;
  final LicenseData? data;
  final String machineCode;

  LicenseStatus(this.state, this.machineCode, [this.data]);

  bool get isUsable => state == LicenseState.valid || state == LicenseState.development;

  String get message {
    switch (state) {
      case LicenseState.valid:
        return 'البرنامج مفعّل';
      case LicenseState.development:
        return 'نسخة تطوير (غير مخصصة للبيع)';
      case LicenseState.missing:
        return 'البرنامج غير مفعّل. أرسل رمز الجهاز إلى البائع للحصول على كود التفعيل';
      case LicenseState.invalid:
        return 'كود التفعيل غير صحيح';
      case LicenseState.wrongMachine:
        return 'كود التفعيل هذا مخصص لجهاز آخر';
      case LicenseState.expired:
        return 'انتهت مدة الاشتراك. يرجى التواصل مع البائع للتجديد';
      case LicenseState.clockTampered:
        return 'تاريخ الجهاز غير صحيح. يرجى ضبط التاريخ والوقت';
    }
  }
}

class LicenseService {
  final Directory dataDir;
  LicenseService(this.dataDir);

  File get _file => File(p.join(dataDir.path, 'license.key'));

  static bool get publicKeyConfigured => licensePublicKey.any((b) => b != 0);

  Future<String?> storedLicense() async {
    if (!await _file.exists()) return null;
    return (await _file.readAsString()).trim();
  }

  Future<LicenseStatus> check({DateTime? lastSeen}) async {
    final code = await MachineId.get();
    final lic = await storedLicense();
    if (lic == null || lic.isEmpty) {
      // في وضع التطوير فقط: السماح بالعمل بدون ترخيص
      if (kDebugMode) return LicenseStatus(LicenseState.development, code);
      return LicenseStatus(LicenseState.missing, code);
    }
    return evaluate(lic, code, lastSeen: lastSeen);
  }

  Future<LicenseStatus> evaluate(String lic, String code, {DateTime? lastSeen}) async {
    if (!publicKeyConfigured) return LicenseStatus(LicenseState.invalid, code);
    final data = await verifyLicense(lic, licensePublicKey);
    if (data == null) return LicenseStatus(LicenseState.invalid, code);
    if (normalizeMachineCode(data.machineId) != normalizeMachineCode(code)) {
      return LicenseStatus(LicenseState.wrongMachine, code, data);
    }
    final now = DateTime.now();
    // الحماية من إرجاع تاريخ الجهاز للخلف لتمديد الاشتراك
    if (lastSeen != null && now.isBefore(lastSeen.subtract(const Duration(days: 2)))) {
      return LicenseStatus(LicenseState.clockTampered, code, data);
    }
    if (data.isExpired(now)) return LicenseStatus(LicenseState.expired, code, data);
    return LicenseStatus(LicenseState.valid, code, data);
  }

  /// تفعيل البرنامج بكود جديد
  Future<LicenseStatus> activate(String lic) async {
    final code = await MachineId.get();
    final status = await evaluate(lic, code);
    if (status.state == LicenseState.valid) {
      await dataDir.create(recursive: true);
      await _file.writeAsString(lic.trim());
    }
    return status;
  }
}
