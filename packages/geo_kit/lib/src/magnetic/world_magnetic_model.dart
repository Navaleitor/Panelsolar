import 'dart:math' as math;

import 'package:geo_kit/src/magnetic/wmm2025_coefficients.dart';

/// Componentes del campo magnético en un punto (nanoteslas) y declinación.
typedef MagneticField = ({
  double northNt,
  double eastNt,
  double downNt,
  double declinationDeg,
});

/// World Magnetic Model (WMM2025): campo magnético terrestre y declinación
/// magnética (ángulo entre el norte magnético y el geográfico; positiva si
/// la brújula apunta al este del norte verdadero).
///
/// Implementación del reporte técnico NOAA/BGS del WMM (ecuaciones 7–22):
/// coordenadas geodésicas → geocéntricas, armónicos esféricos de grado 12
/// con funciones de Legendre semi-normalizadas de Schmidt y variación
/// secular lineal desde la época 2025.0.
/// Ficha: docs/formulas/20-declinacion-magnetica-wmm.md
abstract final class WorldMagneticModel {
  /// Primer año válido del modelo.
  static const double validFrom = 2025;

  /// Último año válido del modelo.
  static const double validTo = 2030;

  static const int _maxDegree = 12;
  static const double _refRadiusKm = 6371.2;
  static const double _a = 6378.137;
  static const double _f = 1 / 298.257223563;

  /// `true` si [year] (decimal) está dentro del periodo del modelo.
  static bool isValidYear(double year) => year >= validFrom && year <= validTo;

  /// Año decimal de [time] (p. ej. 1 de julio de 2026 ≈ 2026.5).
  static double decimalYear(DateTime time) {
    final t = time.toUtc();
    final start = DateTime.utc(t.year);
    final end = DateTime.utc(t.year + 1);
    return t.year +
        t.difference(start).inMicroseconds /
            end.difference(start).inMicroseconds;
  }

  /// Declinación magnética (grados) en la latitud y longitud geodésicas
  /// dadas, a [altitudeM] metros sobre el elipsoide, en el año [year].
  static double declination({
    required double latitude,
    required double longitude,
    required double year,
    double altitudeM = 0,
  }) => field(
    latitude: latitude,
    longitude: longitude,
    year: year,
    altitudeM: altitudeM,
  ).declinationDeg;

  /// Campo magnético completo.
  static MagneticField field({
    required double latitude,
    required double longitude,
    required double year,
    double altitudeM = 0,
  }) {
    // Evita la singularidad exacta en los polos.
    final lat = latitude.clamp(-89.9999, 89.9999);
    final phi = lat * math.pi / 180;
    final lambda = longitude * math.pi / 180;
    final hKm = altitudeM / 1000;

    // Geodésicas → geocéntricas esféricas (ec. 7–8).
    const e2 = _f * (2 - _f);
    final sinPhi = math.sin(phi);
    final rc = _a / math.sqrt(1 - e2 * sinPhi * sinPhi);
    final p = (rc + hKm) * math.cos(phi);
    final z = (rc * (1 - e2) + hKm) * sinPhi;
    final r = math.sqrt(p * p + z * z);
    final phiC = math.asin(z / r);

    // Coeficientes en el tiempo t (ec. 9).
    final dt = year - wmm2025Epoch;
    final g = _table();
    final h = _table();
    for (final row in wmm2025Coefficients) {
      final n = row[0].toInt();
      final m = row[1].toInt();
      g[n][m] = row[2] + dt * row[4];
      h[n][m] = row[3] + dt * row[5];
    }

    // Legendre semi-normalizadas de Schmidt en cos θ = sin φ'.
    final x = math.sin(phiC);
    final s = math.cos(phiC);
    final pnm = _table();
    final dpnm = _table();
    pnm[0][0] = 1;
    for (var n = 1; n <= _maxDegree; n++) {
      for (var m = 0; m <= n; m++) {
        if (n == m) {
          pnm[n][n] = n == 1
              ? s
              : s * math.sqrt((2 * n - 1) / (2 * n)) * pnm[n - 1][n - 1];
        } else {
          final prev2 = n >= 2 ? pnm[n - 2][m] : 0.0;
          pnm[n][m] =
              ((2 * n - 1) * x * pnm[n - 1][m] -
                  math.sqrt(((n - 1) * (n - 1) - m * m).toDouble()) * prev2) /
              math.sqrt((n * n - m * m).toDouble());
        }
        // sin θ · dP/dθ = n cos θ P(n,m) − √(n² − m²) P(n−1,m).
        final lower = m <= n - 1 ? pnm[n - 1][m] : 0.0;
        dpnm[n][m] =
            (n * x * pnm[n][m] -
                math.sqrt((n * n - m * m).toDouble()) * lower) /
            s;
      }
    }

    // Sumas (ec. 10–12), en el sistema geocéntrico.
    var xp = 0.0;
    var yp = 0.0;
    var zp = 0.0;
    for (var n = 1; n <= _maxDegree; n++) {
      final k = math.pow(_refRadiusKm / r, n + 2).toDouble();
      for (var m = 0; m <= n; m++) {
        final cosM = math.cos(m * lambda);
        final sinM = math.sin(m * lambda);
        final gc = g[n][m] * cosM + h[n][m] * sinM;
        xp += k * gc * dpnm[n][m];
        yp += k * m * (g[n][m] * sinM - h[n][m] * cosM) * pnm[n][m];
        zp -= k * (n + 1) * gc * pnm[n][m];
      }
    }
    yp /= s;

    // Geocéntrico → geodésico (ec. 17).
    final d = phiC - phi;
    final north = xp * math.cos(d) - zp * math.sin(d);
    final down = xp * math.sin(d) + zp * math.cos(d);
    return (
      northNt: north,
      eastNt: yp,
      downNt: down,
      declinationDeg: math.atan2(yp, north) * 180 / math.pi,
    );
  }

  static List<List<double>> _table() =>
      List.generate(_maxDegree + 1, (_) => List<double>.filled(14, 0));
}
