// تعريف جداول قاعدة البيانات المحلية (Drift / SQLite مشفّرة)
//
// ملاحظات عامة على التصميم:
// - التسعير الأساسي بالدولار، ويُحوَّل إلى الليرة السورية حسب سعر الصرف الحالي.
// - المخزون يُخزَّن دائماً بأصغر وحدة (حبة/أمبولة...) في حقل quantity للدفعات.
// - الفواتير تُحفظ بالليرة (الأسعار التي رآها الزبون) مع سعر الصرف وقت البيع.
// - ديون الزبائن والموردين تُحفظ بما يعادلها بالدولار لحماية الصيدلية من تغيّر سعر الصرف.

import 'package:drift/drift.dart';

@DataClassName('User')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().unique()();
  TextColumn get fullName => text()();
  TextColumn get passwordHash => text()();
  TextColumn get salt => text()();

  /// owner = مالك (كل الصلاحيات)، pharmacist = صيدلي
  TextColumn get role => text()();

  /// قائمة صلاحيات مفصولة بفواصل (انظر Permission)
  TextColumn get permissions => text().withDefault(const Constant(''))();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Setting')
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DataClassName('ExchangeRate')
class ExchangeRates extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get rate => real()();
  IntColumn get userId => integer().nullable().references(Users, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Medicine')
class Medicines extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();

  /// المادة الفعالة (تُستخدم لاقتراح البدائل)
  TextColumn get scientificName => text().nullable()();
  TextColumn get manufacturer => text().nullable()();

  /// الشكل الصيدلاني: حب، شراب، حقن...
  TextColumn get form => text().nullable()();
  TextColumn get category => text().nullable()();
  TextColumn get barcode => text().nullable().unique()();

  /// عدد الأشرطة (الظروف) في العلبة
  IntColumn get stripsPerBox => integer().withDefault(const Constant(1))();

  /// عدد الحبات في الشريط
  IntColumn get unitsPerStrip => integer().withDefault(const Constant(1))();
  TextColumn get boxName => text().withDefault(const Constant('علبة'))();
  TextColumn get stripName => text().withDefault(const Constant('ظرف'))();
  TextColumn get unitName => text().withDefault(const Constant('حبة'))();
  BoolColumn get allowStripSale => boolean().withDefault(const Constant(false))();
  BoolColumn get allowUnitSale => boolean().withDefault(const Constant(false))();

  /// سعر بيع العلبة بالدولار
  RealColumn get priceUsd => real().withDefault(const Constant(0))();

  /// سعر خاص للشريط/الحبة (اختياري، وإلا يُحسب تناسبياً)
  RealColumn get stripPriceUsd => real().nullable()();
  RealColumn get unitPriceUsd => real().nullable()();

  /// الحد الأدنى للمخزون بالعلب
  RealColumn get minStockBoxes => real().withDefault(const Constant(0))();
  BoolColumn get requiresPrescription => boolean().withDefault(const Constant(false))();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('StockBatch')
class Batches extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get medicineId => integer().references(Medicines, #id)();
  TextColumn get batchNumber => text().nullable()();
  DateTimeColumn get expiryDate => dateTime().nullable()();

  /// الكمية المتبقية بأصغر وحدة
  IntColumn get quantity => integer()();
  IntColumn get initialQuantity => integer()();

  /// تكلفة العلبة بالدولار
  RealColumn get costUsdPerBox => real().withDefault(const Constant(0))();
  IntColumn get supplierId => integer().nullable().references(Suppliers, #id)();
  IntColumn get purchaseId => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// تعديلات المخزون (جرد، تالف، منتهي الصلاحية...)
@DataClassName('StockAdjustment')
class StockAdjustments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get batchId => integer().references(Batches, #id)();
  IntColumn get medicineId => integer().references(Medicines, #id)();

  /// الفرق بأصغر وحدة (موجب = زيادة، سالب = نقص)
  IntColumn get delta => integer()();

  /// count = جرد، damaged = تالف، expired = منتهي، other
  TextColumn get reason => text()();
  TextColumn get note => text().nullable()();
  IntColumn get userId => integer().nullable().references(Users, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Supplier')
class Suppliers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// دفتر حساب المورد: amountUsd موجب = زيادة دين الصيدلية للمورد
@DataClassName('SupplierTransaction')
class SupplierTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get supplierId => integer().references(Suppliers, #id)();

  /// purchase, payment, return, adjustment
  TextColumn get type => text()();
  RealColumn get amountUsd => real()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
  RealColumn get originalAmount => real().withDefault(const Constant(0))();
  RealColumn get rate => real().withDefault(const Constant(0))();
  IntColumn get refId => integer().nullable()();
  IntColumn get shiftId => integer().nullable()();
  IntColumn get userId => integer().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Customer')
class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get notes => text().nullable()();

  /// سقف الدين بالدولار (اختياري)
  RealColumn get creditLimitUsd => real().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// دفتر حساب الزبون: amountUsd موجب = زيادة دين الزبون
@DataClassName('CustomerTransaction')
class CustomerTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get customerId => integer().references(Customers, #id)();

  /// sale, payment, return, adjustment, void
  TextColumn get type => text()();
  RealColumn get amountUsd => real()();
  TextColumn get currency => text().withDefault(const Constant('SYP'))();
  RealColumn get originalAmount => real().withDefault(const Constant(0))();
  RealColumn get rate => real().withDefault(const Constant(0))();
  IntColumn get refId => integer().nullable()();
  IntColumn get shiftId => integer().nullable()();
  IntColumn get userId => integer().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Purchase')
class Purchases extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get supplierId => integer().references(Suppliers, #id)();
  TextColumn get invoiceNumber => text().nullable()();
  DateTimeColumn get invoiceDate => dateTime()();
  RealColumn get totalUsd => real()();
  RealColumn get discountUsd => real().withDefault(const Constant(0))();
  RealColumn get paidUsd => real().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  IntColumn get userId => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('PurchaseItem')
class PurchaseItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get purchaseId => integer().references(Purchases, #id)();
  IntColumn get medicineId => integer().references(Medicines, #id)();
  IntColumn get batchId => integer().nullable()();
  IntColumn get quantityBoxes => integer()();
  IntColumn get bonusBoxes => integer().withDefault(const Constant(0))();
  RealColumn get costUsdPerBox => real()();
  TextColumn get batchNumber => text().nullable()();
  DateTimeColumn get expiryDate => dateTime().nullable()();
  RealColumn get totalUsd => real()();
}

@DataClassName('Shift')
class Shifts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  DateTimeColumn get openedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get closedAt => dateTime().nullable()();
  RealColumn get openingSyp => real().withDefault(const Constant(0))();
  RealColumn get openingUsd => real().withDefault(const Constant(0))();
  RealColumn get expectedSyp => real().nullable()();
  RealColumn get expectedUsd => real().nullable()();
  RealColumn get actualSyp => real().nullable()();
  RealColumn get actualUsd => real().nullable()();
  RealColumn get diffSyp => real().nullable()();
  RealColumn get diffUsd => real().nullable()();

  /// المستلم (المالك أو صيدلي آخر)
  IntColumn get receivedById => integer().nullable()();
  TextColumn get note => text().nullable()();

  /// open / closed
  TextColumn get status => text().withDefault(const Constant('open'))();
}

/// حركات الدرج المالي. المبلغ موجب = دخول للدرج، سالب = خروج.
@DataClassName('CashMovement')
class CashMovements extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get shiftId => integer().references(Shifts, #id)();
  IntColumn get userId => integer().nullable()();

  /// opening, sale, change, refund, expense, withdrawal, deposit,
  /// supplier_payment, customer_payment, supplier_return, void, handover
  TextColumn get type => text()();

  /// SYP / USD
  TextColumn get currency => text()();
  RealColumn get amount => real()();
  IntColumn get refId => integer().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Sale')
class Sales extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get shiftId => integer().references(Shifts, #id)();
  IntColumn get userId => integer().references(Users, #id)();
  IntColumn get customerId => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// سعر الصرف وقت البيع
  RealColumn get rate => real()();
  RealColumn get subtotalSyp => real()();
  RealColumn get discountSyp => real().withDefault(const Constant(0))();
  RealColumn get totalSyp => real()();
  RealColumn get totalUsd => real()();

  /// تكلفة الأدوية المباعة بالدولار (لحساب الربح)
  RealColumn get costUsd => real().withDefault(const Constant(0))();
  RealColumn get paidSyp => real().withDefault(const Constant(0))();
  RealColumn get paidUsd => real().withDefault(const Constant(0))();
  RealColumn get changeSyp => real().withDefault(const Constant(0))();

  /// المبلغ المسجَّل ديناً على الزبون بالليرة
  RealColumn get debtSyp => real().withDefault(const Constant(0))();

  /// completed / voided
  TextColumn get status => text().withDefault(const Constant('completed'))();
  IntColumn get voidedById => integer().nullable()();
  DateTimeColumn get voidedAt => dateTime().nullable()();
  TextColumn get voidReason => text().nullable()();
  TextColumn get note => text().nullable()();
}

@DataClassName('SaleItem')
class SaleItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get saleId => integer().references(Sales, #id)();
  IntColumn get medicineId => integer().references(Medicines, #id)();
  TextColumn get medicineName => text()();

  /// 0 = علبة، 1 = شريط، 2 = حبة
  IntColumn get unit => integer()();
  TextColumn get unitLabel => text()();
  IntColumn get quantity => integer()();

  /// الكمية بأصغر وحدة
  IntColumn get baseQuantity => integer()();
  RealColumn get unitPriceUsd => real()();
  RealColumn get unitPriceSyp => real()();
  RealColumn get totalSyp => real()();
  RealColumn get costUsd => real()();

  /// الكمية المرتجعة بأصغر وحدة
  IntColumn get returnedBase => integer().withDefault(const Constant(0))();
}

/// توزيع سطر البيع على الدفعات (الأقرب انتهاءً أولاً)
@DataClassName('SaleItemBatch')
class SaleItemBatches extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get saleItemId => integer().references(SaleItems, #id)();
  IntColumn get batchId => integer().references(Batches, #id)();
  IntColumn get baseQuantity => integer()();
  RealColumn get costUsd => real()();
  IntColumn get returnedBase => integer().withDefault(const Constant(0))();
}

@DataClassName('CustomerReturn')
class CustomerReturns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get saleId => integer().references(Sales, #id)();
  IntColumn get customerId => integer().nullable()();
  IntColumn get shiftId => integer().references(Shifts, #id)();
  IntColumn get userId => integer().references(Users, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  RealColumn get rate => real()();
  RealColumn get totalSyp => real()();
  RealColumn get refundSyp => real().withDefault(const Constant(0))();

  /// المبلغ الذي خُصم من دين الزبون
  RealColumn get debtReducedSyp => real().withDefault(const Constant(0))();
  RealColumn get costUsd => real().withDefault(const Constant(0))();
  TextColumn get note => text().nullable()();
}

@DataClassName('CustomerReturnItem')
class CustomerReturnItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get returnId => integer().references(CustomerReturns, #id)();
  IntColumn get saleItemId => integer().references(SaleItems, #id)();
  IntColumn get medicineId => integer().references(Medicines, #id)();
  IntColumn get baseQuantity => integer()();
  RealColumn get amountSyp => real()();
  BoolColumn get restocked => boolean().withDefault(const Constant(true))();
}

@DataClassName('SupplierReturn')
class SupplierReturns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get supplierId => integer().references(Suppliers, #id)();
  IntColumn get userId => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  RealColumn get totalUsd => real()();

  /// credit = خصم من دين المورد، cash = استلام نقدي
  TextColumn get settlement => text()();
  TextColumn get note => text().nullable()();
}

@DataClassName('SupplierReturnItem')
class SupplierReturnItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get returnId => integer().references(SupplierReturns, #id)();
  IntColumn get batchId => integer().references(Batches, #id)();
  IntColumn get medicineId => integer().references(Medicines, #id)();
  IntColumn get baseQuantity => integer()();
  RealColumn get amountUsd => real()();
}

@DataClassName('AuditLog')
class AuditLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().nullable()();
  TextColumn get userName => text().nullable()();
  TextColumn get action => text()();
  TextColumn get entity => text().nullable()();
  IntColumn get entityId => integer().nullable()();
  TextColumn get details => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
