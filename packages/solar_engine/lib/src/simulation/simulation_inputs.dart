import 'dart:typed_data';

import 'package:solar_engine/src/irradiance/atmosphere.dart';
import 'package:solar_engine/src/irradiance/erbs.dart';
import 'package:solar_engine/src/position/spa.dart';
import 'package:solar_engine/src/simulation/horizon_profile.dart';
import 'package:solar_engine/src/simulation/site.dart';
import 'package:solar_engine/src/simulation/weather_series.dart';

/// Datos horarios que no dependen de la orientación del panel: posición
/// solar, extraterrestre, masa de aire, DNI/DHI (Erbs si faltan) y albedo.
///
/// Se calculan una sola vez y se reutilizan en cada simulación (por ejemplo,
/// al buscar la orientación óptima), lo que hace la búsqueda muy rápida.
class SimulationInputs {
  new _({
    required this.site,
    required this.weather,
    required this.zenith,
    required this.azimuth,
    required this.dniExtra,
    required this.airmass,
    required this.ghi,
    required this.dni,
    required this.dhi,
    required this.albedo,
    required this.beamBlocked,
  });

  /// Prepara las entradas.
  ///
  /// - [defaultAlbedo]: se usa cuando la serie no trae albedo válido.
  /// - [horizon]: perfil de horizonte opcional; bloquea la directa.
  factory prepare({
    required Site site,
    required WeatherSeries weather,
    double defaultAlbedo = 0.2,
    HorizonProfile? horizon,
  }) {
    final n = weather.length;
    final zenith = Float64List(n);
    final azimuth = Float64List(n);
    final dniExtra = Float64List(n);
    final airmass = Float64List(n);
    final ghi = Float64List(n);
    final dni = Float64List(n);
    final dhi = Float64List(n);
    final albedo = Float64List(n);
    final blocked = Uint8List(n);
    final pressure = site.pressureHpa;
    for (var i = 0; i < n; i++) {
      final t = weather.sampleTimeUtc(i);
      final pos = Spa.compute(
        timeUtc: t,
        latitude: site.latitude,
        longitude: site.longitude,
        elevation: site.elevation,
        pressureHpa: pressure,
        temperatureC: site.meanTemperatureC,
      );
      final z = pos.apparentZenith;
      zenith[i] = z;
      azimuth[i] = pos.azimuth;
      final i0 = extraterrestrialNormal(dayOfYear(t));
      dniExtra[i] = i0;
      airmass[i] = relativeAirmass(z);
      final g = _clean(weather.ghi[i]);
      ghi[i] = g;
      var b = weather.dni[i];
      var d = weather.dhi[i];
      if (b.isNaN || d.isNaN) {
        final e = erbs(g, z, i0);
        b = e.dni;
        d = e.dhi;
      }
      dni[i] = _clean(b);
      dhi[i] = _clean(d);
      final a = weather.albedo?[i] ?? double.nan;
      albedo[i] = (a.isFinite && a >= 0 && a <= 1) ? a : defaultAlbedo;
      if (horizon != null && z < 90 && horizon.blocks(90 - z, pos.azimuth)) {
        blocked[i] = 1;
      }
    }
    return SimulationInputs._(
      site: site,
      weather: weather,
      zenith: zenith,
      azimuth: azimuth,
      dniExtra: dniExtra,
      airmass: airmass,
      ghi: ghi,
      dni: dni,
      dhi: dhi,
      albedo: albedo,
      beamBlocked: blocked,
    );
  }

  /// Sitio.
  final Site site;

  /// Serie original (temperatura, viento y tiempos).
  final WeatherSeries weather;

  /// Cenit aparente (grados).
  final Float64List zenith;

  /// Azimut solar (grados).
  final Float64List azimuth;

  /// Extraterrestre normal (W/m²).
  final Float64List dniExtra;

  /// Masa de aire relativa (NaN de noche).
  final Float64List airmass;

  /// GHI limpia (W/m²).
  final Float64List ghi;

  /// DNI (W/m²), medida o de Erbs.
  final Float64List dni;

  /// DHI (W/m²), medida o de Erbs.
  final Float64List dhi;

  /// Albedo usado por registro.
  final Float64List albedo;

  /// 1 si el horizonte bloquea la directa en ese registro.
  final Uint8List beamBlocked;

  /// Número de registros.
  int get length => zenith.length;

  /// Valores faltantes o negativos se tratan como 0.
  static double _clean(double v) => (v.isNaN || v < 0) ? 0 : v;
}
