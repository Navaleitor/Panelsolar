import 'dart:math' as math;

import 'package:solar_engine/src/irradiance/atmosphere.dart';
import 'package:solar_engine/src/irradiance/incidence.dart';
import 'package:solar_engine/src/position/spa.dart';
import 'package:solar_engine/src/simulation/site.dart';

/// Una posición del Sol con su peso para el mapa de calor.
typedef SunSample = ({
  int month,
  double azimuth,
  double elevation,
  double weight,
});

/// Muestras del Sol a lo largo del año para el sombreado.
/// Ficha: docs/formulas/19-sombras-de-obstaculos.md
abstract final class SunSamples {
  /// Irradiancia directa normal de cielo despejado (W/m²), modelo de
  /// Meinel y Meinel (1976): DNI = 1353 · 0.7^(AM^0.678).
  static double clearSkyDni(double apparentZenith) {
    final am = relativeAirmass(apparentZenith);
    if (am.isNaN) return 0;
    return 1353 * math.pow(0.7, math.pow(am, 0.678)).toDouble();
  }

  /// Posición del Sol en la hora estándar local [localHour] (puede tener
  /// decimales) del día dado.
  static ({double azimuth, double elevation}) at(
    Site site,
    int year,
    int month,
    int day,
    double localHour,
  ) {
    final utc = DateTime.utc(
      year,
      month,
      day,
    ).add(Duration(minutes: ((localHour - site.utcOffsetHours) * 60).round()));
    final p = Spa.compute(
      timeUtc: utc,
      latitude: site.latitude,
      longitude: site.longitude,
      elevation: site.elevation,
      pressureHpa: site.pressureHpa,
      temperatureC: site.meanTemperatureC,
    );
    return (azimuth: p.azimuth, elevation: p.apparentElevation);
  }

  /// Muestras de un año: un día cada [dayStep] días y un instante cada
  /// [minuteStep] minutos (al centro de cada intervalo). Peso = DNI de
  /// cielo despejado × cos θ sobre el plano (tilt, azimuth); las muestras
  /// con el Sol abajo o detrás del plano no se incluyen.
  static List<SunSample> year(
    Site site, {
    int year = 2025,
    int dayStep = 7,
    int minuteStep = 30,
    double tiltDeg = 0,
    double azimuthDeg = 180,
  }) {
    final out = <SunSample>[];
    final offset = (site.utcOffsetHours * 60).round();
    var day = DateTime.utc(year, 1, 1 + dayStep ~/ 2);
    while (day.year == year) {
      for (var m = minuteStep ~/ 2; m < 24 * 60; m += minuteStep) {
        final utc = day.add(Duration(minutes: m - offset));
        final p = Spa.compute(
          timeUtc: utc,
          latitude: site.latitude,
          longitude: site.longitude,
          elevation: site.elevation,
          pressureHpa: site.pressureHpa,
          temperatureC: site.meanTemperatureC,
        );
        if (p.apparentElevation <= 0) continue;
        final cosT = aoiProjection(
          tiltDeg,
          azimuthDeg,
          p.apparentZenith,
          p.azimuth,
        );
        if (cosT <= 0) continue;
        out.add((
          month: day.month,
          azimuth: p.azimuth,
          elevation: p.apparentElevation,
          weight: clearSkyDni(p.apparentZenith) * cosT,
        ));
      }
      day = day.add(Duration(days: dayStep));
    }
    return out;
  }
}
