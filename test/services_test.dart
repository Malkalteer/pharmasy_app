import 'dart:io';

import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:pharmacy_app/core/app_state.dart';
import 'package:pharmacy_app/core/license/license_format.dart';
import 'package:pharmacy_app/core/money.dart';
import 'package:pharmacy_app/core/permissions.dart';
import 'package:pharmacy_app/core/units.dart';
import 'package:pharmacy_app/data/database.dart';
import 'package:pharmacy_app/services/returns_service.dart';
import 'package:pharmacy_app/services/sales_service.dart';
import 'package:pharmacy_app/services/purchase_service.dart';
import 'package:pharmacy_app/services/shift_service.dart';

import "package:drift/drift.dart" as drift show driftRuntimeOptions;

void main() {
  drift.driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late Services s;
  late User owner;
  late User pharmacist;
  const rate = 150.0;
  const rounding = RoundingConfig(step: 1);

  setUp(() async {
    s = Services(AppDatabase.memory());
    await s.settings.load();
    owner = await s.users.create(
        actor: null, username: 'admin', fullName: 'المالك', password: '1234', role: roleOwner);
    pharmacist = await s.users.create(
        actor: owner,
        username: 'ahmad',
        fullName: 'أحمد',
        password: '1234',
        role: rolePharmacist,
        permissions: {Permission.returns});
  });

  tearDown(() => s.db.close());

  Future<Medicine> addMed({
    String name = 'بنادول',
    String? sci = 'Paracetamol',
    double price = 2,
    int strips = 2,
    int perStrip = 10,
    String? barcode,
  }) =>
      s.inventory.saveMedicine(
        actor: owner,
        data: MedicinesCompanion.insert(
          name: name,
          scientificName: Value(sci),
          barcode: Value(barcode),
          priceUsd: Value(price),
          stripsPerBox: Value(strips),
          unitsPerStrip: Value(perStrip),
          allowStripSale: const Value(true),
          allowUnitSale: const Value(true),
          minStockBoxes: const Value(5),
        ),
      );

  test('rounding and currency conversion', () {
    expect(usdToSyp(2, 150, const RoundingConfig(step: 1)), 300);
    expect(usdToSyp(2.35, 150, const RoundingConfig(step: 1)), 353); // 352.5 -> 353
    expect(usdToSyp(2.35, 150, const RoundingConfig(step: 5, mode: RoundingMode.up)), 355);
    expect(usdToSyp(2.35, 150, const RoundingConfig(step: 50, mode: RoundingMode.down)), 350);
    expect(usdToSyp(2.35, 150, const RoundingConfig(step: 0)), 352.5);
    expect(parseNum('١٥٠'), 150);
    expect(parseNum('1,250.5'), 1250.5);
    expect(parseDate('12/2027'), DateTime(2027, 12, 31));
    expect(parseDate('2027-03-15'), DateTime(2027, 3, 15));
  });

  test('units and prices', () async {
    final m = await addMed();
    expect(m.basePerBox, 20);
    expect(m.sellableUnits, [SaleUnit.box, SaleUnit.strip, SaleUnit.unit]);
    expect(m.priceUsdFor(SaleUnit.strip), 1);
    expect(m.priceUsdFor(SaleUnit.unit), 0.1);
    expect(m.describeQty(47), '2 علبة + 7 حبة');
    expect(m.describeQty(30), '1 علبة + 1 ظرف');
  });

  test('sale uses FEFO, computes change, profit and drawer', () async {
    final m = await addMed(barcode: '123');
    final now = DateTime.now();
    final lateBatch = await s.inventory.addBatch(
        actor: owner, medicine: m, baseQuantity: 40, expiryDate: DateTime(now.year + 2), costUsdPerBox: 1);
    final soon = await s.inventory.addBatch(
        actor: owner, medicine: m, baseQuantity: 20, expiryDate: DateTime(now.year + 1), costUsdPerBox: 1.2);
    await s.inventory.addBatch(
        actor: owner, medicine: m, baseQuantity: 100, expiryDate: DateTime(now.year - 1), costUsdPerBox: 1);

    final st = await s.inventory.stockOf(m.id);
    expect(st!.available, 60);
    expect(st.expired, 100);

    final shift = await s.shifts.open(user: pharmacist, openingSyp: 1000);
    // علبة + ظرف = 30 حبة → 20 من الدفعة الأقرب و10 من التالية
    final res = await s.sales.checkout(
      actor: pharmacist,
      shift: shift,
      lines: [CartLine(m, unit: SaleUnit.box), CartLine(m, unit: SaleUnit.strip)],
      payment: const PaymentInput(paidSyp: 500),
      rate: rate,
      rounding: rounding,
    );
    expect(res.sale.totalSyp, 450);
    expect(res.sale.changeSyp, 50);
    expect(res.sale.costUsd, closeTo(1.2 + 0.5, 1e-9));

    final bSoon = (await s.inventory.batchesOf(m.id)).firstWhere((b) => b.id == soon.id);
    final bLate = (await s.inventory.batchesOf(m.id)).firstWhere((b) => b.id == lateBatch.id);
    expect(bSoon.quantity, 0);
    expect(bLate.quantity, 30);

    final bal = await s.shifts.balance(shift.id);
    expect(bal.syp, 1450);

    // لا يمكن بيع أكثر من المتوفر الصالح
    expect(
      () => s.sales.checkout(
        actor: pharmacist,
        shift: shift,
        lines: [CartLine(m, quantity: 2)],
        payment: const PaymentInput(paidSyp: 600),
        rate: rate,
        rounding: rounding,
      ),
      throwsA(isA<BusinessException>()),
    );

    final report = await s.reports.total(DateTime(2000), DateTime(2100));
    expect(report.salesSyp, 450);
    expect(report.profitUsd, closeTo(3 - 1.7, 1e-6));
  });

  test('paying in USD and SYP together', () async {
    final m = await addMed(price: 10);
    await s.inventory.addBatch(actor: owner, medicine: m, baseQuantity: 20);
    final shift = await s.shifts.open(user: owner);
    final res = await s.sales.checkout(
      actor: owner,
      shift: shift,
      lines: [CartLine(m)],
      payment: const PaymentInput(paidUsd: 5, paidSyp: 800),
      rate: rate,
      rounding: rounding,
    );
    // 1500 ل.س: 5$ = 750 + 800 = 1550 → الباقي 50
    expect(res.sale.changeSyp, 50);
    final bal = await s.shifts.balance(shift.id);
    expect(bal.usd, 5);
    expect(bal.syp, 750);
  });

  test('credit sale needs customer and permission; return reduces debt', () async {
    final m = await addMed();
    await s.inventory.addBatch(actor: owner, medicine: m, baseQuantity: 100);
    final shiftP = await s.shifts.open(user: pharmacist);
    final c = await s.customers.save(actor: owner, name: 'زبون');
    // الصيدلي لا يملك صلاحية البيع بالدين
    expect(
      () => s.sales.checkout(
        actor: pharmacist,
        shift: shiftP,
        lines: [CartLine(m)],
        payment: PaymentInput(customer: c),
        rate: rate,
        rounding: rounding,
      ),
      throwsA(isA<PermissionDenied>()),
    );
    final shift = await s.shifts.open(user: owner);
    final res = await s.sales.checkout(
      actor: owner,
      shift: shift,
      lines: [CartLine(m, quantity: 2)],
      payment: PaymentInput(customer: c, paidSyp: 200),
      rate: rate,
      rounding: rounding,
    );
    expect(res.sale.debtSyp, 400);
    expect(await s.customers.balanceUsd(c.id), closeTo(400 / 150, 1e-6));

    // إرجاع علبة (300) → تُخصم من الدين
    final ret = await s.returns.customerReturn(
      actor: owner,
      shift: shift,
      sale: res.sale,
      lines: [CustomerReturnLine(res.items.first, 1)],
    );
    expect(ret.debtReducedSyp, 300);
    expect(ret.refundSyp, 0);
    expect(await s.customers.balanceUsd(c.id), closeTo(100 / 150, 1e-6));
    expect((await s.inventory.stockOf(m.id))!.available, 80);
    expect(ReturnsService.returnableQty(
        (await s.sales.details(res.sale.id))!.items.first), 1);

    // تحصيل الباقي بالليرة
    await s.customers.receivePayment(
        actor: owner, shift: shift, customer: c, currency: currencySyp, amount: 100, rate: rate);
    expect(await s.customers.balanceUsd(c.id), closeTo(0, 1e-6));
  });

  test('void sale restores stock and cash', () async {
    final m = await addMed();
    await s.inventory.addBatch(actor: owner, medicine: m, baseQuantity: 20);
    final shift = await s.shifts.open(user: owner);
    final res = await s.sales.checkout(
      actor: owner,
      shift: shift,
      lines: [CartLine(m)],
      payment: const PaymentInput(paidSyp: 300),
      rate: rate,
      rounding: rounding,
    );
    await s.sales.voidSale(actor: owner, currentShift: shift, sale: res.sale, reason: 'خطأ');
    expect((await s.inventory.stockOf(m.id))!.available, 20);
    expect((await s.shifts.balance(shift.id)).syp, 0);
    expect(
      () => s.sales.voidSale(actor: pharmacist, currentShift: shift, sale: res.sale, reason: 'x'),
      throwsA(isA<PermissionDenied>()),
    );
  });

  test('shift close records shortage and zeroes drawer', () async {
    final shift = await s.shifts.open(user: pharmacist, openingSyp: 1000, openingUsd: 10);
    final closed = await s.shifts.close(
        user: pharmacist, shift: shift, actualSyp: 900, actualUsd: 10, receivedById: owner.id);
    expect(closed.diffSyp, -100);
    expect(closed.diffUsd, 0);
    expect(closed.status, 'closed');
    final bal = await s.shifts.balance(shift.id);
    expect(bal.syp, 0);
    expect(bal.usd, 0);
  });

  test('purchase with bonus, supplier debt, and supplier return', () async {
    final m = await addMed();
    final sup = await s.suppliers.save(actor: owner, name: 'مستودع');
    await s.purchases.create(
      actor: owner,
      supplier: sup,
      lines: [
        PurchaseLine(m,
            quantityBoxes: 10,
            bonusBoxes: 2,
            costUsdPerBox: 1.2,
            expiryDate: DateTime(DateTime.now().year + 2),
            newPriceUsd: 2.5),
      ],
      paidAmount: 4,
      paidCurrency: currencyUsd,
    );
    expect(await s.suppliers.balanceUsd(sup.id), closeTo(12 - 4, 1e-6));
    final batches = await s.inventory.batchesOf(m.id);
    expect(batches.single.quantity, 12 * 20);
    expect(batches.single.costUsdPerBox, closeTo(1.0, 1e-6)); // 12$ / 12 علبة
    expect((await s.inventory.byId(m.id))!.priceUsd, 2.5);

    await s.returns.supplierReturn(
      actor: owner,
      supplier: sup,
      lines: [SupplierReturnLine(batches.single, m, 40)],
      settlement: 'credit',
    );
    expect(await s.suppliers.balanceUsd(sup.id), closeTo(8 - 2, 1e-6));
    expect((await s.inventory.batchesOf(m.id)).single.quantity, 200);
  });

  test('alternatives, shortages and pharmacist cannot edit prices', () async {
    final a = await addMed(name: 'بنادول');
    final b = await addMed(name: 'سيتامول');
    await s.inventory.addBatch(actor: owner, medicine: b, baseQuantity: 20);
    final alts = await s.inventory.alternatives(a);
    expect(alts.map((e) => e.medicine.id), [b.id]);
    final short = await s.inventory.shortages();
    expect(short.length, 2);
    expect(
      () => s.inventory.saveMedicine(
          actor: pharmacist, existing: a, data: const MedicinesCompanion(priceUsd: Value(3))),
      throwsA(isA<PermissionDenied>()),
    );
    final logs = await s.audit.list();
    expect(logs.any((l) => l.action.contains('إضافة دواء')), isTrue);
  });

  test('user authentication', () async {
    expect(await s.users.authenticate('admin', '1234'), isNotNull);
    expect(await s.users.authenticate('admin', 'wrong'), isNull);
  });

  test('license sign and verify', () async {
    final (seed, pub) = await generateKeyPair();
    final data = LicenseData(
        machineId: 'AAAA-BBBB-CCCC-DDDD-EEEE',
        customer: 'صيدلية الشفاء',
        type: 'lifetime',
        issuedAt: DateTime(2026, 1, 1),
        serial: '1');
    final lic = await signLicense(data, seed);
    final v = await verifyLicense(lic, pub);
    expect(v, isNotNull);
    expect(v!.customer, 'صيدلية الشفاء');
    // تعديل أي حرف يُبطل التوقيع
    final tampered = lic.replaceRange(10, 11, lic[10] == 'A' ? 'B' : 'A');
    expect(await verifyLicense(tampered, pub), isNull);
  });

  test('encrypted database cannot be opened without key', () async {
    final dir = await Directory.systemTemp.createTemp('pharm');
    final f = File('${dir.path}/t.db');
    final db = AppDatabase.open(f, 'secret-key');
    await db.into(db.settings).insert(SettingsCompanion.insert(key: 'a', value: 'b'));
    await db.close();
    final bytes = await f.readAsBytes();
    expect(String.fromCharCodes(bytes.take(15)), isNot('SQLite format 3'));
    final wrong = AppDatabase.open(f, 'other');
    await expectLater(wrong.select(wrong.settings).get(), throwsA(anything));
    await wrong.close();
    final right = AppDatabase.open(f, 'secret-key');
    expect((await right.select(right.settings).get()).single.value, 'b');
    await right.close();
    await dir.delete(recursive: true);
  });
}
