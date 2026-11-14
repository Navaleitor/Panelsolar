import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

void main() {
  group('Perfil de horizonte', () {
    final h = HorizonProfile([
      (azimuth: 90, elevation: 10),
      (azimuth: 270, elevation: 2),
      (azimuth: -180, elevation: 0),
    ]);

    test('interpola linealmente y de forma circular', () {
      expect(h.points.first.azimuth, 90);
      expect(h.elevationAt(90), 10);
      expect(h.elevationAt(135), closeTo(5, 1e-9));
      expect(h.elevationAt(180), closeTo(0, 1e-9));
      expect(h.elevationAt(225), closeTo(1, 1e-9));
      expect(h.elevationAt(45), closeTo(8, 1e-9));
      expect(h.elevationAt(315), closeTo(4, 1e-9));
      expect(h.elevationAt(-45), closeTo(4, 1e-9));
    });

    test('bloquea si el Sol está por debajo', () {
      expect(h.blocks(5, 90), isTrue);
      expect(h.blocks(15, 90), isFalse);
      expect(HorizonProfile.flat().elevationAt(123), 0);
    });

    test('perfil vacío es error', () {
      expect(() => HorizonProfile([]), throwsArgumentError);
    });

    test('un último punto con azimut 360 cierra el círculo', () {
      final p = HorizonProfile([
        (azimuth: 10, elevation: 4),
        (azimuth: 350, elevation: 2),
      ]);
      expect(p.elevationAt(355), closeTo(2.5, 1e-9));
      expect(p.elevationAt(5), closeTo(3.5, 1e-9));
    });
  });

  group('Agregador mensual', () {
    test('promedia meses completos e ignora los incompletos', () {
      final agg = MonthlyAggregator();
      // Enero 2021 y 2022 completos (1 por hora); 3 horas de dic-2020.
      for (final year in [2021, 2022]) {
        for (var h = 0; h < 31 * 24; h++) {
          agg.add(
            DateTime.utc(year).add(Duration(hours: h)),
            year == 2021 ? 1 : 3,
          );
        }
      }
      for (var h = 0; h < 3; h++) {
        agg.add(DateTime.utc(2020, 12, 31, 20 + h), 100);
      }
      agg.add(DateTime.utc(2021, 2), double.nan);
      final m = agg.typicalMonthlySums();
      expect(m[0], closeTo(2 * 744, 1e-9));
      expect(m[11].isNaN, isTrue);
      expect(agg.typicalMonthlyMeans()[0], closeTo(2, 1e-12));
      expect(agg.completeMonthKeys, [202101, 202201]);
      expect(agg.sumOf(202012), 300);
      expect(agg.minOf(202101), 1);
      expect(agg.maxOf(202201), 3);
      expect(agg.completeYearSums(), isEmpty);
    });

    test('suma anual de años completos', () {
      final agg = MonthlyAggregator(stepHours: 24);
      for (var d = 0; d < 365; d++) {
        agg.add(DateTime.utc(2023).add(Duration(days: d)), 1);
      }
      expect(agg.completeYearSums(), {2023: 365});
    });
  });
}
