import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

import 'tables.dart';

export 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    Settings,
    ExchangeRates,
    Medicines,
    Batches,
    StockAdjustments,
    Suppliers,
    SupplierTransactions,
    Customers,
    CustomerTransactions,
    Purchases,
    PurchaseItems,
    Shifts,
    CashMovements,
    Sales,
    SaleItems,
    SaleItemBatches,
    CustomerReturns,
    CustomerReturnItems,
    SupplierReturns,
    SupplierReturnItems,
    AuditLogs,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  /// فتح قاعدة بيانات مشفّرة من ملف
  factory AppDatabase.open(File file, String key) {
    return AppDatabase(NativeDatabase.createInBackground(file, setup: (db) => _applyKey(db, key)));
  }

  /// قاعدة بيانات في الذاكرة (للاختبارات)
  factory AppDatabase.memory() => AppDatabase(NativeDatabase.memory());

  static void _applyKey(sqlite.Database db, String key) {
    final escaped = key.replaceAll("'", "''");
    db.execute("PRAGMA key = '$escaped';");
    // التحقق من أن المفتاح صحيح (يرمي استثناء إذا كان الملف مشفراً بمفتاح آخر)
    db.select('SELECT count(*) FROM sqlite_master;');
    db.execute('PRAGMA foreign_keys = ON;');
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await customStatement('CREATE INDEX idx_batches_medicine ON batches(medicine_id)');
      await customStatement('CREATE INDEX idx_batches_expiry ON batches(expiry_date)');
      await customStatement('CREATE INDEX idx_sales_created ON sales(created_at)');
      await customStatement('CREATE INDEX idx_sales_shift ON sales(shift_id)');
      await customStatement('CREATE INDEX idx_sale_items_sale ON sale_items(sale_id)');
      await customStatement('CREATE INDEX idx_cash_shift ON cash_movements(shift_id)');
      await customStatement('CREATE INDEX idx_cust_tx ON customer_transactions(customer_id)');
      await customStatement('CREATE INDEX idx_supp_tx ON supplier_transactions(supplier_id)');
      await customStatement('CREATE INDEX idx_medicine_name ON medicines(name)');
      await customStatement('CREATE INDEX idx_medicine_sci ON medicines(scientific_name)');
      await customStatement('CREATE INDEX idx_audit_created ON audit_logs(created_at)');
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
