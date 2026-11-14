import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

void main() {
  group('POA', () {
    test('panel horizontal: POA = GHI cuando DNI·cos θz + DHI = GHI', () {
      final poa = planeOfArrayIrradiance(
        surfaceTilt: 0,
        surfaceAzimuth: 180,
        solarZenith: 30,
        solarAzimuth: 180,
        dni: 800,
        ghi: 800 * cosd(30) + 100,
        dhi: 100,
        dniExtra: 1361,
        airmass: relativeAirmass(30),
        albedo: 0.2,
        model: TranspositionModel.hayDavies,
      );
      expect(poa.global, closeTo(800 * cosd(30) + 100, 1e-6));
      expect(poa.groundDiffuse, closeTo(0, 1e-9));
    });

    test('de noche no hay directa ni difusa del cielo', () {
      for (final model in TranspositionModel.values) {
        final poa = planeOfArrayIrradiance(
          surfaceTilt: 30,
          surfaceAzimuth: 180,
          solarZenith: 95,
          solarAzimuth: 80,
          dni: 10,
          ghi: 5,
          dhi: 5,
          dniExtra: 1361,
          airmass: relativeAirmass(95),
          albedo: 0.2,
          model: model,
        );
        expect(poa.direct, 0);
        expect(poa.skyDiffuse, 0);
        expect(poa.groundDiffuse, greaterThan(0));
      }
      expect(PoaIrradiance.zero.global, 0);
    });

    test('Perez sin difusa devuelve 0', () {
      expect(
        perezSkyDiffuse(
          surfaceTilt: 30,
          surfaceAzimuth: 180,
          dhi: 0,
          dni: 500,
          dniExtra: 1361,
          solarZenith: 30,
          solarAzimuth: 180,
          airmass: 1.15,
        ),
        0,
      );
    });

    test('Perez con cielo muy claro usa el último intervalo de ε', () {
      final v = perezSkyDiffuse(
        surfaceTilt: 30,
        surfaceAzimuth: 180,
        dhi: 40,
        dni: 950,
        dniExtra: 1361,
        solarZenith: 20,
        solarAzimuth: 180,
        airmass: relativeAirmass(20),
      );
      expect(v, greaterThan(40));
    });
  });

  group('Ángulo de incidencia', () {
    test('Sol perpendicular al panel', () {
      expect(angleOfIncidence(30, 180, 30, 180), closeTo(0, 1e-6));
      expect(aoiProjection(30, 180, 30, 180), closeTo(1, 1e-12));
    });

    test('Sol detrás del panel', () {
      expect(angleOfIncidence(90, 180, 60, 0), greaterThan(90));
    });
  });

  group('Atmósfera', () {
    test('extraterrestre horizontal', () {
      expect(extraterrestrialHorizontal(1, 0), extraterrestrialNormal(1));
      expect(extraterrestrialHorizontal(1, 100), 0);
    });

    test('masa de aire indefinida bajo el horizonte', () {
      expect(relativeAirmass(91).isNaN, isTrue);
      expect(relativeAirmass(0), closeTo(1, 1e-3));
    });

    test('día del año', () {
      expect(dayOfYear(DateTime.utc(2024)), 1);
      expect(dayOfYear(DateTime.utc(2024, 12, 31)), 366);
      expect(dayOfYear(DateTime.utc(2023, 12, 31, 23)), 365);
    });
  });

  group('Erbs', () {
    test('bajo 87° de cenit todo es difuso', () {
      final e = erbs(20, 88, 1361);
      expect(e.dni, 0);
      expect(e.dhi, 20);
    });
  });

  group('Ángulos', () {
    test('conversiones', () {
      expect(radToDeg(degToRad(123.4)), closeTo(123.4, 1e-12));
      expect(sind(30), closeTo(0.5, 1e-12));
    });
  });
}
