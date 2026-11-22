import 'dart:io';

import 'package:drift/drift.dart' as drift show driftRuntimeOptions;
import 'package:flutter_test/flutter_test.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/dev/demo_seed.dart';
import 'package:pharmacy_app/printing/printer.dart';
import 'package:pharmacy_app/services/settings_service.dart';

/// يولّد ملفات PDF للفاتورة والتقارير للتأكد من أنها تُبنى بدون أخطاء
/// (ضع PRINT_OUT=مسار_مجلد لحفظها ومعاينتها)
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  drift.driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  test('receipt and report PDFs build for all paper sizes', () async {
    final dir = await Directory.systemTemp.createTemp('pharm_print');
    await AppState.I.init(overrideDir: dir);
    expect(AppState.I.startupError, isNull);
    final s = AppState.I.s;
    await seedDemo(s);
    await s.settings.load();
    final sales = await s.sales.list();
    final d = (await s.sales.details(sales.last.id))!;
    final out = Platform.environment['PRINT_OUT'];
    for (final paper in ['roll80', 'roll58', 'a5', 'a4']) {
      await s.settings.set(SettingKeys.paperSize, paper);
      final bytes = await AppPrinter.receiptPdf(d);
      expect(bytes.length, greaterThan(1000));
      if (out != null) await File('$out/receipt_$paper.pdf').writeAsBytes(bytes);
    }
    final table = await AppPrinter.tablePdf(
      title: 'قائمة النواقص',
      headers: ['#', 'الدواء', 'المطلوب'],
      rows: [
        ['1', 'بنادول 500', '5 علبة'],
        ['2', 'فنتولين بخاخ', '2 علبة'],
      ],
    );
    if (out != null) await File('$out/table.pdf').writeAsBytes(table);
    await s.db.close();
  });
}
