import '../data/database.dart';
import 'money.dart';

/// وحدات البيع: علبة، شريط (ظرف)، حبة
enum SaleUnit { box, strip, unit }

extension MedicineUnits on Medicine {
  int get _strips => stripsPerBox < 1 ? 1 : stripsPerBox;
  int get _perStrip => unitsPerStrip < 1 ? 1 : unitsPerStrip;

  /// عدد أصغر وحدة في العلبة
  int get basePerBox => _strips * _perStrip;

  int basePer(SaleUnit u) {
    switch (u) {
      case SaleUnit.box:
        return basePerBox;
      case SaleUnit.strip:
        return _perStrip;
      case SaleUnit.unit:
        return 1;
    }
  }

  String unitLabel(SaleUnit u) {
    switch (u) {
      case SaleUnit.box:
        return boxName;
      case SaleUnit.strip:
        return stripName;
      case SaleUnit.unit:
        return unitName;
    }
  }

  /// الوحدات المسموح بيعها لهذا الدواء
  List<SaleUnit> get sellableUnits => [
        SaleUnit.box,
        if (allowStripSale && _strips > 1) SaleUnit.strip,
        if (allowUnitSale && basePerBox > 1) SaleUnit.unit,
      ];

  /// سعر الوحدة بالدولار
  double priceUsdFor(SaleUnit u) {
    switch (u) {
      case SaleUnit.box:
        return priceUsd;
      case SaleUnit.strip:
        return stripPriceUsd ?? roundTo(priceUsd / _strips, 6);
      case SaleUnit.unit:
        return unitPriceUsd ?? roundTo(priceUsd / basePerBox, 6);
    }
  }

  /// وصف الكمية بالعلب والأشرطة والحبات، مثال: "3 علبة + 2 ظرف"
  String describeQty(int base) {
    final neg = base < 0;
    var b = base.abs();
    final boxes = b ~/ basePerBox;
    b -= boxes * basePerBox;
    final strips = b ~/ _perStrip;
    b -= strips * _perStrip;
    final parts = <String>[
      if (boxes > 0) '$boxes $boxName',
      if (strips > 0) '$strips $stripName',
      if (b > 0) '$b $unitName',
    ];
    if (parts.isEmpty) return '0';
    return (neg ? '-' : '') + parts.join(' + ');
  }

  double boxesOf(int base) => base / basePerBox;

  /// تكلفة كمية (بأصغر وحدة) من دفعة معينة
  double costOf(int base, double costUsdPerBox) =>
      roundTo(costUsdPerBox * base / basePerBox, 6);
}
