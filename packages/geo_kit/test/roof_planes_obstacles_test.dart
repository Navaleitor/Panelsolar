import 'package:geo_kit/geo_kit.dart';
import 'package:test/test.dart';

void main() {
  const rect = [Vec2.zero, Vec2(10, 0), Vec2(10, 8), Vec2(0, 8)];

  group('PlaneOrientation', () {
    test('alero al sur → el plano mira al sur (180°)', () {
      expect(PlaneOrientation.azimuthFromEdge(rect, 0), closeTo(180, 1e-9));
      expect(PlaneOrientation.azimuthFromEdge(rect, 1), closeTo(90, 1e-9));
      expect(PlaneOrientation.azimuthFromEdge(rect, 2), closeTo(0, 1e-9));
      expect(PlaneOrientation.azimuthFromEdge(rect, 3), closeTo(270, 1e-9));
    });

    test('igual con el polígono en sentido horario', () {
      final cw = rect.reversed.toList(); // lado 0: (0,8)→(10,8) = norte
      expect(PlaneOrientation.azimuthFromEdge(cw, 0), closeTo(0, 1e-9));
      expect(PlaneOrientation.azimuthFromEdge(cw, 2), closeTo(180, 1e-9));
    });

    test('área inclinada: 80 m² vistos desde arriba a 30° → 92.38 m²', () {
      expect(PlaneOrientation.slopedArea(80, 30), closeTo(92.376, 1e-3));
      expect(PlaneOrientation.slopedArea(80, 0), 80);
      expect(() => PlaneOrientation.slopedArea(80, 90), throwsArgumentError);
    });
  });

  group('Obstáculos', () {
    test('tinaco de 1100 L: 1.45 m + base 0.25 = 1.70 m', () {
      expect(ObstacleCatalog.waterTankHeight(1100), closeTo(1.70, 1e-9));
      expect(ObstacleCatalog.waterTankSize(800).liters, 750);
      expect(ObstacleCatalog.waterTankSizes.map((s) => s.liters), [
        450,
        750,
        1100,
        2500,
      ]);
    });

    test('hay valor típico para cada tipo de B.7.1', () {
      for (final t in ObstacleType.values) {
        expect(ObstacleCatalog.presets[t], isNotNull, reason: t.name);
        expect(ObstacleCatalog.presets[t]!.heightM, greaterThan(0));
      }
    });

    test('huellas: círculo, rectángulo girado, línea y polígono', () {
      final c = ObstacleFootprint.build(
        shape: ObstacleShape.circle,
        center: const Vec2(5, 5),
        widthM: 1.1,
      );
      expect(c, hasLength(ObstacleFootprint.circleSides));
      // Área de un 24-ágono inscrito ≈ 98.9 % del círculo.
      expect(PolygonMetrics.area(c), closeTo(0.9503 * 0.989, 0.002));

      final r = ObstacleFootprint.build(
        shape: ObstacleShape.rectangle,
        center: const Vec2(1, 1),
        widthM: 2.5,
        depthM: 3,
        rotationDeg: 30,
      );
      expect(PolygonMetrics.area(r), closeTo(7.5, 1e-9));
      expect(PolygonMetrics.centroid(r).x, closeTo(1, 1e-9));

      final l = ObstacleFootprint.build(
        shape: ObstacleShape.line,
        widthM: 0.15,
        points: const [Vec2.zero, Vec2(10, 0)],
      );
      expect(PolygonMetrics.area(l), closeTo(1.5, 1e-9));
      expect(
        () => ObstacleFootprint.build(shape: ObstacleShape.polygon),
        throwsArgumentError,
      );
    });
  });

  group('TapeSketch (modo sin imagen)', () {
    test('rectángulo 10 × 8 con esquinas a 90° cierra exacto', () {
      final r = TapeSketch.fromSides(const [
        (lengthM: 10, turnDeg: 90),
        (lengthM: 8, turnDeg: 90),
        (lengthM: 10, turnDeg: 90),
        (lengthM: 8, turnDeg: 90),
      ]);
      expect(r.closureErrorM, closeTo(0, 1e-9));
      expect(PolygonMetrics.area(r.polygon), closeTo(80, 1e-9));
    });

    test('medidas que no cierran reportan el error', () {
      final r = TapeSketch.fromSides(const [
        (lengthM: 10, turnDeg: 90),
        (lengthM: 8, turnDeg: 90),
        (lengthM: 9.8, turnDeg: 90),
        (lengthM: 8, turnDeg: 90),
      ]);
      expect(r.closureErrorM, closeTo(0.2, 1e-9));
    });

    test('forma de L con una esquina hacia adentro (−90°)', () {
      final r = TapeSketch.fromSides(const [
        (lengthM: 10, turnDeg: 90),
        (lengthM: 4, turnDeg: 90),
        (lengthM: 4, turnDeg: -90),
        (lengthM: 4, turnDeg: 90),
        (lengthM: 6, turnDeg: 90),
        (lengthM: 8, turnDeg: 90),
      ]);
      expect(r.closureErrorM, closeTo(0, 1e-9));
      expect(PolygonMetrics.area(r.polygon), closeTo(64, 1e-9));
    });

    test('rectángulo directo', () {
      expect(PolygonMetrics.area(TapeSketch.rectangle(6, 4)), 24);
    });
  });
}
