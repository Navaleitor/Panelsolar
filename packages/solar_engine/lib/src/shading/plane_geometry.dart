/// Punto en coordenadas locales del sitio (metros): x = este, y = norte.
typedef XY = ({double x, double y});

/// Geometría plana mínima para el sombreado (el motor no depende de
/// `geo_kit`, así que repite aquí lo indispensable).
abstract final class PlaneGeometry {
  /// `true` si [p] está dentro del polígono [poly] (regla par-impar).
  static bool contains(List<XY> poly, XY p) {
    var inside = false;
    for (var i = 0, j = poly.length - 1; i < poly.length; j = i++) {
      final a = poly[i];
      final b = poly[j];
      if ((a.y > p.y) != (b.y > p.y) &&
          p.x < (b.x - a.x) * (p.y - a.y) / (b.y - a.y) + a.x) {
        inside = !inside;
      }
    }
    return inside;
  }

  /// Envolvente convexa (cadena monótona de Andrew), antihoraria.
  static List<XY> convexHull(Iterable<XY> points) {
    final pts = points.toSet().toList()
      ..sort((a, b) => a.x != b.x ? a.x.compareTo(b.x) : a.y.compareTo(b.y));
    if (pts.length < 3) return pts;
    double cross(XY o, XY a, XY b) =>
        (a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x);
    final lower = <XY>[];
    for (final p in pts) {
      while (lower.length >= 2 &&
          cross(lower[lower.length - 2], lower.last, p) <= 0) {
        lower.removeLast();
      }
      lower.add(p);
    }
    final upper = <XY>[];
    for (final p in pts.reversed) {
      while (upper.length >= 2 &&
          cross(upper[upper.length - 2], upper.last, p) <= 0) {
        upper.removeLast();
      }
      upper.add(p);
    }
    return [
      ...lower.sublist(0, lower.length - 1),
      ...upper.sublist(0, upper.length - 1),
    ];
  }

  /// Área (positiva) del polígono.
  static double area(List<XY> poly) {
    var s = 0.0;
    for (var i = 0; i < poly.length; i++) {
      final a = poly[i];
      final b = poly[(i + 1) % poly.length];
      s += a.x * b.y - a.y * b.x;
    }
    return (s / 2).abs();
  }

  /// Rectángulo que contiene al polígono: (minX, minY, maxX, maxY).
  static (double, double, double, double) bounds(List<XY> poly) {
    var minX = double.infinity;
    var minY = double.infinity;
    var maxX = double.negativeInfinity;
    var maxY = double.negativeInfinity;
    for (final p in poly) {
      if (p.x < minX) minX = p.x;
      if (p.y < minY) minY = p.y;
      if (p.x > maxX) maxX = p.x;
      if (p.y > maxY) maxY = p.y;
    }
    return (minX, minY, maxX, maxY);
  }
}
