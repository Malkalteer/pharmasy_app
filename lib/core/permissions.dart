import '../data/database.dart';

/// صلاحيات المستخدمين. المالك يملك جميع الصلاحيات تلقائياً.
enum Permission {
  editPrices('تعديل الأسعار وسعر الصرف'),
  manageMedicines('إضافة وتعديل الأدوية والجرد'),
  managePurchases('المشتريات والموردون'),
  manageCustomers('الزبائن وتحصيل الديون'),
  sellOnCredit('البيع بالدين'),
  giveDiscount('إعطاء خصم'),
  voidSales('إلغاء الفواتير'),
  returns('المرتجعات'),
  viewReports('التقارير والأرباح'),
  viewAllShifts('رؤية ورديات الآخرين'),
  cashOut('مصاريف وسحب من الدرج');

  final String label;
  const Permission(this.label);
}

const roleOwner = 'owner';
const rolePharmacist = 'pharmacist';

String roleLabel(String role) => role == roleOwner ? 'مالك' : 'صيدلي';

/// الصلاحيات الافتراضية للصيدلي الجديد
const defaultPharmacistPermissions = {Permission.returns, Permission.manageCustomers};

extension UserPermissions on User {
  bool get isOwner => role == roleOwner;

  Set<Permission> get permissionSet => permissions
      .split(',')
      .where((s) => s.isNotEmpty)
      .map((s) => Permission.values.where((p) => p.name == s).firstOrNull)
      .whereType<Permission>()
      .toSet();

  bool can(Permission p) => isOwner || permissionSet.contains(p);
}

String encodePermissions(Iterable<Permission> ps) => ps.map((p) => p.name).join(',');

class PermissionDenied implements Exception {
  final Permission? permission;
  PermissionDenied([this.permission]);

  @override
  String toString() => permission == null ? 'هذه العملية متاحة للمالك فقط' : 'ليس لديك صلاحية: ${permission!.label}';
}

/// خطأ في منطق العمل يُعرض للمستخدم كما هو
class BusinessException implements Exception {
  final String message;
  BusinessException(this.message);

  @override
  String toString() => message;
}
