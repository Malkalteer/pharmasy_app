import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../core/app_state.dart';
import '../core/money.dart';
import '../services/sales_service.dart';
import '../services/shift_service.dart';

/// معالجة خلل في مكتبة PDF: المسافة بعد حرف الراء/الزاي في آخر الكلمة تختفي، فنضاعفها
String _fx(String s) => s.replaceAllMapped(RegExp('([رزژ]) '), (m) => '${m[1]}  ');

pw.Widget _T(String text, {pw.TextStyle? style, pw.TextAlign? textAlign, pw.TextDirection? textDirection}) =>
    pw.Text(_fx(text), style: style, textAlign: textAlign, textDirection: textDirection);

/// طباعة الفواتير والتقارير (حرارية 80/58 مم أو A4/A5) عبر طابعات Windows
class AppPrinter {
  static pw.Font? _regular;
  static pw.Font? _bold;

  static Future<void> _loadFonts() async {
    _regular ??= pw.Font.ttf(await rootBundle.load('assets/fonts/Tajawal-Regular.ttf'));
    _bold ??= pw.Font.ttf(await rootBundle.load('assets/fonts/Tajawal-Bold.ttf'));
  }

  static PdfPageFormat formatFor(String paper) {
    switch (paper) {
      case 'roll58':
        return PdfPageFormat.roll57.copyWith(marginLeft: 6, marginRight: 6, marginTop: 8, marginBottom: 8);
      case 'a4':
        return PdfPageFormat.a4.copyWith(marginLeft: 36, marginRight: 36, marginTop: 36, marginBottom: 36);
      case 'a5':
        return PdfPageFormat.a5.copyWith(marginLeft: 24, marginRight: 24, marginTop: 24, marginBottom: 24);
      default:
        return PdfPageFormat.roll80.copyWith(marginLeft: 8, marginRight: 8, marginTop: 10, marginBottom: 10);
    }
  }

  static bool _isRoll(String paper) => paper.startsWith('roll');

  static Future<pw.ThemeData> _theme() async {
    await _loadFonts();
    return pw.ThemeData.withFont(base: _regular!, bold: _bold!);
  }

  /// إرسال ملف PDF للطابعة المحددة في الإعدادات، أو إظهار نافذة الطباعة
  static Future<void> printPdf(Uint8List bytes, {String name = 'document', PdfPageFormat? format}) async {
    final st = AppState.I.s.settings;
    final printerName = st.printerName;
    if (printerName != null) {
      try {
        final printers = await Printing.listPrinters();
        final p = printers.where((x) => x.name == printerName).firstOrNull;
        if (p != null) {
          final ok = await Printing.directPrintPdf(
            printer: p,
            name: name,
            format: format ?? formatFor(st.paperSize),
            onLayout: (_) async => bytes,
          );
          if (ok) return;
        }
      } catch (_) {}
    }
    await Printing.layoutPdf(name: name, format: format ?? formatFor(st.paperSize), onLayout: (_) async => bytes);
  }

  static Future<List<Printer>> printers() async {
    try {
      return await Printing.listPrinters();
    } catch (_) {
      return [];
    }
  }

  // ------------------------------------------------------------------
  // فاتورة البيع
  // ------------------------------------------------------------------

  static Future<Uint8List> receiptPdf(SaleDetails d, {bool copy = false}) async {
    final st = AppState.I.s.settings;
    final paper = st.paperSize;
    final roll = _isRoll(paper);
    final small = paper == 'roll58';
    final fs = small ? 7.0 : (roll ? 8.0 : 10.0);
    final theme = await _theme();
    final sale = d.sale;
    final doc = pw.Document(theme: theme);

    pw.Widget kv(String k, String v, {bool bold = false, double? size}) => pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 1),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _T(k, style: pw.TextStyle(fontSize: size ?? fs, fontWeight: bold ? pw.FontWeight.bold : null)),
              _T(v, style: pw.TextStyle(fontSize: size ?? fs, fontWeight: bold ? pw.FontWeight.bold : null)),
            ],
          ),
        );

    final header = <pw.Widget>[
      pw.Center(
        child: _T(st.pharmacyName,
            style: pw.TextStyle(fontSize: fs + 5, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center),
      ),
      if (st.pharmacyAddress.isNotEmpty)
        pw.Center(child: _T(st.pharmacyAddress, style: pw.TextStyle(fontSize: fs), textAlign: pw.TextAlign.center)),
      if (st.pharmacyPhone.isNotEmpty)
        pw.Center(
          child: pw.Row(mainAxisSize: pw.MainAxisSize.min, children: [
            _T('هاتف: ', style: pw.TextStyle(fontSize: fs)),
            _T(st.pharmacyPhone, style: pw.TextStyle(fontSize: fs), textDirection: pw.TextDirection.ltr),
          ]),
        ),
      pw.SizedBox(height: 4),
      if (sale.status == 'voided')
        pw.Center(
            child: _T('*** فاتورة ملغاة ***',
                style: pw.TextStyle(fontSize: fs + 2, fontWeight: pw.FontWeight.bold))),
      if (copy) pw.Center(child: _T('(نسخة)', style: pw.TextStyle(fontSize: fs))),
      kv('رقم الفاتورة', '${sale.id}', bold: true),
      kv('التاريخ', fmtDateTime(sale.createdAt)),
      kv('الصيدلي', d.user?.fullName ?? '-'),
      if (d.customer != null) kv('الزبون', d.customer!.name),
      pw.Divider(thickness: 0.6),
    ];

    final tableHeaderStyle = pw.TextStyle(fontSize: fs, fontWeight: pw.FontWeight.bold);
    final cellStyle = pw.TextStyle(fontSize: fs);
    final itemsTable = pw.Table(
      columnWidths: roll
          ? {
              0: const pw.FlexColumnWidth(4),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(2.4),
            }
          : {
              0: const pw.FlexColumnWidth(5),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(2.4),
            },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(width: 0.5))),
          children: [
            _T('الصنف', style: tableHeaderStyle),
            _T('الكمية', style: tableHeaderStyle, textAlign: pw.TextAlign.center),
            if (!roll) _T('السعر', style: tableHeaderStyle, textAlign: pw.TextAlign.center),
            _T('المجموع', style: tableHeaderStyle, textAlign: pw.TextAlign.left),
          ],
        ),
        for (final it in d.items)
          pw.TableRow(children: [
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 1.5),
              child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                _T(it.medicineName, style: cellStyle),
                if (roll) _T('${fmtSypPlain(it.unitPriceSyp)} × ${it.quantity}', style: pw.TextStyle(fontSize: fs - 1)),
              ]),
            ),
            _T('${it.quantity} ${it.unitLabel}', style: cellStyle, textAlign: pw.TextAlign.center),
            if (!roll) _T(fmtSypPlain(it.unitPriceSyp), style: cellStyle, textAlign: pw.TextAlign.center),
            _T(fmtSypPlain(it.totalSyp), style: cellStyle, textAlign: pw.TextAlign.left),
          ]),
      ],
    );

    final totals = <pw.Widget>[
      pw.Divider(thickness: 0.6),
      if (sale.discountSyp > 0) ...[
        kv('المجموع', fmtSyp(sale.subtotalSyp)),
        kv('الخصم', fmtSyp(sale.discountSyp)),
      ],
      kv('الإجمالي', fmtSyp(sale.totalSyp), bold: true, size: fs + 3),
      kv('بالدولار', fmtUsd(roundTo(sale.totalUsd, 2))),
      kv('سعر الصرف', '1\$ = ${fmtSypPlain(sale.rate)} ل.س', size: fs - 1),
      pw.SizedBox(height: 3),
      if (sale.paidSyp > 0) kv('المدفوع ليرة', fmtSyp(sale.paidSyp)),
      if (sale.paidUsd > 0) kv('المدفوع دولار', fmtUsd(sale.paidUsd)),
      if (sale.changeSyp > 0) kv('الباقي للزبون', fmtSyp(sale.changeSyp), bold: true),
      if (sale.debtSyp > 0) kv('دين على الزبون', fmtSyp(sale.debtSyp), bold: true),
      pw.Divider(thickness: 0.6),
      pw.Center(child: _T(st.receiptFooter, style: pw.TextStyle(fontSize: fs), textAlign: pw.TextAlign.center)),
    ];

    final content = [...header, itemsTable, ...totals];

    if (roll) {
      final fmt = formatFor(paper);
      doc.addPage(pw.Page(
        pageFormat: PdfPageFormat(fmt.width, double.infinity,
            marginLeft: fmt.marginLeft, marginRight: fmt.marginRight, marginTop: fmt.marginTop, marginBottom: fmt.marginBottom),
        textDirection: pw.TextDirection.rtl,
        build: (_) => pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.stretch, children: content),
      ));
    } else {
      doc.addPage(pw.MultiPage(
        pageFormat: formatFor(paper),
        textDirection: pw.TextDirection.rtl,
        build: (_) => content,
      ));
    }
    return doc.save();
  }

  static Future<void> printReceipt(SaleDetails d, {bool copy = false}) async {
    final bytes = await receiptPdf(d, copy: copy);
    final paper = AppState.I.s.settings.paperSize;
    final fmt = formatFor(paper);
    await printPdf(bytes,
        name: 'فاتورة ${d.sale.id}',
        format: _isRoll(paper) ? PdfPageFormat(fmt.width, double.infinity, marginAll: 0) : fmt);
  }

  // ------------------------------------------------------------------
  // تقرير جدول عام (نواقص، مخزون، تقارير...) على ورق A4
  // ------------------------------------------------------------------

  static Future<Uint8List> tablePdf({
    required String title,
    String? subtitle,
    required List<String> headers,
    required List<List<String>> rows,
    List<(String, String)> summary = const [],
    bool landscape = false,
  }) async {
    final st = AppState.I.s.settings;
    final theme = await _theme();
    final doc = pw.Document(theme: theme);
    final fmt = landscape ? PdfPageFormat.a4.landscape : PdfPageFormat.a4;
    doc.addPage(pw.MultiPage(
      pageFormat: fmt.copyWith(marginLeft: 28, marginRight: 28, marginTop: 28, marginBottom: 28),
      textDirection: pw.TextDirection.rtl,
      header: (ctx) => pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.stretch, children: [
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          _T(st.pharmacyName, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          _T(fmtDateTime(DateTime.now()), style: const pw.TextStyle(fontSize: 9)),
        ]),
        pw.SizedBox(height: 4),
        _T(title, style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
        if (subtitle != null) _T(subtitle, style: const pw.TextStyle(fontSize: 9)),
        pw.SizedBox(height: 8),
      ]),
      footer: (ctx) => pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: _T('صفحة ${ctx.pageNumber} من ${ctx.pagesCount}', style: const pw.TextStyle(fontSize: 8)),
      ),
      build: (ctx) => [
        pw.TableHelper.fromTextArray(
          headers: headers.map(_fx).toList(),
          data: [for (final r in rows) r.map(_fx).toList()],
          headerStyle: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
          cellStyle: const pw.TextStyle(fontSize: 9),
          headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
          cellAlignment: pw.Alignment.centerRight,
          headerAlignment: pw.Alignment.centerRight,
          border: pw.TableBorder.all(width: 0.4, color: PdfColors.grey600),
        ),
        if (summary.isNotEmpty) pw.SizedBox(height: 10),
        for (final (k, v) in summary)
          pw.Row(children: [
            _T('$k: ', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
            _T(v, style: const pw.TextStyle(fontSize: 10)),
          ]),
      ],
    ));
    return doc.save();
  }

  static Future<void> printTable({
    required String title,
    String? subtitle,
    required List<String> headers,
    required List<List<String>> rows,
    List<(String, String)> summary = const [],
    bool landscape = false,
  }) async {
    final bytes = await tablePdf(
        title: title, subtitle: subtitle, headers: headers, rows: rows, summary: summary, landscape: landscape);
    await Printing.layoutPdf(name: title, format: PdfPageFormat.a4, onLayout: (_) async => bytes);
  }

  /// حفظ PDF كملف (مثلاً لإرسال قائمة النواقص للمستودع عبر واتساب)
  static Future<void> sharePdf(Uint8List bytes, String filename) =>
      Printing.sharePdf(bytes: bytes, filename: filename);

  // ------------------------------------------------------------------
  // تقرير إغلاق الوردية
  // ------------------------------------------------------------------

  static Future<void> printShiftReport(ShiftSummary sum, String userName, String? receiverName) async {
    final st = AppState.I.s.settings;
    final paper = st.paperSize;
    final roll = _isRoll(paper);
    final fs = roll ? 8.0 : 10.0;
    final theme = await _theme();
    final doc = pw.Document(theme: theme);
    final sh = sum.shift;

    pw.Widget kv(String k, String v, {bool bold = false}) => pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            _T(k, style: pw.TextStyle(fontSize: fs, fontWeight: bold ? pw.FontWeight.bold : null)),
            _T(v, style: pw.TextStyle(fontSize: fs, fontWeight: bold ? pw.FontWeight.bold : null)),
          ],
        );

    final content = <pw.Widget>[
      pw.Center(child: _T(st.pharmacyName, style: pw.TextStyle(fontSize: fs + 4, fontWeight: pw.FontWeight.bold))),
      pw.Center(child: _T('تقرير تسليم الدرج', style: pw.TextStyle(fontSize: fs + 2, fontWeight: pw.FontWeight.bold))),
      pw.SizedBox(height: 4),
      kv('رقم الوردية', '${sh.id}'),
      kv('الصيدلي', userName),
      kv('البداية', fmtDateTime(sh.openedAt)),
      kv('النهاية', fmtDateTime(sh.closedAt ?? DateTime.now())),
      if (receiverName != null) kv('المستلم', receiverName),
      pw.Divider(thickness: 0.6),
      kv('عدد الفواتير', '${sum.salesCount}'),
      kv('إجمالي المبيعات', fmtSyp(sum.salesTotalSyp)),
      if (sum.debtSalesSyp > 0) kv('منها بالدين', fmtSyp(sum.debtSalesSyp)),
      pw.Divider(thickness: 0.6),
      _T('حركات الدرج', style: pw.TextStyle(fontSize: fs, fontWeight: pw.FontWeight.bold)),
      for (final e in sum.byType.entries)
        kv(CashTypes.label(e.key),
            [if (e.value.syp != 0) fmtSyp(e.value.syp), if (e.value.usd != 0) fmtUsd(e.value.usd)].join(' / ')),
      pw.Divider(thickness: 0.6),
      kv('المتوقع ليرة', fmtSyp(sh.expectedSyp ?? sum.balance.syp), bold: true),
      kv('المتوقع دولار', fmtUsd(sh.expectedUsd ?? sum.balance.usd), bold: true),
      if (sh.actualSyp != null) ...[
        kv('الفعلي ليرة', fmtSyp(sh.actualSyp!)),
        kv('الفعلي دولار', fmtUsd(sh.actualUsd ?? 0)),
        kv('الفرق ليرة', _diff(sh.diffSyp ?? 0, true), bold: true),
        kv('الفرق دولار', _diff(sh.diffUsd ?? 0, false), bold: true),
      ],
      if (sh.note != null && sh.note!.isNotEmpty) _T('ملاحظة: ${sh.note}', style: pw.TextStyle(fontSize: fs)),
      pw.SizedBox(height: 16),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        _T('توقيع المسلِّم: ........', style: pw.TextStyle(fontSize: fs)),
        _T('توقيع المستلم: ........', style: pw.TextStyle(fontSize: fs)),
      ]),
    ];

    final fmt = formatFor(paper);
    doc.addPage(pw.Page(
      pageFormat: roll
          ? PdfPageFormat(fmt.width, double.infinity,
              marginLeft: fmt.marginLeft, marginRight: fmt.marginRight, marginTop: fmt.marginTop, marginBottom: fmt.marginBottom)
          : fmt,
      textDirection: pw.TextDirection.rtl,
      build: (_) => pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.stretch, children: content),
    ));
    await printPdf(await doc.save(), name: 'وردية ${sh.id}');
  }

  static String _diff(double v, bool syp) {
    final s = syp ? fmtSyp(v.abs()) : fmtUsd(v.abs());
    if (v.abs() < 0.001) return 'مطابق';
    return v > 0 ? 'زيادة $s' : 'عجز $s';
  }
}
