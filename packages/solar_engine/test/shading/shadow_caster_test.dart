import 'dart:math' as math;

import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

/// Sol a mediodía solar (máxima elevación) y en el instante con ángulo
/// `hoursBeforeNoon` horas antes del mediodía, buscando minuto a minuto.
({double azimuth, double elevation}) _sunAt(
  Site site,
  int month,
  int day, {
  double hoursBeforeNoon = 0,
}) {
  var best = (azimuth: 0.0, elevation: -90.0);
  var bestHour = 0.0;
  for (var m = 0; m < 24 * 60; m++) {
    final s = SunSamples.at(site, 2026, month, day, m / 60);
    if (s.elevation > best.elevation) {
      best = s;
      bestHour = m / 60;
    }
  }
  if (hoursBeforeNoon == 0) return best;
  return SunSamples.at(site, 2026, month, day, bestHour - hoursBeforeNoon);
}

void main() {
  group('ShadowCaster: casos conocidos (B.7.1)', () {
    test('objeto de 1 m con el Sol a 45° → sombra de 1 m', () {
      expect(ShadowCaster.shadowLength(1, 45), closeTo(1, 1e-12));
      // Sol al sur: la sombra cae 1 m al norte.
      final d = ShadowCaster.offset(
        heightM: 1,
        sunAzimuthDeg: 180,
        sunElevationDeg: 45,
      )!;
      expect(d.x, closeTo(0, 1e-12));
      expect(d.y, closeTo(1, 1e-12));
    });

    test('Sol en el horizonte o abajo: sin sombra calculable', () {
      expect(ShadowCaster.shadowLength(1, 0), double.infinity);
      expect(
        ShadowCaster.offset(heightM: 1, sunAzimuthDeg: 90, sunElevationDeg: -2),
        isNull,
      );
    });

    const monterrey = Site(
      latitude: 25.69,
      longitude: -100.32,
      elevation: 540,
      utcOffsetHours: -6,
    );
    const tank = 1.7; // tinaco de 1.7 m con base

    test('Monterrey, 21 dic 12:00 solar: 40.9° → 1.97 m al norte', () {
      final sun = _sunAt(monterrey, 12, 21);
      expect(sun.elevation, closeTo(40.9, 0.15));
      final d = ShadowCaster.offset(
        heightM: tank,
        sunAzimuthDeg: sun.azimuth,
        sunElevationDeg: sun.elevation,
      )!;
      expect(ShadowCaster.length(d), closeTo(1.97, 0.02));
      expect(d.y, greaterThan(0)); // hacia el norte
      expect(d.x.abs(), lessThan(0.02));
    });

    test('Monterrey, 21 dic 9:00 solar: 24.3° → 3.77 m al noroeste', () {
      final sun = _sunAt(monterrey, 12, 21, hoursBeforeNoon: 3);
      expect(sun.elevation, closeTo(24.3, 0.3));
      final d = ShadowCaster.offset(
        heightM: tank,
        sunAzimuthDeg: sun.azimuth,
        sunElevationDeg: sun.elevation,
      )!;
      expect(ShadowCaster.length(d), closeTo(3.77, 0.06));
      expect(d.x, lessThan(0)); // oeste
      expect(d.y, greaterThan(0)); // norte
    });

    test('Monterrey, 21 jun 12:00 solar: 87.8° → 0.07 m', () {
      final sun = _sunAt(monterrey, 6, 21);
      expect(sun.elevation, closeTo(87.8, 0.15));
      expect(
        ShadowCaster.shadowLength(tank, sun.elevation),
        closeTo(0.07, 0.01),
      );
    });

    test('ecuador, mediodía de equinoccio → sombra casi nula', () {
      const quito = Site(latitude: 0, longitude: -78.5, utcOffsetHours: -5);
      final sun = _sunAt(quito, 3, 20);
      expect(sun.elevation, greaterThan(89.3));
      expect(ShadowCaster.shadowLength(1, sun.elevation), lessThan(0.012));
    });
  });

  group('ShadowCaster sobre techo inclinado', () {
    test(
      'plano de 30° al sur, Sol al sur a 60°: sombra 0.433·h cuesta arriba',
      () {
        const surface = RoofSurface(tiltDeg: 30);
        final d = ShadowCaster.offset(
          heightM: 1,
          sunAzimuthDeg: 180,
          sunElevationDeg: 60,
          surface: surface,
        )!;
        expect(d.y, closeTo(0.4330, 1e-4));
        // El punto de la sombra cae sobre el plano.
        final zTop = 1 - (d.y / math.cos(math.pi / 3)) * math.sin(math.pi / 3);
        expect(zTop, closeTo(surface.heightAt(d), 1e-9));
      },
    );

    test('Sol detrás del plano → null', () {
      const surface = RoofSurface(tiltDeg: 40);
      expect(
        ShadowCaster.offset(
          heightM: 1,
          sunAzimuthDeg: 0,
          sunElevationDeg: 20,
          surface: surface,
        ),
        isNull,
      );
    });

    test('polígono de sombra de una caja 1 × 1 × 1 con Sol a 45° al sur', () {
      const box = ShadingObstacle(
        footprint: [(x: 0, y: 0), (x: 1, y: 0), (x: 1, y: 1), (x: 0, y: 1)],
        heightM: 1,
      );
      final sh = ShadowCaster.shadowPolygon(
        box,
        sunAzimuthDeg: 180,
        sunElevationDeg: 45,
      )!;
      // Huella + 1 m al norte = 1 × 2 m.
      expect(PlaneGeometry.area(sh), closeTo(2, 1e-9));
      final list = ShadowCaster.sceneShadows(
        const [box],
        sunAzimuthDeg: 180,
        sunElevationDeg: -5,
      );
      expect(list, isEmpty);
    });
  });
}
