import 'package:geo_kit/src/geometry/polygon_metrics.dart';
import 'package:geo_kit/src/geometry/vec2.dart';

/// Operaciones con polígonos: envolvente convexa, retiro hacia adentro,
/// división por una diagonal y franjas.
/// Ficha: docs/formulas/16-poligonos-del-techo.md
abstract final class PolygonOps {
  /// Envolvente convexa (cadena monótona de Andrew), antihoraria.
  static List<Vec2> convexHull(Iterable<Vec2> points) {
    final pts = points.toSet().toList()
      ..sort((a, b) => a.x != b.x ? a.x.compareTo(b.x) : a.y.compareTo(b.y));
    if (pts.length < 3) return pts;
    final lower = <Vec2>[];
    for (final p in pts) {
      while (lower.length >= 2 &&
          (lower[lower.length - 1] - lower[lower.length - 2]).cross(
                p - lower[lower.length - 2],
              ) <=
              0) {
        lower.removeLast();
      }
      lower.add(p);
    }
    final upper = <Vec2>[];
    for (final p in pts.reversed) {
      while (upper.length >= 2 &&
          (upper[upper.length - 1] - upper[upper.length - 2]).cross(
                p - upper[upper.length - 2],
              ) <=
              0) {
        upper.removeLast();
      }
      upper.add(p);
    }
    return [
      ...lower.sublist(0, lower.length - 1),
      ...upper.sublist(0, upper.length - 1),
    ];
  }

  /// Polígono con todos sus lados recorridos [distance] metros hacia
  /// adentro (retiro de borde). Cada lado se desplaza en paralelo y las
  /// esquinas se recalculan cruzando los lados vecinos.
  ///
  /// Devuelve `null` si el retiro "se come" el polígono (queda sin área o
  /// se invierte). Pensado para techos sin huecos ni picos muy agudos.
  static List<Vec2>? inset(List<Vec2> pts, double distance) {
    final n = pts.length;
    if (n < 3) return null;
    if (distance == 0) return List.of(pts);
    final ccw = PolygonMetrics.signedArea(pts) > 0;
    // Recta desplazada de cada lado: punto + dirección.
    final lines = <(Vec2, Vec2)>[];
    for (var i = 0; i < n; i++) {
      final a = pts[i];
      final b = pts[(i + 1) % n];
      final dir = (b - a).normalized;
      // Normal hacia adentro: izquierda si es antihorario.
      final inward = ccw ? Vec2(-dir.y, dir.x) : Vec2(dir.y, -dir.x);
      lines.add((a + inward * distance, dir));
    }
    final out = <Vec2>[];
    for (var i = 0; i < n; i++) {
      final prev = lines[(i - 1 + n) % n];
      final cur = lines[i];
      final hit = _intersectLines(prev.$1, prev.$2, cur.$1, cur.$2);
      out.add(hit ?? cur.$1);
    }
    final area = PolygonMetrics.signedArea(out);
    if (area == 0 || (area > 0) != ccw || !PolygonMetrics.isSimple(out)) {
      return null;
    }
    // Si algún lado cambió de sentido, el retiro es mayor que el polígono.
    for (var i = 0; i < n; i++) {
      final before = pts[(i + 1) % n] - pts[i];
      final after = out[(i + 1) % n] - out[i];
      if (before.dot(after) <= 0) return null;
    }
    return out;
  }

  static Vec2? _intersectLines(Vec2 p, Vec2 r, Vec2 q, Vec2 s) {
    final denom = r.cross(s);
    if (denom.abs() < 1e-12) return null;
    final t = (q - p).cross(s) / denom;
    return p + r * t;
  }

  /// Divide el polígono por la diagonal que une los vértices [i] y [j].
  /// Devuelve las dos partes o `null` si la diagonal no es válida (vértices
  /// vecinos o diagonal que sale del polígono).
  static (List<Vec2>, List<Vec2>)? splitByDiagonal(
    List<Vec2> pts,
    int i,
    int j,
  ) {
    final n = pts.length;
    if (i == j || i < 0 || j < 0 || i >= n || j >= n) return null;
    final a = i < j ? i : j;
    final b = i < j ? j : i;
    if (b - a == 1 || (a == 0 && b == n - 1)) return null;
    // La diagonal no debe cruzar ningún lado y su punto medio debe estar
    // dentro del polígono.
    for (var k = 0; k < n; k++) {
      final k2 = (k + 1) % n;
      if (k == a || k == b || k2 == a || k2 == b) continue;
      if (PolygonMetrics.segmentsIntersect(pts[a], pts[b], pts[k], pts[k2])) {
        return null;
      }
    }
    final mid = (pts[a] + pts[b]) * 0.5;
    if (!PolygonMetrics.contains(pts, mid)) return null;
    return (
      pts.sublist(a, b + 1),
      [...pts.sublist(b), ...pts.sublist(0, a + 1)],
    );
  }

  /// Franja (rectángulo) de ancho [width] centrada en el segmento
  /// [start]–[end]: pasillos de mantenimiento y pretiles.
  static List<Vec2> strip(Vec2 start, Vec2 end, double width) {
    final dir = (end - start).normalized;
    final half = Vec2(-dir.y, dir.x) * (width / 2);
    return [start - half, end - half, end + half, start + half];
  }
}
