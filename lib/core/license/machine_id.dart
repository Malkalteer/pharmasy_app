import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

import 'license_format.dart';

/// بصمة الجهاز: تعتمد على معرّف اللوحة الأم والمعالج (لا تتغير بإعادة تثبيت Windows)
class MachineId {
  static String? _cached;

  static Future<String> get() async {
    if (_cached != null) return _cached!;
    final raw = await _collect();
    final digest = sha256.convert(utf8.encode('pharmacy-app|$raw')).toString();
    _cached = formatMachineCode(digest);
    return _cached!;
  }

  static Future<String> _collect() async {
    final parts = <String>[];
    try {
      if (Platform.isWindows) {
        final r = await Process.run('powershell', [
          '-NoProfile',
          '-NonInteractive',
          '-Command',
          r'$ErrorActionPreference="SilentlyContinue";'
              r'(Get-CimInstance Win32_ComputerSystemProduct).UUID;'
              r'(Get-CimInstance Win32_BaseBoard).SerialNumber;'
              r'(Get-CimInstance Win32_Processor | Select-Object -First 1).ProcessorId',
        ]);
        for (final l in (r.stdout as String).split(RegExp(r'[\r\n]+'))) {
          final v = l.trim();
          if (_isUseful(v)) parts.add(v);
        }
        if (parts.isEmpty) {
          final g = await Process.run('reg', ['query', r'HKLM\SOFTWARE\Microsoft\Cryptography', '/v', 'MachineGuid']);
          final m = RegExp(r'MachineGuid\s+REG_SZ\s+(\S+)').firstMatch(g.stdout as String);
          if (m != null) parts.add(m.group(1)!);
        }
      } else if (Platform.isLinux) {
        for (final f in ['/etc/machine-id', '/var/lib/dbus/machine-id']) {
          final file = File(f);
          if (await file.exists()) {
            parts.add((await file.readAsString()).trim());
            break;
          }
        }
      } else if (Platform.isMacOS) {
        final r = await Process.run('ioreg', ['-rd1', '-c', 'IOPlatformExpertDevice']);
        final m = RegExp(r'"IOPlatformUUID" = "([^"]+)"').firstMatch(r.stdout as String);
        if (m != null) parts.add(m.group(1)!);
      }
    } catch (_) {}
    if (parts.isEmpty) parts.add(Platform.localHostname);
    return parts.join('|');
  }

  static bool _isUseful(String v) {
    if (v.isEmpty) return false;
    final u = v.toUpperCase();
    const junk = [
      'TO BE FILLED BY O.E.M.',
      'DEFAULT STRING',
      'NONE',
      'N/A',
      '00000000-0000-0000-0000-000000000000',
      'FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF',
      '0',
    ];
    return !junk.contains(u);
  }
}
