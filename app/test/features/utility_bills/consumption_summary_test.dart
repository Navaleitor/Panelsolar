import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/utility_bills/domain/consumption_summary.dart';

BillPeriodData bill(DateTime start, DateTime end, double kwh, [int? cents]) =>
    BillPeriodData(start: start, end: end, energyKwh: kwh, amountCents: cents);

void main() {
  test('sin recibos no hay resumen', () {
    expect(ConsumptionSummary.fromBills(const []), isNull);
  });

  test('6 recibos bimestrales de 600 kWh ≈ 3 600 kWh/año', () {
    final bills = [
      for (var i = 0; i < 6; i++)
        bill(
          DateTime.utc(2025, 1 + 2 * i),
          DateTime.utc(2025, 3 + 2 * i).subtract(const Duration(days: 1)),
          600,
          150000,
        ),
    ];
    final s = ConsumptionSummary.fromBills(bills)!;
    expect(s.billCount, 6);
    expect(s.coveredDays, 365);
    expect(s.coversFullYear, isTrue);
    expect(s.annualKwh, closeTo(3600, 0.01));
    expect(s.avgMonthlyKwh, closeTo(300, 0.01));
    expect(s.avgDailyKwh, closeTo(9.863, 0.001));
    expect(s.annualAmountCents, 900000);
  });

  test('mezcla mensual y bimestral normalizando por días', () {
    final s = ConsumptionSummary.fromBills([
      bill(DateTime.utc(2026), DateTime.utc(2026, 1, 31), 310), // 31 días
      bill(DateTime.utc(2026, 2), DateTime.utc(2026, 3, 31), 590), // 59 días
    ])!;
    expect(s.coveredDays, 90);
    expect(s.annualKwh, closeTo(900 / 90 * 365, 1e-9));
    expect(s.coversFullYear, isFalse);
    expect(s.annualAmountCents, isNull);
  });

  test('solo usa el último año de recibos', () {
    final s = ConsumptionSummary.fromBills([
      bill(DateTime.utc(2020), DateTime.utc(2020, 1, 31), 99999),
      bill(DateTime.utc(2026), DateTime.utc(2026, 1, 31), 310),
    ])!;
    expect(s.billCount, 1);
    expect(s.annualKwh, closeTo(310 / 31 * 365, 1e-9));
  });

  test('el gasto anual usa solo los recibos con importe', () {
    final s = ConsumptionSummary.fromBills([
      bill(DateTime.utc(2026), DateTime.utc(2026, 1, 31), 300, 31000),
      bill(DateTime.utc(2026, 2), DateTime.utc(2026, 2, 28), 300),
    ])!;
    expect(s.annualAmountCents, 365000);
  });
}
