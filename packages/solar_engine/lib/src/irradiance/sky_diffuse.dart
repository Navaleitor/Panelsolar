import 'dart:math' as math;

import 'package:solar_engine/src/core/angles.dart';
import 'package:solar_engine/src/irradiance/incidence.dart';

/// Modelos de difusa del cielo sobre un plano inclinado (sin la reflejada
/// por el suelo). Ficha: docs/formulas/05-transposicion-perez-hay-davies.md

/// Coeficientes F1 del modelo Perez 1990 "allsitescomposite1990"
/// (filas = 8 intervalos de claridad ε; columnas = f11, f12, f13).
const List<List<double>> _perezF1 = [
  [-0.008, 0.588, -0.062],
  [0.130, 0.683, -0.151],
  [0.330, 0.487, -0.221],
  [0.568, 0.187, -0.295],
  [0.873, -0.392, -0.362],
  [1.132, -1.237, -0.412],
  [1.060, -1.600, -0.359],
  [0.678, -0.327, -0.250],
];

/// Coeficientes F2 (f21, f22, f23) del mismo juego.
const List<List<double>> _perezF2 = [
  [-0.060, 0.072, -0.022],
  [-0.019, 0.066, -0.029],
  [0.055, -0.064, -0.026],
  [0.109, -0.152, -0.014],
  [0.226, -0.462, 0.001],
  [0.288, -0.823, 0.056],
  [0.264, -1.127, 0.131],
  [0.156, -1.377, 0.251],
];

/// Límites inferiores de los intervalos de claridad ε del modelo Perez.
const List<double> _epsilonBins = [0, 1.065, 1.23, 1.5, 1.95, 2.8, 4.5, 6.2];

/// Difusa del cielo en el plano según Perez et al. (1990), igual que
/// `pvlib.irradiance.perez` con `allsitescomposite1990`.
///
/// Ed = DHI·[(1 − F1)·(1 + cos β)/2 + F1·a/b + F2·sin β]
/// con a = max(0, cos θ), b = max(cos 85°, cos θz),
/// ε = ((DHI + DNI)/DHI + κ·θz³)/(1 + κ·θz³), κ = 1.041 (θz en rad),
/// Δ = DHI·AM/I0, F1 = max(0, f11 + f12·Δ + f13·θz), F2 = f21 + f22·Δ + f23·θz.
///
/// Devuelve 0 si el Sol está bajo el horizonte (AM no definida) o si no hay
/// difusa.
double perezSkyDiffuse({
  required double surfaceTilt,
  required double surfaceAzimuth,
  required double dhi,
  required double dni,
  required double dniExtra,
  required double solarZenith,
  required double solarAzimuth,
  required double airmass,
}) {
  if (airmass.isNaN || dhi <= 0) return 0;
  const kappa = 1.041;
  final z = degToRad(solarZenith);
  final z3 = kappa * z * z * z;
  final delta = dhi * airmass / dniExtra;
  final eps = ((dhi + dni) / dhi + z3) / (1 + z3);
  var bin = 0;
  for (var i = _epsilonBins.length - 1; i >= 0; i--) {
    if (eps >= _epsilonBins[i]) {
      bin = i;
      break;
    }
  }
  final f1c = _perezF1[bin];
  final f2c = _perezF2[bin];
  final f1 = math.max(0, f1c[0] + f1c[1] * delta + f1c[2] * z);
  final f2 = f2c[0] + f2c[1] * delta + f2c[2] * z;
  final a = math.max(
    0,
    aoiProjection(surfaceTilt, surfaceAzimuth, solarZenith, solarAzimuth),
  );
  final b = math.max(cosd(solarZenith), cosd(85));
  final term1 = 0.5 * (1 - f1) * (1 + cosd(surfaceTilt));
  final term2 = f1 * a / b;
  final term3 = f2 * sind(surfaceTilt);
  return math.max(0, dhi * (term1 + term2 + term3));
}

/// Difusa del cielo en el plano según Hay y Davies (1980), igual que
/// `pvlib.irradiance.haydavies`.
///
/// Ed = DHI·[A·Rb + (1 − A)·(1 + cos β)/2], A = DNI/I0,
/// Rb = max(cos θ, 0)/max(cos θz, 0.01745).
double hayDaviesSkyDiffuse({
  required double surfaceTilt,
  required double surfaceAzimuth,
  required double dhi,
  required double dni,
  required double dniExtra,
  required double solarZenith,
  required double solarAzimuth,
}) {
  final cosTt = math.max(
    0,
    aoiProjection(surfaceTilt, surfaceAzimuth, solarZenith, solarAzimuth),
  );
  final rb = cosTt / math.max(cosd(solarZenith), 0.01745);
  final ai = dni / dniExtra;
  final isotropic = math.max(0, dhi * (1 - ai) * 0.5 * (1 + cosd(surfaceTilt)));
  final circumsolar = math.max(0, dhi * ai * rb);
  return (isotropic + circumsolar).toDouble();
}

/// Irradiancia reflejada por el suelo hacia el plano:
/// Eg = GHI·ρ·(1 − cos β)/2.
double groundDiffuse(double surfaceTilt, double ghi, double albedo) =>
    ghi * albedo * (1 - cosd(surfaceTilt)) * 0.5;
