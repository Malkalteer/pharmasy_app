import 'package:drift/drift.dart';

import '../core/money.dart';
import '../data/database.dart';

/// مفاتيح الإعدادات
class SettingKeys {
  static const pharmacyName = 'pharmacy_name';
  static const pharmacyAddress = 'pharmacy_address';
  static const pharmacyPhone = 'pharmacy_phone';
  static const receiptFooter = 'receipt_footer';
  static const exchangeRate = 'exchange_rate';
  static const roundingStep = 'rounding_step';
  static const roundingMode = 'rounding_mode';

  /// roll80, roll58, a4, a5
  static const paperSize = 'paper_size';
  static const printerName = 'printer_name';
  static const autoPrint = 'auto_print';
  static const expiryAlertMonths = 'expiry_alert_months';
  static const backupFolder = 'backup_folder';
  static const autoBackup = 'auto_backup';
  static const lastBackupAt = 'last_backup_at';
  static const backupKeep = 'backup_keep';
  static const lastSeenAt = 'last_seen_at';
  static const license = 'license';
}

class SettingsService {
  final AppDatabase db;
  final Map<String, String> _cache = {};

  SettingsService(this.db);

  Future<void> load() async {
    final rows = await db.select(db.settings).get();
    _cache
      ..clear()
      ..addEntries(rows.map((r) => MapEntry(r.key, r.value)));
  }

  String? get(String key) => _cache[key];
  String getOr(String key, String def) => _cache[key] ?? def;

  double getDouble(String key, double def) =>
      double.tryParse(_cache[key] ?? '') ?? def;
  int getInt(String key, int def) => int.tryParse(_cache[key] ?? '') ?? def;
  bool getBool(String key, bool def) {
    final v = _cache[key];
    if (v == null) return def;
    return v == '1' || v == 'true';
  }

  Future<void> set(String key, String value) async {
    await db
        .into(db.settings)
        .insertOnConflictUpdate(SettingsCompanion.insert(key: key, value: value));
    _cache[key] = value;
  }

  Future<void> setAll(Map<String, String> values) async {
    await db.transaction(() async {
      for (final e in values.entries) {
        await set(e.key, e.value);
      }
    });
  }

  // ---- اختصارات ----

  String get pharmacyName => getOr(SettingKeys.pharmacyName, 'الصيدلية');
  String get pharmacyAddress => getOr(SettingKeys.pharmacyAddress, '');
  String get pharmacyPhone => getOr(SettingKeys.pharmacyPhone, '');
  String get receiptFooter =>
      getOr(SettingKeys.receiptFooter, 'شكراً لزيارتكم - نتمنى لكم الشفاء العاجل');

  double get exchangeRate => getDouble(SettingKeys.exchangeRate, 0);

  RoundingConfig get rounding => RoundingConfig(
        step: getDouble(SettingKeys.roundingStep, 1),
        mode: RoundingConfig.parseMode(get(SettingKeys.roundingMode)),
      );

  String get paperSize => getOr(SettingKeys.paperSize, 'roll80');
  String? get printerName {
    final v = get(SettingKeys.printerName);
    return (v == null || v.isEmpty) ? null : v;
  }

  bool get autoPrint => getBool(SettingKeys.autoPrint, true);
  int get expiryAlertMonths => getInt(SettingKeys.expiryAlertMonths, 3);

  /// السعر بالليرة لسعر بالدولار حسب سعر الصرف والتقريب الحاليين
  double toSyp(double usd) => usdToSyp(usd, exchangeRate, rounding);

  /// تحديث سعر الصرف مع حفظ السجل
  Future<void> setExchangeRate(double rate, int? userId) async {
    await db.transaction(() async {
      await set(SettingKeys.exchangeRate, rate.toString());
      await db.into(db.exchangeRates).insert(
          ExchangeRatesCompanion.insert(rate: rate, userId: Value(userId)));
    });
  }

  Future<List<ExchangeRate>> rateHistory({int limit = 50}) =>
      (db.select(db.exchangeRates)
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
            ..limit(limit))
          .get();
}
