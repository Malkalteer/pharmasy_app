import 'package:drift/drift.dart' show Value;

import '../core/app_state.dart';
import '../core/permissions.dart';
import '../core/units.dart';
import '../data/database.dart';
import '../services/purchase_service.dart';
import '../services/sales_service.dart';
import '../services/settings_service.dart';
import '../services/shift_service.dart';

/// بيانات تجريبية للعرض (تُفعَّل فقط بمتغير البيئة PHARMACY_DEMO=1 على قاعدة بيانات فارغة)
/// المستخدمون: admin / 1234 (مالك) و ahmad / 1234 (صيدلي)
Future<void> seedDemo(Services s) async {
  if (await s.users.hasUsers()) return;
  final owner = await s.users.create(
    actor: null,
    username: 'admin',
    fullName: 'د. سامر الخطيب',
    password: '1234',
    role: roleOwner,
  );
  await s.users.create(
    actor: owner,
    username: 'ahmad',
    fullName: 'أحمد العلي',
    password: '1234',
    role: rolePharmacist,
    permissions: {...defaultPharmacistPermissions, Permission.giveDiscount},
  );
  await s.settings.setAll({
    SettingKeys.pharmacyName: 'صيدلية الشفاء',
    SettingKeys.pharmacyAddress: 'دمشق - المزة - الشارع الرئيسي',
    SettingKeys.pharmacyPhone: '011-1234567',
    SettingKeys.roundingStep: '5',
    SettingKeys.roundingMode: 'up',
  });
  await s.settings.setExchangeRate(150, owner.id);

  final now = DateTime.now();
  Future<Medicine> med(
    String name,
    String sci,
    String maker,
    double price, {
    int strips = 1,
    int per = 1,
    String form = 'حب',
    String? barcode,
    double min = 3,
    bool strip = false,
    bool unit = false,
  }) {
    return s.inventory.saveMedicine(
      actor: owner,
      data: MedicinesCompanion.insert(
        name: name,
        scientificName: Value(sci),
        manufacturer: Value(maker),
        form: Value(form),
        barcode: Value(barcode),
        priceUsd: Value(price),
        stripsPerBox: Value(strips),
        unitsPerStrip: Value(per),
        allowStripSale: Value(strip),
        allowUnitSale: Value(unit),
        minStockBoxes: Value(min),
      ),
    );
  }

  final panadol = await med(
    'بنادول 500',
    'Paracetamol',
    'GSK',
    2,
    strips: 2,
    per: 10,
    barcode: '6281001234567',
    strip: true,
  );
  final sitamol = await med(
    'سيتامول 500',
    'Paracetamol',
    'ابن حيان',
    0.8,
    strips: 2,
    per: 10,
    barcode: '6281001234568',
    strip: true,
  );
  final augmentin = await med(
    'أوغمنتين 1 غ',
    'Amoxicillin + Clavulanic acid',
    'GSK',
    6.5,
    strips: 2,
    per: 7,
    barcode: '6281001234569',
  );
  final brufen = await med(
    'بروفين 400',
    'Ibuprofen',
    'Abbott',
    1.6,
    strips: 3,
    per: 10,
    barcode: '6281001234570',
    strip: true,
    unit: true,
  );
  final ventolin = await med('فنتولين بخاخ', 'Salbutamol', 'GSK', 4.25, form: 'بخاخ', barcode: '6281001234571', min: 2);
  final zyrtec = await med('زيرتك شراب', 'Cetirizine', 'UCB', 3.1, form: 'شراب', barcode: '6281001234572');
  final omep = await med(
    'أوميبرازول 20',
    'Omeprazole',
    'أوبري',
    2.4,
    strips: 2,
    per: 14,
    barcode: '6281001234573',
    strip: true,
  );
  await med('غلوكوفاج 850', 'Metformin', 'Merck', 1.9, strips: 3, per: 10, barcode: '6281001234574', min: 5);
  final vitc = await med('فيتامين C فوار', 'Ascorbic acid', 'Bayer', 2.75, form: 'فوار', barcode: '6281001234575');

  final sup1 = await s.suppliers.save(actor: owner, name: 'مستودع النور للأدوية', phone: '0944 111 222');
  final sup2 = await s.suppliers.save(actor: owner, name: 'مستودع الحكمة', phone: '0933 555 777');

  DateTime m(int months) => DateTime(now.year, now.month + months, 28);
  await s.purchases.create(
    actor: owner,
    supplier: sup1,
    invoiceNumber: 'N-1021',
    lines: [
      PurchaseLine(
        panadol,
        quantityBoxes: 20,
        bonusBoxes: 2,
        costUsdPerBox: 1.4,
        expiryDate: m(18),
        batchNumber: 'P2301',
      ),
      PurchaseLine(sitamol, quantityBoxes: 30, costUsdPerBox: 0.5, expiryDate: m(2), batchNumber: 'S118'),
      PurchaseLine(augmentin, quantityBoxes: 10, costUsdPerBox: 4.9, expiryDate: m(12)),
      PurchaseLine(brufen, quantityBoxes: 12, costUsdPerBox: 1.1, expiryDate: m(20)),
    ],
    paidAmount: 50,
  );
  await s.purchases.create(
    actor: owner,
    supplier: sup2,
    invoiceNumber: 'H-77',
    lines: [
      PurchaseLine(ventolin, quantityBoxes: 1, costUsdPerBox: 3.2, expiryDate: m(9)),
      PurchaseLine(zyrtec, quantityBoxes: 8, costUsdPerBox: 2.2, expiryDate: m(1)),
      PurchaseLine(omep, quantityBoxes: 15, costUsdPerBox: 1.6, expiryDate: m(24)),
      PurchaseLine(vitc, quantityBoxes: 10, costUsdPerBox: 1.9, expiryDate: m(-1)),
    ],
  );

  final c1 = await s.customers.save(actor: owner, name: 'أبو محمد الحلبي', phone: '0988 123 456');
  await s.customers.save(actor: owner, name: 'أم خالد', phone: '0955 987 654');

  final shift = await s.shifts.open(user: owner, openingSyp: 5000);
  final r = s.settings.rounding;
  await s.sales.checkout(
    actor: owner,
    shift: shift,
    lines: [
      CartLine(panadol),
      CartLine(brufen, unit: SaleUnit.strip, quantity: 2),
    ],
    payment: const PaymentInput(paidSyp: 1000),
    rate: 150,
    rounding: r,
  );
  await s.sales.checkout(
    actor: owner,
    shift: shift,
    lines: [CartLine(augmentin), CartLine(omep)],
    payment: PaymentInput(paidSyp: 500, customer: c1),
    rate: 150,
    rounding: r,
  );
  await s.sales.checkout(
    actor: owner,
    shift: shift,
    lines: [CartLine(ventolin)],
    payment: const PaymentInput(paidUsd: 5),
    rate: 150,
    rounding: r,
  );
  await s.shifts.manualMovement(
    user: owner,
    shift: shift,
    type: CashTypes.expense,
    currency: currencySyp,
    amount: 300,
    note: 'ضيافة',
  );
}
