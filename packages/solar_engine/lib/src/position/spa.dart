import 'dart:math' as math;

import 'package:solar_engine/src/core/angles.dart';
import 'package:solar_engine/src/position/delta_t.dart';
import 'package:solar_engine/src/position/solar_position.dart';
import 'package:solar_engine/src/position/spa_earth.dart';

/// Algoritmo de posición solar NREL SPA (Reda y Andreas, 2004,
/// NREL/TP-560-34302). Error declarado ±0.0003° entre −2000 y 6000.
///
/// Implementación paso a paso equivalente a `pvlib.spa.solar_position_numpy`.
/// Ficha: docs/formulas/01-posicion-solar-spa.md
abstract final class Spa {
  /// Refracción atmosférica aparente en el horizonte (grados), valor del SPA.
  static const double defaultAtmosRefract = 0.5667;

  /// Calcula la posición del Sol.
  ///
  /// - [timeUtc]: instante en UTC.
  /// - [latitude], [longitude]: grados (norte y este positivos).
  /// - [elevation]: altitud del observador sobre el nivel del mar (m).
  /// - [pressureHpa]: presión local (hPa = mbar), solo afecta la refracción.
  /// - [temperatureC]: temperatura media local (°C), solo afecta la
  ///   refracción.
  /// - [deltaT]: TT − UT en segundos; si es nulo se estima con
  ///   [deltaTSeconds].
  static SolarPosition compute({
    required DateTime timeUtc,
    required double latitude,
    required double longitude,
    double elevation = 0,
    double pressureHpa = 1013.25,
    double temperatureC = 12,
    double atmosRefract = defaultAtmosRefract,
    double? deltaT,
  }) {
    final utc = timeUtc.toUtc();
    final unix = utc.microsecondsSinceEpoch / 1e6;
    final dt = deltaT ?? deltaTSeconds(utc.year, utc.month);

    // 3.1 Tiempos julianos.
    final jd = unix / 86400 + 2440587.5;
    final jde = jd + dt / 86400;
    final jc = (jd - 2451545) / 36525;
    final jce = (jde - 2451545) / 36525;
    final jme = jce / 10;

    // 3.2–3.3 Posición heliocéntrica y geocéntrica.
    final r = earthRadiusVector(jme);
    final theta = positiveMod(heliocentricLongitude(jme) + 180, 360);
    final beta = -heliocentricLatitude(jme);

    // 3.4–3.6 Nutación y oblicuidad.
    final nut = nutation(jce);
    final epsilon = meanEclipticObliquity(jme) / 3600 + nut.deltaEpsilon;

    // 3.7–3.8 Aberración y longitud aparente del Sol.
    final lambda = theta + nut.deltaPsi + -20.4898 / (3600 * r);

    // 3.9 Tiempo sidéreo aparente en Greenwich.
    final v0 = positiveMod(
      280.46061837 +
          360.98564736629 * (jd - 2451545) +
          0.000387933 * jc * jc -
          jc * jc * jc / 38710000,
      360,
    );
    final v = v0 + nut.deltaPsi * cosd(epsilon);

    // 3.10–3.11 Ascensión recta y declinación geocéntricas.
    final lambdaRad = degToRad(lambda);
    final epsRad = degToRad(epsilon);
    final betaRad = degToRad(beta);
    final alpha = positiveMod(
      radToDeg(
        math.atan2(
          math.sin(lambdaRad) * math.cos(epsRad) -
              math.tan(betaRad) * math.sin(epsRad),
          math.cos(lambdaRad),
        ),
      ),
      360,
    );
    final delta = radToDeg(
      math.asin(
        math.sin(betaRad) * math.cos(epsRad) +
            math.cos(betaRad) * math.sin(epsRad) * math.sin(lambdaRad),
      ),
    );

    // 3.12–3.13 Ángulo horario y paralaje.
    final h = positiveMod(v + longitude - alpha, 360);
    final xi = 8.794 / (3600 * r);
    final u = math.atan(0.99664719 * tand(latitude));
    final x = math.cos(u) + elevation / 6378140 * cosd(latitude);
    final y = 0.99664719 * math.sin(u) + elevation / 6378140 * sind(latitude);
    final deltaAlpha = radToDeg(
      math.atan2(-x * sind(xi) * sind(h), cosd(delta) - x * sind(xi) * cosd(h)),
    );
    final deltaPrime = radToDeg(
      math.atan2(
        (sind(delta) - y * sind(xi)) * cosd(deltaAlpha),
        cosd(delta) - x * sind(xi) * cosd(h),
      ),
    );
    final hPrime = h - deltaAlpha;

    // 3.14 Elevación topocéntrica sin y con refracción.
    final e0 = radToDeg(
      math.asin(
        sind(latitude) * sind(deltaPrime) +
            cosd(latitude) * cosd(deltaPrime) * cosd(hPrime),
      ),
    );
    final refraction = e0 >= -1.0 * (0.26667 + atmosRefract)
        ? (pressureHpa / 1010.0) *
              (283.0 / (273 + temperatureC)) *
              1.02 /
              (60 * tand(e0 + 10.3 / (e0 + 5.11)))
        : 0.0;
    final e = e0 + refraction;

    // 3.15 Azimut (desde el norte, sentido horario).
    final astronomersAzimuth = positiveMod(
      radToDeg(
        math.atan2(
          sind(hPrime),
          cosd(hPrime) * sind(latitude) - tand(deltaPrime) * cosd(latitude),
        ),
      ),
      360,
    );
    final azimuth = positiveMod(astronomersAzimuth + 180, 360);

    return SolarPosition(
      zenith: 90 - e0,
      apparentZenith: 90 - e,
      azimuth: azimuth,
      declination: deltaPrime,
      earthSunDistance: r,
    );
  }
}
