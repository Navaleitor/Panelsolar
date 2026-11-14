import 'dart:math' as math;

import 'package:solar_engine/src/core/angles.dart';
import 'package:solar_engine/src/shading/plane_geometry.dart';
import 'package:solar_engine/src/shading/shadow_caster.dart';
import 'package:solar_engine/src/simulation/horizon_profile.dart';

/// Factor de vista de cielo (B.7.1 paso 6).
/// Ficha: docs/formulas/27-sombra-por-panel-y-diodos.md
abstract final class SkyView {
  /// Elevación (grados) con la que se ve el tope del obstáculo [o] desde
  /// [p] mirando al azimut [azimuthDeg]; 0 si el rayo no lo cruza.
  /// e = atan(h / distancia a la orilla más cercana de la huella).
  static double obstacleElevation(ShadingObstacle o, XY p, double azimuthDeg) {
    final dx = sind(azimuthDeg);
    final dy = cosd(azimuthDeg);
    var best = double.infinity;
    final f = o.footprint;
    for (var i = 0; i < f.length; i++) {
      final a = f[i];
      final b = f[(i + 1) % f.length];
      final t = _rayHit(p, dx, dy, a, b);
      if (t != null && t < best) best = t;
    }
    if (best.isInfinite || o.heightM <= 0) return 0;
    if (best < 1e-6) return 90;
    return radToDeg(math.atan(o.heightM / best));
  }

  /// Fracción de la difusa isótropa que llega al punto [p]:
  /// SVF = 1 − (1/N)·Σ sin²(e_máx(az)), con N sectores de azimut de
  /// [stepDeg] grados y e_máx la mayor elevación de obstáculos u
  /// horizonte en ese sector (superficie horizontal, cielo isótropo).
  static double factor(
    XY p,
    List<ShadingObstacle> obstacles, {
    HorizonProfile? horizon,
    double stepDeg = 5,
  }) {
    final n = (360 / stepDeg).round();
    var blocked = 0.0;
    for (var k = 0; k < n; k++) {
      final az = (k + 0.5) * stepDeg;
      var e = math.max(0, horizon?.elevationAt(az) ?? 0).toDouble();
      for (final o in obstacles) {
        final v = obstacleElevation(o, p, az);
        if (v > e) e = v;
      }
      final s = sind(e);
      blocked += s * s;
    }
    return 1 - blocked / n;
  }

  /// Distancia t ≥ 0 a la que el rayo p + t·(dx, dy) cruza el segmento ab.
  static double? _rayHit(XY p, double dx, double dy, XY a, XY b) {
    final ex = b.x - a.x;
    final ey = b.y - a.y;
    final den = dx * ey - dy * ex;
    if (den.abs() < 1e-12) return null;
    final wx = a.x - p.x;
    final wy = a.y - p.y;
    final t = (wx * ey - wy * ex) / den;
    final u = (wx * dy - wy * dx) / den;
    if (t < 0 || u < 0 || u > 1) return null;
    return t;
  }
}
