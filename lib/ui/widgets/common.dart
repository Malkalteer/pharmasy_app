import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/money.dart';
import '../../core/permissions.dart';

const kPrimary = Color(0xFF0F766E);
const kDanger = Color(0xFFB91C1C);
const kWarning = Color(0xFFB45309);
const kSuccess = Color(0xFF15803D);

String errorText(Object e) {
  if (e is BusinessException || e is PermissionDenied) return e.toString();
  final s = e.toString();
  return s.replaceFirst('Exception: ', '');
}

void showError(BuildContext context, Object e) {
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(errorText(e), style: const TextStyle(fontSize: 15)),
    backgroundColor: kDanger,
    duration: const Duration(seconds: 5),
  ));
}

void showOk(BuildContext context, String msg) {
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg, style: const TextStyle(fontSize: 15)),
    backgroundColor: kSuccess,
    duration: const Duration(seconds: 3),
  ));
}

/// تنفيذ عملية مع عرض الخطأ تلقائياً
Future<T?> guard<T>(BuildContext context, Future<T> Function() fn, {String? success}) async {
  try {
    final r = await fn();
    if (success != null && context.mounted) showOk(context, success);
    return r;
  } catch (e) {
    if (context.mounted) showError(context, e);
    return null;
  }
}

Future<bool> confirm(BuildContext context, String title, String message,
    {String ok = 'تأكيد', bool danger = false}) async {
  final r = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء')),
        FilledButton(
          style: danger ? FilledButton.styleFrom(backgroundColor: kDanger) : null,
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(ok),
        ),
      ],
    ),
  );
  return r ?? false;
}

/// نافذة إدخال نص بسيطة
Future<String?> promptText(BuildContext context, String title,
    {String? label, String? initial, bool required = true, bool obscure = false}) async {
  final c = TextEditingController(text: initial);
  final r = await showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: 380,
        child: TextField(
          controller: c,
          autofocus: true,
          obscureText: obscure,
          decoration: InputDecoration(labelText: label),
          onSubmitted: (v) => Navigator.pop(ctx, v),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
        FilledButton(onPressed: () => Navigator.pop(ctx, c.text), child: const Text('موافق')),
      ],
    ),
  );
  if (r == null) return null;
  if (required && r.trim().isEmpty) return null;
  return r;
}

/// حقل رقمي يقبل الأرقام العربية والإنجليزية
class NumField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? suffix;
  final bool decimal;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final String? helper;
  final bool enabled;

  const NumField({
    super.key,
    required this.controller,
    required this.label,
    this.suffix,
    this.decimal = true,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.helper,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      enabled: enabled,
      keyboardType: TextInputType.numberWithOptions(decimal: decimal),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.right,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(decimal ? r'[0-9٠-٩.,٫\-]' : r'[0-9٠-٩\-]')),
      ],
      decoration: InputDecoration(labelText: label, suffixText: suffix, helperText: helper),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  final List<Widget> actions;
  final IconData? icon;
  const SectionTitle(this.text, {super.key, this.actions = const [], this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
      child: Row(children: [
        if (icon != null) ...[Icon(icon, color: kPrimary, size: 28), const SizedBox(width: 10)],
        Text(text, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const Spacer(),
        Wrap(spacing: 8, runSpacing: 8, children: actions),
      ]),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? sub;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.sub,
    this.color = kPrimary,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withValues(alpha: 0.12),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: TextStyle(color: Colors.grey.shade700)),
                  const SizedBox(height: 4),
                  Text(value, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                  if (sub != null) Text(sub!, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final String text;
  final IconData icon;
  const EmptyState(this.text, {super.key, this.icon = Icons.inbox_outlined});

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 56, color: Colors.grey.shade400),
            const SizedBox(height: 10),
            Text(text, style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
          ]),
        ),
      );
}

class Badge2 extends StatelessWidget {
  final String text;
  final Color color;
  const Badge2(this.text, {super.key, this.color = kPrimary});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
        child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12)),
      );
}

/// جدول بسيط قابل للتمرير مبني على DataTable
class SimpleTable extends StatelessWidget {
  final List<String> columns;
  final List<List<Widget>> rows;
  final List<VoidCallback?>? onTaps;
  final Set<int> numericColumns;

  const SimpleTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onTaps,
    this.numericColumns = const {},
  });

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) return const EmptyState('لا توجد بيانات');
    return Card(
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (ctx, cons) => SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: cons.maxWidth),
              child: DataTable(
                showCheckboxColumn: false,
                headingRowColor: WidgetStatePropertyAll(kPrimary.withValues(alpha: 0.08)),
                headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                dataRowMinHeight: 40,
                dataRowMaxHeight: 56,
                columns: [
                  for (var i = 0; i < columns.length; i++)
                    DataColumn(label: Text(columns[i]), numeric: numericColumns.contains(i)),
                ],
                rows: [
                  for (var r = 0; r < rows.length; r++)
                    DataRow(
                      onSelectChanged: onTaps?[r] == null ? null : (_) => onTaps![r]!(),
                      cells: [for (final c in rows[r]) DataCell(c)],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// اختيار فترة زمنية
class DateRangeBar extends StatelessWidget {
  final DateTime from;
  final DateTime to;
  final void Function(DateTime from, DateTime to) onChanged;

  const DateRangeBar({super.key, required this.from, required this.to, required this.onChanged});

  static DateTime dayStart(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  Widget build(BuildContext context) {
    final today = dayStart(DateTime.now());
    Widget chip(String label, DateTime f, DateTime t) => ActionChip(label: Text(label), onPressed: () => onChanged(f, t));
    return Wrap(spacing: 8, runSpacing: 8, crossAxisAlignment: WrapCrossAlignment.center, children: [
      chip('اليوم', today, today.add(const Duration(days: 1))),
      chip('أمس', today.subtract(const Duration(days: 1)), today),
      chip('آخر 7 أيام', today.subtract(const Duration(days: 6)), today.add(const Duration(days: 1))),
      chip('هذا الشهر', DateTime(today.year, today.month), DateTime(today.year, today.month + 1)),
      chip('الشهر الماضي', DateTime(today.year, today.month - 1), DateTime(today.year, today.month)),
      chip('هذه السنة', DateTime(today.year), DateTime(today.year + 1)),
      OutlinedButton.icon(
        icon: const Icon(Icons.date_range),
        label: Text('${fmtDate(from)} - ${fmtDate(to.subtract(const Duration(days: 1)))}'),
        onPressed: () async {
          final r = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
            initialDateRange: DateTimeRange(start: from, end: to.subtract(const Duration(days: 1))),
          );
          if (r != null) onChanged(dayStart(r.start), dayStart(r.end).add(const Duration(days: 1)));
        },
      ),
    ]);
  }
}

/// عرض مبلغ بالليرة مع ما يعادله بالدولار
class MoneyText extends StatelessWidget {
  final double usd;
  final double rate;
  final TextStyle? style;
  const MoneyText({super.key, required this.usd, required this.rate, this.style});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(fmtSyp(roundTo(usd * rate, 0)), style: style),
          Text(fmtUsd(roundTo(usd, 2)), style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        ],
      );
}

Future<DateTime?> pickDate(BuildContext context, {DateTime? initial}) => showDatePicker(
      context: context,
      initialDate: initial ?? DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    );
