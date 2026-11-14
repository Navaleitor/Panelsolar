import 'dart:math' as math;

import 'package:geo_kit/geo_kit.dart';
import 'package:test/test.dart';

void main() {
  group('WorldMagneticModel (WMM2025)', () {
    // Valores de referencia redondeados de mapas de declinación de NOAA
    // para 2026 (tolerancia ±1°: el modelo cambia ~0.1°/año).
    final cases = <(String, double, double, double)>[
      ('Boulder', 40, -105, 7.6),
      ('Londres', 51.5, -0.12, 1.1),
      ('Sídney', -33.87, 151.21, 12.8),
      ('Phoenix', 33.45, -112.07, 9.7),
      ('Monterrey', 25.69, -100.32, 4.4),
      ('Bogotá', 4.71, -74.07, -8.7),
    ];
    for (final (name, lat, lon, expected) in cases) {
      test('declinación en $name ≈ $expected°', () {
        final d = WorldMagneticModel.declination(
          latitude: lat,
          longitude: lon,
          year: 2026,
        );
        expect(d, closeTo(expected, 1));
      });
    }

    test('intensidad total entre 22 000 y 67 000 nT en todo el mundo', () {
      for (var lat = -80; lat <= 80; lat += 20) {
        for (var lon = -180; lon < 180; lon += 30) {
          final f = WorldMagneticModel.field(
            latitude: lat.toDouble(),
            longitude: lon.toDouble(),
            year: 2027,
          );
          final total = math.sqrt(
            f.northNt * f.northNt + f.eastNt * f.eastNt + f.downNt * f.downNt,
          );
          expect(total, inInclusiveRange(22000, 67000));
        }
      }
    });

    test(
      'el campo apunta hacia abajo en el norte y hacia arriba en el sur',
      () {
        final n = WorldMagneticModel.field(
          latitude: 45,
          longitude: 0,
          year: 2025,
        );
        final s = WorldMagneticModel.field(
          latitude: -45,
          longitude: 0,
          year: 2025,
        );
        expect(n.downNt, greaterThan(0));
        expect(s.downNt, lessThan(0));
      },
    );

    test('año decimal y periodo de validez', () {
      expect(WorldMagneticModel.decimalYear(DateTime.utc(2026)), 2026);
      expect(
        WorldMagneticModel.decimalYear(DateTime.utc(2026, 7, 2, 12)),
        closeTo(2026.5, 0.001),
      );
      expect(WorldMagneticModel.isValidYear(2027), isTrue);
      expect(WorldMagneticModel.isValidYear(2031), isFalse);
    });
  });

  group('PhoneOrientation', () {
    test('teléfono plano → 0°; apoyado en techo de 30° → 30°', () {
      expect(
        PhoneOrientation.surfaceTiltDeg((x: 0, y: 0, z: 9.81)),
        closeTo(0, 1e-9),
      );
      const g = 9.81;
      expect(
        PhoneOrientation.surfaceTiltDeg((
          x: 0,
          y: g * math.sin(math.pi / 6),
          z: g * math.cos(math.pi / 6),
        )),
        closeTo(30, 1e-9),
      );
    });

    test('elevación de la cámara: vertical = 0°, inclinado hacia el cielo', () {
      // Teléfono vertical, la cámara mira al horizonte.
      expect(
        PhoneOrientation.elevationDeg((x: 0, y: 9.81, z: 0)),
        closeTo(0, 1e-9),
      );
      // Pantalla hacia abajo-atrás: la cámara mira 40° hacia arriba.
      const e = 40 * math.pi / 180;
      expect(
        PhoneOrientation.elevationDeg((
          x: 0,
          y: 9.81 * math.cos(e),
          z: -9.81 * math.sin(e),
        )),
        closeTo(40, 1e-9),
      );
    });

    test('brújula: teléfono plano con la punta al norte magnético → 0°', () {
      // Campo hacia el norte y hacia abajo (hemisferio norte).
      const mag = (x: 0.0, y: 25.0, z: -35.0);
      const flat = (x: 0.0, y: 0.0, z: 9.81);
      expect(PhoneOrientation.magneticAzimuthDeg(flat, mag), closeTo(0, 1e-9));
      // Girado: el norte queda a la derecha de la pantalla → la punta mira
      // al oeste (270°).
      const magRight = (x: 25.0, y: 0.0, z: -35.0);
      expect(
        PhoneOrientation.magneticAzimuthDeg(flat, magRight),
        closeTo(270, 1e-9),
      );
    });

    test('la brújula compensa la inclinación del teléfono', () {
      const mag = (x: 0.0, y: 25.0, z: -35.0);
      // Mismo campo y misma punta, pero el teléfono inclinado 20° de lado:
      // girar campo y gravedad juntos alrededor del eje y.
      const t = 20 * math.pi / 180;
      ({double x, double y, double z}) rotY(
        ({double x, double y, double z}) v,
      ) => (
        x: v.x * math.cos(t) + v.z * math.sin(t),
        y: v.y,
        z: -v.x * math.sin(t) + v.z * math.cos(t),
      );
      expect(
        PhoneOrientation.magneticAzimuthDeg(
          rotY((x: 0, y: 0, z: 9.81)),
          rotY(mag),
        ),
        closeTo(0, 1e-9),
      );
    });

    test('azimut verdadero = magnético + declinación', () {
      expect(PhoneOrientation.trueAzimuthDeg(358, 4.4), closeTo(2.4, 1e-9));
      expect(PhoneOrientation.trueAzimuthDeg(2, -8.7), closeTo(353.3, 1e-9));
    });

    test('altura por ángulo: 10 m × tan 30° + 1.5 m = 7.27 m', () {
      expect(
        PhoneOrientation.heightByAngle(distanceM: 10, angleDeg: 30),
        closeTo(7.2735, 1e-4),
      );
      expect(
        () => PhoneOrientation.heightByAngle(distanceM: 0, angleDeg: 30),
        throwsArgumentError,
      );
    });
  });
}
