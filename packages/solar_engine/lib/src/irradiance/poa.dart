import 'dart:math' as math;

import 'package:solar_engine/src/irradiance/incidence.dart';
import 'package:solar_engine/src/irradiance/sky_diffuse.dart';

/// Modelo de transposición de la difusa del cielo.
enum TranspositionModel {
  /// Perez et al. (1990) — modelo principal.
  perez,

  /// Hay y Davies (1980) — alternativa más simple.
  hayDavies,
}

/// Componentes de la irradiancia en el plano del arreglo (POA), W/m².
class PoaIrradiance {
  /// Crea las componentes.
  const new({
    required this.direct,
    required this.skyDiffuse,
    required this.groundDiffuse,
  });

  /// Sin irradiancia (noche).
  static const PoaIrradiance zero = PoaIrradiance(
    direct: 0,
    skyDiffuse: 0,
    groundDiffuse: 0,
  );

  /// Directa en el plano: DNI·cos θ (≥ 0).
  final double direct;

  /// Difusa del cielo en el plano.
  final double skyDiffuse;

  /// Reflejada por el suelo.
  final double groundDiffuse;

  /// Difusa total = cielo + suelo.
  double get diffuse => skyDiffuse + groundDiffuse;

  /// POA global = directa + difusa.
  double get global => direct + diffuse;
}

/// Calcula la irradiancia en el plano del arreglo.
/// Ficha: docs/formulas/05-transposicion-perez-hay-davies.md
///
/// POA = DNI·cos θ + Ed(modelo) + GHI·ρ·(1 − cos β)/2
///
/// Si el Sol está bajo el horizonte (θz ≥ 90°) la directa es 0.
PoaIrradiance planeOfArrayIrradiance({
  required double surfaceTilt,
  required double surfaceAzimuth,
  required double solarZenith,
  required double solarAzimuth,
  required double dni,
  required double ghi,
  required double dhi,
  required double dniExtra,
  required double airmass,
  required double albedo,
  TranspositionModel model = TranspositionModel.perez,
}) {
  final sunUp = solarZenith < 90;
  final beam = sunUp
      ? math.max(
          0,
          dni *
              aoiProjection(
                surfaceTilt,
                surfaceAzimuth,
                solarZenith,
                solarAzimuth,
              ),
        )
      : 0;
  final sky = switch (model) {
    TranspositionModel.perez => perezSkyDiffuse(
      surfaceTilt: surfaceTilt,
      surfaceAzimuth: surfaceAzimuth,
      dhi: dhi,
      dni: dni,
      dniExtra: dniExtra,
      solarZenith: solarZenith,
      solarAzimuth: solarAzimuth,
      airmass: airmass,
    ),
    TranspositionModel.hayDavies =>
      sunUp
          ? hayDaviesSkyDiffuse(
              surfaceTilt: surfaceTilt,
              surfaceAzimuth: surfaceAzimuth,
              dhi: dhi,
              dni: dni,
              dniExtra: dniExtra,
              solarZenith: solarZenith,
              solarAzimuth: solarAzimuth,
            )
          : 0.0,
  };
  return PoaIrradiance(
    direct: beam.toDouble(),
    skyDiffuse: sky,
    groundDiffuse: groundDiffuse(surfaceTilt, ghi, albedo),
  );
}
