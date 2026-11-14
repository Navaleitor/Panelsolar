import 'dart:math' as math;

import 'package:geo_kit/geo_kit.dart';
import 'package:test/test.dart';

void main() {
  group('ScaleCalibration', () {
    test('línea de 400 px que mide 10 m → 0.025 m/px', () {
      const line = MeasuredLine(Vec2(100, 100), Vec2(500, 100), 10);
      expect(ScaleCalibration.metersPerPixel(line), 0.025);
    });

    test('verificación: 3 % de diferencia', () {
      // 200 px × 0.025 = 5 m; la cinta dice 4.854 m → +3.0 %.
      const check = MeasuredLine(Vec2.zero, Vec2(0, 200), 4.854);
      expect(
        ScaleCalibration.verificationDifferencePercent(0.025, check),
        closeTo(3.0, 0.01),
      );
    });

    test('rechaza líneas cortas o medidas no positivas', () {
      expect(
        () => ScaleCalibration.metersPerPixel(
          const MeasuredLine(Vec2.zero, Vec2(5, 0), 1),
        ),
        throwsArgumentError,
      );
      expect(
        () => ScaleCalibration.metersPerPixel(
          const MeasuredLine(Vec2.zero, Vec2(100, 0), 0),
        ),
        throwsArgumentError,
      );
    });

    test('JSON de ida y vuelta', () {
      const line = MeasuredLine(Vec2(1, 2), Vec2(3, 4), 5);
      final back = MeasuredLine.fromJson(line.toJson());
      expect(back.start, line.start);
      expect(back.end, line.end);
      expect(back.lengthM, 5);
    });
  });

  group('ImageFrame', () {
    test('norte arriba: derecha = este, arriba = norte', () {
      const f = ImageFrame(metersPerPixel: 0.5, origin: Vec2(100, 100));
      final p = f.toLocal(const Vec2(120, 80));
      expect(p.x, closeTo(10, 1e-9));
      expect(p.y, closeTo(10, 1e-9));
    });

    test('norte a la derecha (90°): arriba de la imagen = oeste', () {
      const f = ImageFrame(metersPerPixel: 1, northAngleDeg: 90);
      final up = f.toLocal(const Vec2(0, -1));
      expect(up.x, closeTo(-1, 1e-9));
      expect(up.y, closeTo(0, 1e-9));
      final right = f.toLocal(const Vec2(1, 0));
      expect(right.y, closeTo(1, 1e-9));
    });

    test('toPixel deshace toLocal', () {
      const f = ImageFrame(
        metersPerPixel: 0.031,
        northAngleDeg: 37,
        origin: Vec2(400, 300),
      );
      const px = Vec2(123.4, 567.8);
      final back = f.toPixel(f.toLocal(px));
      expect(back.x, closeTo(px.x, 1e-9));
      expect(back.y, closeTo(px.y, 1e-9));
    });

    test('el giro no cambia distancias ni áreas', () {
      const pxRect = [Vec2.zero, Vec2(400, 0), Vec2(400, 320), Vec2(0, 320)];
      for (final north in [0.0, 25.0, 90.0, 213.0]) {
        final f = ImageFrame(metersPerPixel: 0.025, northAngleDeg: north);
        final local = pxRect.map(f.toLocal).toList();
        expect(PolygonMetrics.area(local), closeTo(80, 1e-9));
      }
    });

    test('rumbo de una línea y norte desde la brújula', () {
      expect(ImageFrame.imageBearing(Vec2.zero, const Vec2(0, -1)), 0);
      expect(ImageFrame.imageBearing(Vec2.zero, const Vec2(1, 0)), 90);
      // Una línea horizontal en la imagen (rumbo 90°) que en sitio marca
      // azimut 120° → el norte está 330° (30° a la izquierda de arriba).
      expect(
        ImageFrame.northAngleFrom(lineImageBearingDeg: 90, trueAzimuthDeg: 120),
        330,
      );
      final f = ImageFrame(
        metersPerPixel: 1,
        northAngleDeg: ImageFrame.northAngleFrom(
          lineImageBearingDeg: 90,
          trueAzimuthDeg: 120,
        ),
      );
      final d = f.toLocal(const Vec2(1, 0));
      final az = math.atan2(d.x, d.y) * 180 / math.pi;
      expect(az, closeTo(120, 1e-9));
    });
  });

  group('Snapping', () {
    test('se pega al vértice cercano', () {
      final r = Snapping.snap(
        candidate: const Vec2(10.2, 0.1),
        path: const [Vec2.zero],
        vertices: const [Vec2(10, 0)],
        vertexRadius: 0.5,
      );
      expect(r.kind, SnapKind.vertex);
      expect(r.point, const Vec2(10, 0));
    });

    test('corrige a 90° respecto al lado anterior', () {
      final r = Snapping.snap(
        candidate: const Vec2(10.4, 8),
        path: const [Vec2.zero, Vec2(10, 0)],
      );
      expect(r.kind, SnapKind.rightAngle);
      expect(r.point.x, closeTo(10, 1e-9));
      expect(r.point.y, closeTo(8.01, 0.01));
    });

    test('con lado anterior girado también da 90°', () {
      final r = Snapping.snap(
        candidate: const Vec2(-1.2, 7),
        path: const [Vec2.zero, Vec2(3, 4)],
      );
      final prev = const Vec2(3, 4) - Vec2.zero;
      final next = r.point - const Vec2(3, 4);
      expect(prev.dot(next), closeTo(0, 1e-9));
    });

    test('no corrige si el ángulo está lejos de 90°', () {
      final r = Snapping.snap(
        candidate: const Vec2(15, 5),
        path: const [Vec2.zero, Vec2(10, 0)],
      );
      expect(r.kind, SnapKind.none);
    });
  });
}
