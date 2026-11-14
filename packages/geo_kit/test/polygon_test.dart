import 'package:geo_kit/geo_kit.dart';
import 'package:test/test.dart';

void main() {
  const rect = [Vec2.zero, Vec2(10, 0), Vec2(10, 8), Vec2(0, 8)];
  // Forma de "L": 10×8 menos un cuadro de 4×4 en la esquina noreste.
  const ell = [
    Vec2.zero,
    Vec2(10, 0),
    Vec2(10, 4),
    Vec2(6, 4),
    Vec2(6, 8),
    Vec2(0, 8),
  ];

  group('PolygonMetrics', () {
    test('rectángulo 10 × 8: lados, perímetro, área y ángulos', () {
      expect(PolygonMetrics.sideLengths(rect), [10, 8, 10, 8]);
      expect(PolygonMetrics.perimeter(rect), 36);
      expect(PolygonMetrics.area(rect), 80);
      expect(
        PolygonMetrics.interiorAngles(rect),
        everyElement(closeTo(90, 1e-9)),
      );
      expect(PolygonMetrics.centroid(rect), const Vec2(5, 4));
    });

    test('el sentido del recorrido no cambia el área ni los ángulos', () {
      final cw = rect.reversed.toList();
      expect(PolygonMetrics.signedArea(cw), -80);
      expect(PolygonMetrics.area(cw), 80);
      expect(
        PolygonMetrics.interiorAngles(cw),
        everyElement(closeTo(90, 1e-9)),
      );
    });

    test('forma de L: 64 m² y una esquina de 270°', () {
      expect(PolygonMetrics.area(ell), 64);
      final angles = PolygonMetrics.interiorAngles(ell);
      expect(angles[3], closeTo(270, 1e-9));
      // La suma de ángulos interiores es (n − 2)·180.
      expect(angles.reduce((a, b) => a + b), closeTo(720, 1e-9));
    });

    test('triángulo 3-4-5', () {
      const tri = [Vec2.zero, Vec2(4, 0), Vec2(0, 3)];
      expect(PolygonMetrics.sideLengths(tri), [4, 5, 3]);
      expect(PolygonMetrics.area(tri), 6);
      final a = PolygonMetrics.interiorAngles(tri);
      expect(a[0], closeTo(90, 1e-9));
      expect(a[1], closeTo(36.8699, 1e-4));
    });

    test('punto dentro / fuera y polígono que se cruza', () {
      expect(PolygonMetrics.contains(ell, const Vec2(2, 6)), isTrue);
      expect(PolygonMetrics.contains(ell, const Vec2(8, 6)), isFalse);
      expect(PolygonMetrics.isSimple(rect), isTrue);
      const bowTie = [Vec2.zero, Vec2(4, 4), Vec2(4, 0), Vec2(0, 4)];
      expect(PolygonMetrics.isSimple(bowTie), isFalse);
    });
  });

  group('PolygonOps', () {
    test('envolvente convexa ignora puntos interiores', () {
      final hull = PolygonOps.convexHull([...rect, const Vec2(5, 5)]);
      expect(hull, hasLength(4));
      expect(PolygonMetrics.area(hull), 80);
    });

    test('retiro de 0.5 m en 10 × 8 → 9 × 7', () {
      final inner = PolygonOps.inset(rect, 0.5)!;
      expect(PolygonMetrics.area(inner), closeTo(63, 1e-9));
      expect(inner.first.x, closeTo(0.5, 1e-9));
      expect(inner.first.y, closeTo(0.5, 1e-9));
      // Igual en sentido horario.
      final cw = PolygonOps.inset(rect.reversed.toList(), 0.5)!;
      expect(PolygonMetrics.area(cw), closeTo(63, 1e-9));
    });

    test('retiro en forma de L', () {
      final inner = PolygonOps.inset(ell, 1)!;
      // L de 8×6 menos 4×4 de muesca = 48 − 16 = 32... se calcula a mano:
      // exterior 1..9 × 1..7 (8×6=48) menos la muesca 5..9 × 3..7 (4×4=16).
      expect(PolygonMetrics.area(inner), closeTo(32, 1e-9));
    });

    test('retiro mayor que el techo devuelve null', () {
      expect(PolygonOps.inset(rect, 4.5), isNull);
    });

    test('dividir por diagonal conserva el área', () {
      final parts = PolygonOps.splitByDiagonal(rect, 0, 2)!;
      expect(PolygonMetrics.area(parts.$1), 40);
      expect(PolygonMetrics.area(parts.$2), 40);
      expect(PolygonOps.splitByDiagonal(rect, 0, 1), isNull);
      // En la L, la diagonal 1→3 queda adentro; la 2→4 sale del polígono.
      expect(PolygonOps.splitByDiagonal(ell, 2, 4), isNull);
      final l = PolygonOps.splitByDiagonal(ell, 0, 3)!;
      expect(
        PolygonMetrics.area(l.$1) + PolygonMetrics.area(l.$2),
        closeTo(64, 1e-9),
      );
    });

    test('franja de pasillo 6 m × 0.6 m', () {
      final s = PolygonOps.strip(const Vec2(0, 1), const Vec2(6, 1), 0.6);
      expect(PolygonMetrics.area(s), closeTo(3.6, 1e-9));
    });
  });
}
