import 'dart:io';

import 'package:path/path.dart' as p;

import '../data/database.dart';
import 'audit_service.dart';
import 'settings_service.dart';

class BackupResult {
  final List<String> written;
  final List<String> errors;
  BackupResult(this.written, this.errors);
  bool get ok => written.isNotEmpty;
}

/// النسخ الاحتياطي: نسخة يومية تلقائية في مجلد البرنامج + مجلد خارجي (فلاشة USB أو مجلد Google Drive/OneDrive)
class BackupService {
  final AppDatabase db;
  final File dbFile;
  final Directory localBackupDir;
  final SettingsService settings;
  final AuditService audit;

  BackupService(this.db, this.dbFile, this.localBackupDir, this.settings, this.audit);

  static String _stamp(DateTime d) =>
      '${d.year}${d.month.toString().padLeft(2, '0')}${d.day.toString().padLeft(2, '0')}_'
      '${d.hour.toString().padLeft(2, '0')}${d.minute.toString().padLeft(2, '0')}${d.second.toString().padLeft(2, '0')}';

  DateTime? get lastBackupAt => DateTime.tryParse(settings.get(SettingKeys.lastBackupAt) ?? '');

  bool get isDue {
    if (!settings.getBool(SettingKeys.autoBackup, true)) return false;
    final last = lastBackupAt;
    return last == null || DateTime.now().difference(last).inHours >= 24;
  }

  /// إنشاء نسخة احتياطية (الملف يبقى مشفّراً)
  Future<BackupResult> backup({User? actor, String? extraFolder}) async {
    final name = 'pharmacy_backup_${_stamp(DateTime.now())}.phdb';
    final targets = <Directory>[localBackupDir];
    final ext = extraFolder ?? settings.get(SettingKeys.backupFolder);
    if (ext != null && ext.isNotEmpty) targets.add(Directory(ext));

    final written = <String>[];
    final errors = <String>[];
    // نسخ الملف داخل معاملة لمنع أي كتابة أثناء النسخ
    await db.transaction(() async {
      final tmp = File(p.join(localBackupDir.path, '.tmp_$name'));
      await localBackupDir.create(recursive: true);
      await dbFile.copy(tmp.path);
      for (final dir in targets) {
        try {
          if (!await dir.exists()) {
            if (dir.path == localBackupDir.path) {
              await dir.create(recursive: true);
            } else {
              errors.add('المجلد غير موجود (هل الفلاشة موصولة؟): ${dir.path}');
              continue;
            }
          }
          final out = p.join(dir.path, name);
          await tmp.copy(out);
          written.add(out);
          await _prune(dir);
        } catch (e) {
          errors.add('${dir.path}: $e');
        }
      }
      await tmp.delete();
    });
    if (written.isNotEmpty) {
      await settings.set(SettingKeys.lastBackupAt, DateTime.now().toIso8601String());
      await audit.log(actor, AuditActions.backupCreated, details: {'files': written});
    }
    return BackupResult(written, errors);
  }

  Future<void> _prune(Directory dir) async {
    final keep = settings.getInt(SettingKeys.backupKeep, 30);
    final files = await dir
        .list()
        .where((e) => e is File && p.basename(e.path).startsWith('pharmacy_backup_') && e.path.endsWith('.phdb'))
        .cast<File>()
        .toList();
    files.sort((a, b) => b.path.compareTo(a.path));
    for (final f in files.skip(keep)) {
      try {
        await f.delete();
      } catch (_) {}
    }
  }

  Future<List<File>> localBackups() async {
    if (!await localBackupDir.exists()) return [];
    final files = await localBackupDir
        .list()
        .where((e) => e is File && e.path.endsWith('.phdb'))
        .cast<File>()
        .toList();
    files.sort((a, b) => b.path.compareTo(a.path));
    return files;
  }

  /// تجهيز الاستعادة: يُنسخ الملف بجانب قاعدة البيانات ويُطبَّق عند إعادة تشغيل البرنامج
  Future<void> scheduleRestore(File backup, User actor) async {
    await audit.log(actor, AuditActions.backupRestored, details: backup.path);
    // نسخة أمان من الوضع الحالي قبل الاستعادة
    await this.backup(actor: actor);
    await backup.copy('${dbFile.path}.restore');
  }

  /// يُستدعى عند بدء التشغيل قبل فتح قاعدة البيانات
  static Future<bool> applyPendingRestore(File dbFile) async {
    final pending = File('${dbFile.path}.restore');
    if (!await pending.exists()) return false;
    if (await dbFile.exists()) {
      await dbFile.rename('${dbFile.path}.before_restore_${_stamp(DateTime.now())}');
    }
    await pending.rename(dbFile.path);
    return true;
  }
}
