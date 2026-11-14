import 'dart:math' as math;

import 'package:solar_engine/src/core/angles.dart';

/// Resultado de la descomposición de Erbs.
typedef ErbsResult = ({double dni, double dhi, double kt});

/// Descomposición de la irradiancia global horizontal en directa y difusa,
/// modelo de Erbs, Klein y Duffie (1982). Igual que `pvlib.irradiance.erbs`.
/// Ficha: docs/formulas/04-descomposicion-erbs.md
///
/// - [ghi]: irradiancia global horizontal (W/m²).
/// - [zenith]: ángulo cenital (grados).
/// - [dniExtra]: irradiancia extraterrestre normal I0 (W/m²).
///
/// kt = GHI / (I0·max(cos θz, 0.065)), limitado a [0, 1].
/// Fracción difusa:
/// - kt ≤ 0.22: 1 − 0.09·kt
/// - 0.22 < kt ≤ 0.80: 0.9511 − 0.1604·kt + 4.388·kt² − 16.638·kt³ + 12.336·kt⁴
/// - kt > 0.80: 0.165
ErbsResult erbs(
  double ghi,
  double zenith,
  double dniExtra, {
  double minCosZenith = 0.065,
  double maxZenith = 87,
}) {
  final cosZ = cosd(zenith);
  final kt = clampDouble(ghi / (dniExtra * math.max(cosZ, minCosZenith)), 0, 1);
  double df;
  if (kt > 0.8) {
    df = 0.165;
  } else if (kt > 0.22) {
    df =
        0.9511 -
        0.1604 * kt +
        4.388 * kt * kt -
        16.638 * kt * kt * kt +
        12.336 * kt * kt * kt * kt;
  } else {
    df = 1 - 0.09 * kt;
  }
  final dhi = df * ghi;
  final dni = (ghi - dhi) / cosZ;
  if (zenith > maxZenith || ghi < 0 || dni < 0) {
    return (dni: 0, dhi: ghi, kt: kt);
  }
  return (dni: dni, dhi: dhi, kt: kt);
}
