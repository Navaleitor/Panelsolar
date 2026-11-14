import 'dart:math' as math;

import 'package:solar_engine/src/core/angles.dart';

/// Funciones atmosféricas auxiliares.
/// Ficha: docs/formulas/03-extraterrestre-y-masa-de-aire.md

/// Constante solar usada por pvlib (W/m²).
const double solarConstant = 1366.1;

/// Irradiancia extraterrestre normal I0 (W/m²) según Spencer (1971):
/// I0 = Isc·(1.00011 + 0.034221·cos B + 0.00128·sin B + 0.000719·cos 2B
/// + 0.000077·sin 2B), con B = 2π·(n − 1)/365 y n = día del año (1–366).
double extraterrestrialNormal(int dayOfYear) {
  final b = 2 * math.pi * (dayOfYear - 1) / 365;
  return solarConstant *
      (1.00011 +
          0.034221 * math.cos(b) +
          0.00128 * math.sin(b) +
          0.000719 * math.cos(2 * b) +
          7.7e-05 * math.sin(2 * b));
}

/// Irradiancia extraterrestre sobre plano horizontal (W/m²):
/// I0h = I0·cos θz (0 si el Sol está bajo el horizonte).
double extraterrestrialHorizontal(int dayOfYear, double zenith) {
  final c = cosd(zenith);
  return c > 0 ? extraterrestrialNormal(dayOfYear) * c : 0;
}

/// Masa de aire relativa (sin corregir por presión), Kasten y Young (1989):
/// AM = 1 / (cos θz + 0.50572·(6.07995 + 90 − θz)^−1.6364).
/// Devuelve `NaN` si θz > 90°.
double relativeAirmass(double zenith) {
  if (zenith > 90 || zenith.isNaN) return double.nan;
  return 1.0 /
      (cosd(zenith) +
          0.50572 * math.pow(6.07995 + (90 - zenith), -1.6364).toDouble());
}

/// Presión atmosférica estándar (Pa) a la altitud [altitude] (m), igual que
/// `pvlib.atmosphere.alt2pres`.
double altitudeToPressure(double altitude) =>
    100 *
    math.pow((44331.514 - altitude) / 11880.516, 1 / 0.1902632).toDouble();

/// Día del año (1–366) de una fecha.
int dayOfYear(DateTime date) {
  final start = DateTime.utc(date.year);
  final d = DateTime.utc(date.year, date.month, date.day);
  return d.difference(start).inDays + 1;
}
