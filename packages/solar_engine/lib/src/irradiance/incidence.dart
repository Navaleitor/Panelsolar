import 'dart:math' as math;

import 'package:solar_engine/src/core/angles.dart';

/// Ángulo de incidencia del sol sobre el panel.
/// Ficha: docs/formulas/02-angulo-de-incidencia.md
///
/// cos θ = cos β·cos θz + sin β·sin θz·cos(γs − γ)
///
/// - β = [surfaceTilt] (0 = horizontal, 90 = vertical), grados.
/// - γ = [surfaceAzimuth] (180 = mirando al sur), grados.
/// - θz = [solarZenith], γs = [solarAzimuth], grados.
///
/// Devuelve cos θ limitado a [−1, 1] (negativo = sol detrás del panel).
double aoiProjection(
  double surfaceTilt,
  double surfaceAzimuth,
  double solarZenith,
  double solarAzimuth,
) {
  final p =
      cosd(surfaceTilt) * cosd(solarZenith) +
      sind(surfaceTilt) *
          sind(solarZenith) *
          cosd(solarAzimuth - surfaceAzimuth);
  return clampDouble(p, -1, 1);
}

/// Ángulo de incidencia θ en grados (0–180).
double angleOfIncidence(
  double surfaceTilt,
  double surfaceAzimuth,
  double solarZenith,
  double solarAzimuth,
) => radToDeg(
  math.acos(
    aoiProjection(surfaceTilt, surfaceAzimuth, solarZenith, solarAzimuth),
  ),
);
