import 'dart:math' as math;

import 'package:geo_kit/src/geometry/polygon_ops.dart';
import 'package:geo_kit/src/geometry/vec2.dart';
import 'package:geo_kit/src/roof/obstacle_catalog.dart';

/// Huella (polígono en metros locales) de un obstáculo según su forma.
/// Ficha: docs/formulas/19-sombras-de-obstaculos.md
abstract final class ObstacleFootprint {
  /// Lados del polígono que aproxima un círculo. Con 24 lados el área queda
  /// 1.1 % por debajo del círculo real.
  static const int circleSides = 24;

  /// Construye la huella.
  /// - [center]: centro (círculo, rectángulo, punto).
  /// - [widthM]: diámetro, ancho o espesor de la línea.
  /// - [depthM]: fondo del rectángulo.
  /// - [rotationDeg]: giro antihorario del rectángulo.
  /// - [points]: extremos de la línea o vértices del polígono.
  static List<Vec2> build({
    required ObstacleShape shape,
    Vec2 center = Vec2.zero,
    double widthM = 0,
    double? depthM,
    double rotationDeg = 0,
    List<Vec2> points = const [],
  }) {
    switch (shape) {
      case ObstacleShape.circle:
      case ObstacleShape.point:
        return circle(center, math.max(widthM, 0.02) / 2);
      case ObstacleShape.rectangle:
        final w = widthM / 2;
        final d = (depthM ?? widthM) / 2;
        return [
          for (final c in [Vec2(-w, -d), Vec2(w, -d), Vec2(w, d), Vec2(-w, d)])
            center + c.rotated(rotationDeg),
        ];
      case ObstacleShape.line:
        if (points.length < 2) {
          throw ArgumentError('Una línea necesita dos puntos.');
        }
        return PolygonOps.strip(points[0], points[1], math.max(widthM, 0.02));
      case ObstacleShape.polygon:
        if (points.length < 3) {
          throw ArgumentError('Un polígono necesita tres puntos.');
        }
        return List.of(points);
    }
  }

  /// Polígono regular de [circleSides] lados inscrito en el círculo.
  static List<Vec2> circle(Vec2 center, double radius) => [
    for (var i = 0; i < circleSides; i++)
      center +
          Vec2(
            radius * math.cos(2 * math.pi * i / circleSides),
            radius * math.sin(2 * math.pi * i / circleSides),
          ),
  ];
}
