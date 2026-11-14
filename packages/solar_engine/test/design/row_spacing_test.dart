import 'dart:math' as math;

import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

void main() {
  group('Separación entre filas (B.6 punto 11)', () {
    test('borde de 1 m con el Sol al frente a 45° → 1 m', () {
      expect(
        RowSpacing.shadowAlongRow(
          heightM: 1,
          sunElevationDeg: 45,
          sunAzimuthDeg: 180,
          arrayAzimuthDeg: 180,
        ),
        closeTo(1, 1e-12),
      );
    });

    test('Sol a 45° de lado: L = h·cos 45°/tan α', () {
      expect(
        RowSpacing.shadowAlongRow(
          heightM: 1,
          sunElevationDeg: 45,
          sunAzimuthDeg: 135,
          arrayAzimuthDeg: 180,
        ),
        closeTo(math.sqrt(0.5), 1e-12),
      );
      expect(
        RowSpacing.shadowAlongRow(
          heightM: 1,
          sunElevationDeg: 45,
          sunAzimuthDeg: 0,
          arrayAzimuthDeg: 180,
        ),
        0,
      );
      expect(
        RowSpacing.shadowAlongRow(
          heightM: 1,
          sunElevationDeg: 0,
          sunAzimuthDeg: 180,
          arrayAzimuthDeg: 180,
        ),
        double.infinity,
      );
    });

    test('Monterrey, panel de 2 m a 25°: caso de libro a las 9 h solar', () {
      // Cálculo a mano (Cooper): δ = −23.45°, ω = −45°, φ = 25.67°
      // sin α = sin φ sin δ + cos φ cos δ cos ω → α = 24.33°
      // azimut 134.6° → L = 0.845·cos(45.4°)/tan(24.33°) = 1.31 m.
      const site = Site(latitude: 25.67, longitude: -100.31, elevation: 540);
      final r = RowSpacing.compute(
        site: site,
        slopeLengthM: 2,
        tiltDeg: 25,
        arrayAzimuthDeg: 180,
      );
      expect(r.panelHeightM, closeTo(2 * math.sin(25 * math.pi / 180), 1e-9));
      expect(r.gapM, closeTo(1.31, 0.03));
      expect(r.worstSunElevationDeg, closeTo(24.3, 0.4));
      expect(
        r.pitchM,
        closeTo(2 * math.cos(25 * math.pi / 180) + r.gapM, 1e-9),
      );
      expect(r.groundCoverageRatio, closeTo(2 / r.pitchM, 1e-12));
    });

    test('en el hemisferio sur se usa el 21 de junio y mira al norte', () {
      const site = Site(latitude: -33.87, longitude: 151.21);
      final r = RowSpacing.compute(
        site: site,
        slopeLengthM: 2,
        tiltDeg: 30,
        arrayAzimuthDeg: 0,
      );
      expect(r.gapM, greaterThan(1.5));
      expect(r.gapM, lessThan(4));
    });

    test('mediodía solar cerca de las 12 − lon/15 h UTC', () {
      const site = Site(latitude: 0, longitude: 0);
      final noon = RowSpacing.solarNoonUtc(site, DateTime.utc(2026, 3, 20));
      // Ecuación del tiempo ≈ −7.5 min en esa fecha.
      expect(noon.hour * 60 + noon.minute, closeTo(727, 2));
    });
  });
}
