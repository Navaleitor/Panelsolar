import 'dart:math' as math;

import 'package:solar_engine/src/core/angles.dart';
import 'package:solar_engine/src/position/spa_earth_terms.dart';
import 'package:solar_engine/src/position/spa_nutation_terms.dart';

/// Pasos 3.2 y 3.4 del NREL SPA (Reda y Andreas, 2004): posición
/// heliocéntrica de la Tierra y nutación.
/// Ficha: docs/formulas/01-posicion-solar-spa.md

double _series(List<List<double>> terms, double jme) {
  var sum = 0.0;
  for (final t in terms) {
    sum += t[0] * math.cos(t[1] + t[2] * jme);
  }
  return sum;
}

double _poly(List<double> values, double x) {
  var result = 0.0;
  var power = 1.0;
  for (final v in values) {
    result += v * power;
    power *= x;
  }
  return result;
}

/// Longitud heliocéntrica L (grados, 0–360) para el milenio de efemérides
/// juliano [jme].
double heliocentricLongitude(double jme) {
  final l = _poly([
    _series(spaL0, jme),
    _series(spaL1, jme),
    _series(spaL2, jme),
    _series(spaL3, jme),
    _series(spaL4, jme),
    _series(spaL5, jme),
  ], jme);
  return positiveMod(radToDeg(l / 1e8), 360);
}

/// Latitud heliocéntrica B (grados).
double heliocentricLatitude(double jme) {
  final b = _poly([_series(spaB0, jme), _series(spaB1, jme)], jme);
  return radToDeg(b / 1e8);
}

/// Distancia Tierra–Sol R (unidades astronómicas).
double earthRadiusVector(double jme) {
  final r = _poly([
    _series(spaR0, jme),
    _series(spaR1, jme),
    _series(spaR2, jme),
    _series(spaR3, jme),
    _series(spaR4, jme),
  ], jme);
  return r / 1e8;
}

/// Nutación en longitud Δψ y en oblicuidad Δε (grados).
typedef Nutation = ({double deltaPsi, double deltaEpsilon});

/// Calcula la nutación para el siglo de efemérides juliano [jce].
Nutation nutation(double jce) {
  final jce2 = jce * jce;
  final jce3 = jce2 * jce;
  final x = [
    297.85036 + 445267.111480 * jce - 0.0019142 * jce2 + jce3 / 189474,
    357.52772 + 35999.050340 * jce - 0.0001603 * jce2 - jce3 / 300000,
    134.96298 + 477198.867398 * jce + 0.0086972 * jce2 + jce3 / 56250,
    93.27191 + 483202.017538 * jce - 0.0036825 * jce2 + jce3 / 327270,
    125.04452 - 1934.136261 * jce + 0.0020708 * jce2 + jce3 / 450000,
  ];
  var psi = 0.0;
  var eps = 0.0;
  for (var row = 0; row < spaNutationY.length; row++) {
    final y = spaNutationY[row];
    final arg = degToRad(
      y[0] * x[0] + y[1] * x[1] + y[2] * x[2] + y[3] * x[3] + y[4] * x[4],
    );
    final abcd = spaNutationAbcd[row];
    psi += (abcd[0] + abcd[1] * jce) * math.sin(arg);
    eps += (abcd[2] + abcd[3] * jce) * math.cos(arg);
  }
  return (deltaPsi: psi / 36000000, deltaEpsilon: eps / 36000000);
}

/// Oblicuidad media de la eclíptica ε0 (segundos de arco).
double meanEclipticObliquity(double jme) {
  final u = jme / 10;
  return _poly([
    84381.448,
    -4680.93,
    -1.55,
    1999.25,
    -51.38,
    -249.67,
    -39.05,
    7.12,
    27.87,
    5.79,
    2.45,
  ], u);
}
