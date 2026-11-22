// أداة البائع لتوليد تراخيص البرنامج.
//
// الاستخدام (من مجلد المشروع):
//
//   1) مرة واحدة فقط: توليد زوج المفاتيح
//        dart run tool/license_tool.dart keygen
//      - ينشئ المفتاح الخاص في keys/license_private.key  ← احتفظ به سراً ولا تشاركه أبداً
//      - يحدّث lib/core/license/public_key.dart بالمفتاح العام (ثم أعد بناء البرنامج)
//
//   2) لكل صيدلية: الصيدلي يرسل لك "رمز الجهاز" الظاهر في شاشة التفعيل
//        dart run tool/license_tool.dart sign --machine ABCD-1234-... --name "صيدلية الشفاء"
//      اشتراك محدد المدة:
//        dart run tool/license_tool.dart sign --machine ... --name "..." --expires 2027-12-31
//      يطبع كود التفعيل لترسله للصيدلية، ويسجله في keys/issued_licenses.csv
//
//   3) فحص كود تفعيل:
//        dart run tool/license_tool.dart verify <الكود>

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:pharmacy_app/core/license/license_format.dart';

const _defaultKeyPath = 'keys/license_private.key';
const _publicKeyFile = 'lib/core/license/public_key.dart';

Future<void> main(List<String> args) async {
  if (args.isEmpty) return _usage();
  final opts = _parse(args.skip(1).toList());
  switch (args.first) {
    case 'keygen':
      await _keygen(opts);
    case 'sign':
      await _sign(opts);
    case 'verify':
      await _verify(args.length > 1 ? args[1] : '');
    default:
      _usage();
  }
}

void _usage() {
  stdout.writeln('''
أداة تراخيص برنامج الصيدلية
  keygen [--out keys/license_private.key] [--force]
  sign --machine <رمز الجهاز> --name <اسم الصيدلية> [--expires YYYY-MM-DD] [--key keys/license_private.key]
  verify <كود التفعيل>
''');
}

Map<String, String> _parse(List<String> a) {
  final m = <String, String>{};
  for (var i = 0; i < a.length; i++) {
    if (a[i].startsWith('--')) {
      final k = a[i].substring(2);
      if (i + 1 < a.length && !a[i + 1].startsWith('--')) {
        m[k] = a[++i];
      } else {
        m[k] = 'true';
      }
    }
  }
  return m;
}

Future<void> _keygen(Map<String, String> o) async {
  final out = File(o['out'] ?? _defaultKeyPath);
  if (await out.exists() && o['force'] != 'true') {
    stderr.writeln('المفتاح الخاص موجود مسبقاً: ${out.path}');
    stderr.writeln('توليد مفتاح جديد سيُبطل جميع التراخيص السابقة! استخدم --force إذا كنت متأكداً.');
    exitCode = 1;
    return;
  }
  final (seed, pub) = await generateKeyPair();
  await out.parent.create(recursive: true);
  await out.writeAsString(base64Encode(seed));
  final rows = <String>[];
  for (var i = 0; i < pub.length; i += 16) {
    rows.add('  ${pub.sublist(i, min(i + 16, pub.length)).join(', ')}, //');
  }
  await File(_publicKeyFile)
      .writeAsString('''// المفتاح العام للتحقق من التراخيص (تم توليده بواسطة tool/license_tool.dart keygen)
// المفتاح الخاص المقابل محفوظ لدى البائع فقط ولا يوجد في هذا المستودع.

const List<int> licensePublicKey = [
${rows.join('\n')}
];
''');
  stdout.writeln('✔ تم إنشاء المفتاح الخاص: ${out.path}');
  stdout.writeln('  ⚠ احتفظ بنسخة منه في مكان آمن (فلاشة مثلاً). إذا ضاع لن تستطيع إصدار تراخيص جديدة.');
  stdout.writeln('  ⚠ لا ترفعه إلى GitHub ولا ترسله لأحد.');
  stdout.writeln('✔ تم تحديث $_publicKeyFile — أعد بناء البرنامج الآن.');
}

Future<void> _sign(Map<String, String> o) async {
  final machine = o['machine'];
  final name = o['name'];
  if (machine == null || name == null) {
    stderr.writeln('يجب تحديد --machine و --name');
    exitCode = 1;
    return;
  }
  final keyFile = File(o['key'] ?? _defaultKeyPath);
  if (!await keyFile.exists()) {
    stderr.writeln('المفتاح الخاص غير موجود: ${keyFile.path}. شغّل keygen أولاً.');
    exitCode = 1;
    return;
  }
  final seed = base64Decode((await keyFile.readAsString()).trim());
  final expires = o['expires'] == null ? null : DateTime.parse(o['expires']!);
  final serial =
      '${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}${Random.secure().nextInt(1 << 20).toRadixString(36)}'
          .toUpperCase();
  final data = LicenseData(
    machineId: formatMachineCode(normalizeMachineCode(machine)),
    customer: name,
    type: expires == null ? 'lifetime' : 'subscription',
    expiresAt: expires,
    issuedAt: DateTime.now(),
    serial: serial,
  );
  final lic = await signLicense(data, seed);
  final log = File('keys/issued_licenses.csv');
  final isNew = !await log.exists();
  await log.writeAsString(
    '${isNew ? 'date,serial,machine,name,type,expires\n' : ''}'
    '${DateTime.now().toIso8601String()},$serial,${data.machineId},"$name",${data.type},${o['expires'] ?? ''}\n',
    mode: FileMode.append,
  );
  stdout.writeln('كود التفعيل لـ "$name" (${data.machineId}):\n');
  stdout.writeln(lic);
  stdout.writeln('\n(تم تسجيله في ${log.path})');
}

Future<void> _verify(String lic) async {
  final pubSrc = await File(_publicKeyFile).readAsString();
  final body = pubSrc.substring(pubSrc.indexOf('[') + 1, pubSrc.lastIndexOf(']'));
  final pub = RegExp(r'\d+').allMatches(body).map((m) => int.parse(m.group(0)!)).toList();
  final d = await verifyLicense(lic, pub);
  if (d == null) {
    stdout.writeln('✘ كود غير صالح (أو موقّع بمفتاح مختلف)');
    exitCode = 1;
    return;
  }
  stdout.writeln(const JsonEncoder.withIndent('  ').convert(d.toJson()));
}
