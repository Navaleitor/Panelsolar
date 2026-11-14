import 'dart:math' as math;

import 'package:solar_engine/src/core/angles.dart';
import 'package:solar_engine/src/shading/plane_geometry.dart';

/// Superficie del techo sobre la que cae la sombra: un plano con
/// inclinación [tiltDeg] que baja hacia el azimut [azimuthDeg] y pasa por
/// [origin] (donde z = 0). Con inclinación 0 es un techo plano.
class RoofSurface {
  /// Crea la superficie.
  const new({
    this.tiltDeg = 0,
    this.azimuthDeg = 180,
    this.origin = (x: 0, y: 0),
  });

  /// Techo plano (horizontal).
  static const RoofSurface flat = RoofSurface();

  /// Inclinación β (grados).
  final double tiltDeg;

  /// Azimut hacia donde baja el plano γ (grados desde el norte, horario).
  final double azimuthDeg;

  /// Punto del plano con z = 0.
  final XY origin;

  /// Altura z del plano (m) en el punto [p].
  double heightAt(XY p) =>
      -tand(tiltDeg) *
      ((p.x - origin.x) * sind(azimuthDeg) +
          (p.y - origin.y) * cosd(azimuthDeg));
}

/// Obstáculo como prisma vertical: huella (m, coordenadas locales) y altura
/// sobre el techo en su base (m).
class ShadingObstacle {
  /// Crea el obstáculo.
  const new({required this.footprint, required this.heightM});

  /// Huella.
  final List<XY> footprint;

  /// Altura sobre el techo (m).
  final double heightM;
}

/// Sombra de obstáculos sobre el techo (plan B.7.1 paso 3).
/// Ficha: docs/formulas/19-sombras-de-obstaculos.md
abstract final class ShadowCaster {
  /// Largo de la sombra de un objeto de altura [heightM] sobre un piso
  /// plano con el Sol a [sunElevationDeg]: L = h / tan α. Infinito con el
  /// Sol en el horizonte o abajo.
  static double shadowLength(double heightM, double sunElevationDeg) {
    if (sunElevationDeg <= 0) return double.infinity;
    return heightM / tand(sunElevationDeg);
  }

  /// Desplazamiento horizontal (m) de la sombra del tope de un objeto de
  /// altura [heightM]: en dirección opuesta al Sol. Sobre un plano
  /// inclinado el rayo se cruza con el plano: t = h / (sᶻ + tan β·(s·u)),
  /// con s el vector hacia el Sol y u la dirección de bajada del plano.
  /// Devuelve `null` si el Sol está abajo o detrás del plano.
  static XY? offset({
    required double heightM,
    required double sunAzimuthDeg,
    required double sunElevationDeg,
    RoofSurface surface = RoofSurface.flat,
  }) {
    if (sunElevationDeg <= 0) return null;
    final ce = cosd(sunElevationDeg);
    final sx = sind(sunAzimuthDeg) * ce;
    final sy = cosd(sunAzimuthDeg) * ce;
    final sz = sind(sunElevationDeg);
    final along = sx * sind(surface.azimuthDeg) + sy * cosd(surface.azimuthDeg);
    final denom = sz + tand(surface.tiltDeg) * along;
    if (denom <= 1e-9) return null;
    final t = heightM / denom;
    return (x: -t * sx, y: -t * sy);
  }

  /// Polígono de la sombra (envolvente entre la huella y la huella
  /// desplazada), o `null` si el Sol no ilumina el plano. Es exacta para
  /// huellas convexas (tinacos, cajas, muros).
  static List<XY>? shadowPolygon(
    ShadingObstacle obstacle, {
    required double sunAzimuthDeg,
    required double sunElevationDeg,
    RoofSurface surface = RoofSurface.flat,
  }) {
    final d = offset(
      heightM: obstacle.heightM,
      sunAzimuthDeg: sunAzimuthDeg,
      sunElevationDeg: sunElevationDeg,
      surface: surface,
    );
    if (d == null) return null;
    return PlaneGeometry.convexHull([
      ...obstacle.footprint,
      for (final p in obstacle.footprint) (x: p.x + d.x, y: p.y + d.y),
    ]);
  }

  /// Sombras de todos los obstáculos para una posición del Sol.
  static List<List<XY>> sceneShadows(
    List<ShadingObstacle> obstacles, {
    required double sunAzimuthDeg,
    required double sunElevationDeg,
    RoofSurface surface = RoofSurface.flat,
  }) => [
    for (final o in obstacles)
      ?shadowPolygon(
        o,
        sunAzimuthDeg: sunAzimuthDeg,
        sunElevationDeg: sunElevationDeg,
        surface: surface,
      ),
  ];

  /// Distancia (m) del desplazamiento.
  static double length(XY d) => math.sqrt(d.x * d.x + d.y * d.y);
}
