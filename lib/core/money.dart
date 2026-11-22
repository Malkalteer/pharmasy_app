import 'package:intl/intl.dart';

/// طريقة التقريب عند تحويل السعر من الدولار إلى الليرة
enum RoundingMode { nearest, up, down }

class RoundingConfig {
  /// خطوة التقريب بالليرة (0 = بدون تقريب، 1، 5، 10، 25، 50، 100 ...)
  final double step;
  final RoundingMode mode;

  const RoundingConfig({this.step = 1, this.mode = RoundingMode.nearest});

  double apply(double value) {
    if (step <= 0) return roundTo(value, 2);
    // تجنب أخطاء الفاصلة العائمة (مثلاً 300.0000001)
    final q = roundTo(value / step, 6);
    final double r;
    switch (mode) {
      case RoundingMode.nearest:
        r = q.roundToDouble();
      case RoundingMode.up:
        r = q.ceilToDouble();
      case RoundingMode.down:
        r = q.floorToDouble();
    }
    return roundTo(r * step, 2);
  }

  static RoundingMode parseMode(String? s) => RoundingMode.values
      .firstWhere((m) => m.name == s, orElse: () => RoundingMode.nearest);
}

double roundTo(double v, int decimals) {
  var f = 1.0;
  for (var i = 0; i < decimals; i++) {
    f *= 10;
  }
  return (v * f).roundToDouble() / f;
}

/// تحويل سعر بالدولار إلى الليرة مع التقريب
double usdToSyp(double usd, double rate, RoundingConfig rounding) =>
    rounding.apply(usd * rate);

double sypToUsd(double syp, double rate) =>
    rate <= 0 ? 0 : roundTo(syp / rate, 6);

final _sypFmt = NumberFormat('#,##0.##', 'en_US');
final _usdFmt = NumberFormat('#,##0.00##', 'en_US');
final _qtyFmt = NumberFormat('#,##0.##', 'en_US');

String fmtSyp(num v) => '${_sypFmt.format(v)} ل.س';
String fmtSypPlain(num v) => _sypFmt.format(v);
String fmtUsd(num v) => '\$${_usdFmt.format(v)}';
String fmtUsdPlain(num v) => _usdFmt.format(v);
String fmtQty(num v) => _qtyFmt.format(v);

final _dateFmt = DateFormat('yyyy/MM/dd', 'en_US');
final _dateTimeFmt = DateFormat('yyyy/MM/dd HH:mm', 'en_US');
final _monthFmt = DateFormat('yyyy/MM', 'en_US');

String fmtDate(DateTime? d) => d == null ? '-' : _dateFmt.format(d);
String fmtDateTime(DateTime? d) => d == null ? '-' : _dateTimeFmt.format(d);
String fmtMonth(DateTime d) => _monthFmt.format(d);

/// تحويل نص إلى رقم مع دعم الأرقام العربية والفواصل
double? parseNum(String? s) {
  if (s == null) return null;
  var t = s.trim();
  if (t.isEmpty) return null;
  t = normalizeDigits(t);
  t = t.replaceAll('٫', '.').replaceAll(',', '').replaceAll('،', '');
  return double.tryParse(t);
}

int? parseInt(String? s) => parseNum(s)?.round();

/// تحويل الأرقام العربية/الفارسية إلى أرقام إنجليزية
String normalizeDigits(String s) {
  const ar = '٠١٢٣٤٥٦٧٨٩';
  const fa = '۰۱۲۳۴۵۶۷۸۹';
  var t = s;
  for (var i = 0; i < 10; i++) {
    t = t.replaceAll(ar[i], '$i').replaceAll(fa[i], '$i');
  }
  return t;
}

/// تاريخ بصيغة yyyy-mm-dd أو yyyy/mm/dd أو mm/yyyy (لتاريخ الانتهاء)
DateTime? parseDate(String? s) {
  if (s == null || s.trim().isEmpty) return null;
  final t = normalizeDigits(s.trim()).replaceAll('-', '/').replaceAll('.', '/');
  final parts = t.split('/').where((p) => p.isNotEmpty).toList();
  try {
    if (parts.length == 3) {
      final a = int.parse(parts[0]), b = int.parse(parts[1]), c = int.parse(parts[2]);
      if (a > 31) return DateTime(a, b, c); // yyyy/mm/dd
      return DateTime(c, b, a); // dd/mm/yyyy
    }
    if (parts.length == 2) {
      var m = int.parse(parts[0]), y = int.parse(parts[1]);
      if (m > 12) {
        final tmp = m;
        m = y;
        y = tmp;
      }
      if (y < 100) y += 2000;
      // نهاية الشهر
      return DateTime(y, m + 1, 0);
    }
  } catch (_) {}
  return null;
}
