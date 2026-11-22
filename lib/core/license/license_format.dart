// صيغة ملف الترخيص (Dart خالص بدون Flutter حتى تستخدمها أداة توليد التراخيص أيضاً)
//
// الترخيص = "PHX1." + base64url(JSON) + "." + base64url(توقيع Ed25519)
// التوقيع يتم بالمفتاح الخاص الذي يملكه البائع فقط، والبرنامج يحتوي المفتاح العام فقط.

import 'dart:convert';

import 'package:cryptography/cryptography.dart';

const licensePrefix = 'PHX1';

class LicenseData {
  /// رمز الجهاز
  final String machineId;

  /// اسم الصيدلية
  final String customer;

  /// lifetime = دائم، subscription = اشتراك
  final String type;
  final DateTime? expiresAt;
  final DateTime issuedAt;
  final String serial;

  LicenseData({
    required this.machineId,
    required this.customer,
    required this.type,
    required this.issuedAt,
    required this.serial,
    this.expiresAt,
  });

  Map<String, dynamic> toJson() => {
    'v': 1,
    'mid': machineId,
    'name': customer,
    'type': type,
    'exp': expiresAt == null ? null : _d(expiresAt!),
    'iat': _d(issuedAt),
    'sn': serial,
  };

  static String _d(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  factory LicenseData.fromJson(Map<String, dynamic> j) => LicenseData(
    machineId: j['mid'] as String,
    customer: j['name'] as String? ?? '',
    type: j['type'] as String? ?? 'lifetime',
    expiresAt: j['exp'] == null ? null : DateTime.parse(j['exp'] as String),
    issuedAt: DateTime.parse(j['iat'] as String),
    serial: j['sn'] as String? ?? '',
  );

  bool isExpired(DateTime now) =>
      expiresAt != null && now.isAfter(DateTime(expiresAt!.year, expiresAt!.month, expiresAt!.day, 23, 59, 59));
}

String _b64(List<int> b) => base64Url.encode(b).replaceAll('=', '');
List<int> _unb64(String s) => base64Url.decode(base64Url.normalize(s));

/// توليد ترخيص موقّع (يُستخدم في أداة البائع فقط)
Future<String> signLicense(LicenseData data, List<int> privateKeySeed) async {
  final algo = Ed25519();
  final kp = await algo.newKeyPairFromSeed(privateKeySeed);
  final payload = utf8.encode(jsonEncode(data.toJson()));
  final sig = await algo.sign(payload, keyPair: kp);
  return '$licensePrefix.${_b64(payload)}.${_b64(sig.bytes)}';
}

/// التحقق من الترخيص وإرجاع بياناته إذا كان التوقيع صحيحاً
Future<LicenseData?> verifyLicense(String license, List<int> publicKey) async {
  try {
    final parts = license.trim().replaceAll(RegExp(r'\s'), '').split('.');
    if (parts.length != 3 || parts[0] != licensePrefix) return null;
    final payload = _unb64(parts[1]);
    final sigBytes = _unb64(parts[2]);
    final ok = await Ed25519().verify(
      payload,
      signature: Signature(sigBytes, publicKey: SimplePublicKey(publicKey, type: KeyPairType.ed25519)),
    );
    if (!ok) return null;
    return LicenseData.fromJson(jsonDecode(utf8.decode(payload)) as Map<String, dynamic>);
  } catch (_) {
    return null;
  }
}

/// توليد زوج مفاتيح جديد: يعيد (seed المفتاح الخاص، المفتاح العام)
Future<(List<int>, List<int>)> generateKeyPair() async {
  final algo = Ed25519();
  final kp = await algo.newKeyPair();
  final seed = await kp.extractPrivateKeyBytes();
  final pub = (await kp.extractPublicKey()).bytes;
  return (seed, pub);
}

/// تنسيق رمز الجهاز: XXXX-XXXX-XXXX-XXXX-XXXX
String formatMachineCode(String hex) {
  final h = hex.toUpperCase().replaceAll(RegExp('[^0-9A-F]'), '');
  final s = h.length >= 20 ? h.substring(0, 20) : h.padRight(20, '0');
  return [for (var i = 0; i < 20; i += 4) s.substring(i, i + 4)].join('-');
}

String normalizeMachineCode(String code) => code.toUpperCase().replaceAll(RegExp('[^0-9A-F]'), '');
