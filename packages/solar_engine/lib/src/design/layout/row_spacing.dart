import 'dart:math' as math;

import 'package:solar_engine/src/core/angles.dart';
import 'package:solar_engine/src/position/spa.dart';
import 'package:solar_engine/src/simulation/site.dart';

/// Resultado de la separación entre filas (B.6 punto 11).
class RowSpacingResult {
  /// Crea el resultado.
  const new({
    required this.panelHeightM,
    required this.gapM,
    required this.pitchM,
    required this.worstSunElevationDeg,
    required this.worstSunAzimuthDeg,
    required this.groundCoverageRatio,
  });

  /// Altura del borde superior sobre el inferior: h = largo·sin β (m).
  final double panelHeightM;

  /// Separación libre entre filas d (m): de la orilla alta de una fila a la
  /// orilla baja de la siguiente, en planta.
  final double gapM;

  /// Paso entre filas = largo·cos β + d (m).
  final double pitchM;

  /// Elevación del Sol en el instante que da la sombra más larga.
  final double worstSunElevationDeg;

  /// Azimut del Sol en ese instante.
  final double worstSunAzimuthDeg;

  /// Cobertura del suelo GCR = largo / paso.
  final double groundCoverageRatio;
}

/// Separación entre filas en techo plano con estructura inclinada.
/// Ficha: docs/formulas/23-separacion-entre-filas.md
abstract final class RowSpacing {
  /// Largo de sombra en la dirección de la fila (m) de un borde de altura
  /// [heightM]: L = h·cos(γs − γ)/tan α. Cero si el Sol está detrás de la
  /// fila; infinito si está en el horizonte o abajo.
  static double shadowAlongRow({
    required double heightM,
    required double sunElevationDeg,
    required double sunAzimuthDeg,
    required double arrayAzimuthDeg,
  }) {
    if (sunElevationDeg <= 0) return double.infinity;
    final c = cosd(sunAzimuthDeg - arrayAzimuthDeg);
    if (c <= 0) return 0;
    return heightM * c / tand(sunElevationDeg);
  }

  /// Separación d para paneles de largo inclinado [slopeLengthM] (la medida
  /// que sube con la inclinación), a [tiltDeg] grados mirando a
  /// [arrayAzimuthDeg]. Se evalúa el solsticio de invierno del sitio entre
  /// las [fromSolarHour] y las [toSolarHour] (hora solar), cada
  /// [stepMinutes] minutos, y se toma la sombra más larga.
  static RowSpacingResult compute({
    required Site site,
    required double slopeLengthM,
    required double tiltDeg,
    required double arrayAzimuthDeg,
    int year = 2026,
    double fromSolarHour = 9,
    double toSolarHour = 15,
    int stepMinutes = 10,
  }) {
    final h = slopeLengthM * sind(tiltDeg);
    final day = site.isSouthernHemisphere
        ? DateTime.utc(year, 6, 21)
        : DateTime.utc(year, 12, 21);
    final noon = solarNoonUtc(site, day);
    var worst = 0.0;
    var worstEl = 90.0;
    var worstAz = arrayAzimuthDeg;
    final start = ((fromSolarHour - 12) * 60).round();
    final end = ((toSolarHour - 12) * 60).round();
    for (var m = start; m <= end; m += stepMinutes) {
      final p = _sun(site, noon.add(Duration(minutes: m)));
      final l = shadowAlongRow(
        heightM: h,
        sunElevationDeg: p.elevation,
        sunAzimuthDeg: p.azimuth,
        arrayAzimuthDeg: arrayAzimuthDeg,
      );
      if (l > worst) {
        worst = l;
        worstEl = p.elevation;
        worstAz = p.azimuth;
      }
    }
    final footprint = slopeLengthM * cosd(tiltDeg);
    final pitch = footprint + worst;
    return RowSpacingResult(
      panelHeightM: h,
      gapM: worst,
      pitchM: pitch,
      worstSunElevationDeg: worstEl,
      worstSunAzimuthDeg: worstAz,
      groundCoverageRatio: pitch <= 0 ? 0 : slopeLengthM / pitch,
    );
  }

  /// Mediodía solar (máxima elevación) del día [dayUtc] en UTC, con
  /// precisión de un minuto.
  static DateTime solarNoonUtc(Site site, DateTime dayUtc) {
    final guess = DateTime.utc(
      dayUtc.year,
      dayUtc.month,
      dayUtc.day,
    ).add(Duration(minutes: (720 - site.longitude * 4).round()));
    var best = guess;
    var bestEl = -90.0;
    for (var m = -30; m <= 30; m++) {
      final t = guess.add(Duration(minutes: m));
      final e = _sun(site, t).elevation;
      if (e > bestEl) {
        bestEl = e;
        best = t;
      }
    }
    return best;
  }

  static ({double azimuth, double elevation}) _sun(Site site, DateTime t) {
    final p = Spa.compute(
      timeUtc: t,
      latitude: site.latitude,
      longitude: site.longitude,
      elevation: site.elevation,
      pressureHpa: site.pressureHpa,
      temperatureC: site.meanTemperatureC,
    );
    return (azimuth: p.azimuth, elevation: math.max(p.apparentElevation, -90));
  }
}
