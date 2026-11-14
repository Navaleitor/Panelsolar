import 'package:solar_engine/src/core/angles.dart';

/// Coeficiente b0 por defecto del modelo ASHRAE.
const double ashraeDefaultB0 = 0.05;

/// Modificador del ángulo de incidencia (IAM), modelo ASHRAE (Souka y
/// Safwat, 1966), igual que `pvlib.iam.ashrae`.
/// Ficha: docs/formulas/06-iam-ashrae.md
///
/// IAM = 1 − b0·(1/cos θ − 1), con IAM = 0 si θ ≥ 90° y nunca negativo.
/// [aoi] en grados.
double ashraeIam(double aoi, {double b0 = ashraeDefaultB0}) {
  if (aoi.abs() >= 90) return 0;
  final iam = 1 - b0 * (1 / cosd(aoi) - 1);
  return iam < 0 ? 0 : iam;
}
