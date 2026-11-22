import 'dart:convert';

import 'package:drift/drift.dart';

import '../data/database.dart';

/// سجل التدقيق: من فعل ماذا ومتى
class AuditService {
  final AppDatabase db;
  AuditService(this.db);

  Future<void> log(User? user, String action, {String? entity, int? entityId, Object? details}) async {
    String? d;
    if (details is String) {
      d = details;
    } else if (details != null) {
      d = jsonEncode(details);
    }
    await db
        .into(db.auditLogs)
        .insert(
          AuditLogsCompanion.insert(
            action: action,
            userId: Value(user?.id),
            userName: Value(user?.fullName),
            entity: Value(entity),
            entityId: Value(entityId),
            details: Value(d),
          ),
        );
  }

  Future<List<AuditLog>> list({DateTime? from, DateTime? to, int? userId, String? search, int limit = 500}) {
    final q = db.select(db.auditLogs);
    q.where((t) {
      Expression<bool> e = const Constant(true);
      if (from != null) e = e & t.createdAt.isBiggerOrEqualValue(from);
      if (to != null) e = e & t.createdAt.isSmallerThanValue(to);
      if (userId != null) e = e & t.userId.equals(userId);
      if (search != null && search.trim().isNotEmpty) {
        final s = '%${search.trim()}%';
        e = e & (t.action.like(s) | t.details.like(s) | t.entity.like(s));
      }
      return e;
    });
    q.orderBy([(t) => OrderingTerm.desc(t.id)]);
    q.limit(limit);
    return q.get();
  }
}

/// أسماء العمليات المسجلة في سجل التدقيق
class AuditActions {
  static const login = 'تسجيل دخول';
  static const logout = 'تسجيل خروج';
  static const loginFailed = 'محاولة دخول فاشلة';
  static const userCreated = 'إضافة مستخدم';
  static const userUpdated = 'تعديل مستخدم';
  static const passwordChanged = 'تغيير كلمة مرور';
  static const medicineCreated = 'إضافة دواء';
  static const medicineUpdated = 'تعديل دواء';
  static const priceChanged = 'تعديل سعر';
  static const rateChanged = 'تعديل سعر الصرف';
  static const stockAdjusted = 'تعديل مخزون (جرد)';
  static const batchAdded = 'إضافة دفعة';
  static const expiredWriteOff = 'إتلاف منتهي الصلاحية';
  static const saleCompleted = 'فاتورة بيع';
  static const saleVoided = 'إلغاء فاتورة';
  static const customerReturn = 'مرتجع من زبون';
  static const supplierReturn = 'مرتجع إلى مورد';
  static const purchaseCreated = 'فاتورة شراء';
  static const supplierPayment = 'دفعة لمورد';
  static const customerPayment = 'تحصيل دين زبون';
  static const debtAdjusted = 'تعديل دين';
  static const shiftOpened = 'فتح وردية';
  static const shiftClosed = 'إغلاق وردية وتسليم الدرج';
  static const cashMovement = 'حركة نقدية';
  static const settingsChanged = 'تعديل الإعدادات';
  static const backupCreated = 'نسخة احتياطية';
  static const backupRestored = 'استعادة نسخة احتياطية';
}
