import 'dart:convert';

import 'package:material_ui/material_ui.dart';

import '../../core/app_state.dart';
import '../../core/money.dart';
import '../../data/database.dart';
import '../widgets/common.dart';

/// سجل التدقيق: كل العمليات الحساسة (تعديل أسعار، إلغاء فواتير، جرد...)
class AuditScreen extends StatefulWidget {
  const AuditScreen({super.key});

  @override
  State<AuditScreen> createState() => _AuditScreenState();
}

class _AuditScreenState extends State<AuditScreen> {
  late DateTime _from = DateRangeBar.dayStart(DateTime.now()).subtract(const Duration(days: 6));
  late DateTime _to = DateRangeBar.dayStart(DateTime.now()).add(const Duration(days: 1));
  int? _userId;
  final _q = TextEditingController();
  List<AuditLog> _logs = [];
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final s = AppState.I.s;
    final logs = await s.audit.list(from: _from, to: _to, userId: _userId, search: _q.text);
    final users = await s.users.list();
    if (mounted) {
      setState(() {
        _logs = logs;
        _users = users;
      });
    }
  }

  String _details(String? d) {
    if (d == null) return '';
    try {
      final j = jsonDecode(d);
      if (j is Map) {
        const keys = {
          'name': 'الاسم',
          'old': 'القديم',
          'new': 'الجديد',
          'total': 'الإجمالي',
          'reason': 'السبب',
          'from': 'من',
          'to': 'إلى',
          'qty': 'الكمية',
          'medicine': 'الدواء',
          'amount': 'المبلغ',
          'currency': 'العملة',
          'customer': 'الزبون',
          'supplier': 'المورد',
          'discount': 'الخصم',
          'debt': 'دين',
          'diffSyp': 'فرق ليرة',
          'diffUsd': 'فرق دولار',
          'note': 'ملاحظة',
        };
        return j.entries.map((e) => '${keys[e.key] ?? e.key}: ${e.value}').join('  •  ');
      }
      return '$j';
    } catch (_) {
      return d;
    }
  }

  bool _important(String action) =>
      action.contains('إلغاء') ||
      action.contains('سعر') ||
      action.contains('جرد') ||
      action.contains('فاشلة') ||
      action.contains('إتلاف');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionTitle('سجل العمليات', icon: Icons.history),
          DateRangeBar(
            from: _from,
            to: _to,
            onChanged: (f, t) {
              _from = f;
              _to = t;
              _load();
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _q,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'بحث في العمليات'),
                  onChanged: (_) => _load(),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 220,
                child: DropdownButtonFormField<int?>(
                  initialValue: _userId,
                  decoration: const InputDecoration(labelText: 'المستخدم'),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('الكل')),
                    for (final u in _users) DropdownMenuItem(value: u.id, child: Text(u.fullName)),
                  ],
                  onChanged: (v) {
                    _userId = v;
                    _load();
                  },
                ),
              ),
              const Spacer(),
              Text('${_logs.length} عملية'),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SimpleTable(
              columns: const ['الوقت', 'المستخدم', 'العملية', 'المرجع', 'التفاصيل'],
              rows: [
                for (final l in _logs)
                  [
                    Text(fmtDateTime(l.createdAt)),
                    Text(l.userName ?? '-'),
                    Text(
                      l.action,
                      style: TextStyle(fontWeight: FontWeight.w600, color: _important(l.action) ? kDanger : null),
                    ),
                    Text(l.entityId == null ? '' : '#${l.entityId}'),
                    SizedBox(
                      width: 520,
                      child: Text(_details(l.details), maxLines: 3, overflow: TextOverflow.ellipsis),
                    ),
                  ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
