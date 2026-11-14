import 'dart:convert';
import 'dart:typed_data';

import 'package:data_sources/src/http/retrying_get.dart';
import 'package:data_sources/src/weather/weather_dataset.dart';
import 'package:http/http.dart' as http;
import 'package:solar_engine/solar_engine.dart';

/// Cliente de PVGIS 5.3 (Centro Común de Investigación, Comisión Europea).
/// Documentación: https://joint-research-centre.ec.europa.eu/photovoltaic-geographical-information-system-pvgis/getting-started-pvgis/api-non-interactive-service_en
///
/// - `tmy`: año meteorológico típico horario (UTC).
/// - `printhorizon`: perfil de horizonte del terreno.
class PvgisClient {
  /// Crea el cliente.
  new({
    required this._client,
    this.baseUrl = 'https://re.jrc.ec.europa.eu/api/v5_3',
    this.retryDelays,
  });

  final http.Client _client;

  /// URL base con la versión de la API.
  final String baseUrl;

  /// Esperas entre reintentos (nulo = valores por defecto).
  final List<Duration>? retryDelays;

  /// Versión del servicio usada.
  static const String version = '5.3';

  Uri _uri(String tool, double lat, double lon) => Uri.parse('$baseUrl/$tool')
      .replace(
        queryParameters: {
          'lat': lat.toStringAsFixed(4),
          'lon': lon.toStringAsFixed(4),
          'outputformat': 'json',
        },
      );

  Future<Map<String, dynamic>> _get(String tool, double lat, double lon) async {
    final uri = _uri(tool, lat, lon);
    final r = retryDelays == null
        ? await retryingGet(_client, uri)
        : await retryingGet(_client, uri, delays: retryDelays!);
    final body = utf8.decode(r.bodyBytes);
    if (r.statusCode != 200) {
      var msg = body;
      try {
        final j = jsonDecode(body);
        if (j is Map && j['message'] != null) msg = j['message'].toString();
      } on FormatException {
        // Se deja el cuerpo tal cual.
      }
      throw DataSourceException(
        'PVGIS respondió ${r.statusCode}: $msg',
        statusCode: r.statusCode,
      );
    }
    return jsonDecode(body) as Map<String, dynamic>;
  }

  /// Descarga el TMY.
  Future<WeatherDataset> fetchTmy({
    required double latitude,
    required double longitude,
    DateTime? now,
  }) async => parseTmy(
    await _get('tmy', latitude, longitude),
    latitude: latitude,
    longitude: longitude,
    accessedAt: now ?? DateTime.now().toUtc(),
  );

  /// Descarga el perfil de horizonte.
  Future<HorizonProfile> fetchHorizon({
    required double latitude,
    required double longitude,
  }) async => parseHorizon(await _get('printhorizon', latitude, longitude));

  /// Interpreta la respuesta de `tmy`.
  static WeatherDataset parseTmy(
    Map<String, dynamic> json, {
    required double latitude,
    required double longitude,
    required DateTime accessedAt,
  }) {
    final rows = (json['outputs'] as Map)['tmy_hourly'] as List;
    final n = rows.length;
    final epochs = List<int>.filled(n, 0);
    final ghi = Float64List(n);
    final dni = Float64List(n);
    final dhi = Float64List(n);
    final temp = Float64List(n);
    final wind = Float64List(n);
    double v(Map<dynamic, dynamic> r, String k) =>
        (r[k] as num?)?.toDouble() ?? double.nan;
    for (var i = 0; i < n; i++) {
      final r = rows[i] as Map<dynamic, dynamic>;
      final t = r['time(UTC)'] as String; // "20160101:0000"
      epochs[i] =
          DateTime.utc(
            int.parse(t.substring(0, 4)),
            int.parse(t.substring(4, 6)),
            int.parse(t.substring(6, 8)),
            int.parse(t.substring(9, 11)),
          ).millisecondsSinceEpoch ~/
          1000;
      ghi[i] = v(r, 'G(h)');
      dni[i] = v(r, 'Gb(n)');
      dhi[i] = v(r, 'Gd(h)');
      temp[i] = v(r, 'T2m');
      wind[i] = v(r, 'WS10m');
    }
    final inputs = json['inputs'] as Map? ?? {};
    final location = inputs['location'] as Map? ?? {};
    final meteo = inputs['meteo_data'] as Map? ?? {};
    return WeatherDataset(
      source: WeatherSource.pvgisTmy,
      latitude: latitude,
      longitude: longitude,
      elevation: (location['elevation'] as num?)?.toDouble(),
      version: version,
      accessedAt: accessedAt,
      radiationDatabase: meteo['radiation_db'] as String?,
      yearStart: meteo['year_min'] as int?,
      yearEnd: meteo['year_max'] as int?,
      series: WeatherSeries(
        startEpochSeconds: epochs,
        ghi: ghi,
        dni: dni,
        dhi: dhi,
        tempAir: temp,
        windSpeed: wind,
        // PVGIS indica en qué minuto de la hora está centrada la irradiancia
        // (ERA5: 0.5 h; SARAH: ≈ 0.17 h). Ver docs/pruebas/validacion-motor.md.
        sampleOffsetMinutes:
            (((location['irradiance_time_offset'] as num?) ?? 0.5) * 60)
                .round(),
      ),
    );
  }

  /// Interpreta la respuesta de `printhorizon`. PVGIS mide el azimut desde
  /// el sur (0 = S, 90 = O, −90 = E); aquí se convierte a desde el norte.
  /// El punto de +180° repite el de −180° (norte) y se descarta.
  static HorizonProfile parseHorizon(Map<String, dynamic> json) {
    final rows = (json['outputs'] as Map)['horizon_profile'] as List;
    return HorizonProfile([
      for (final r in rows.cast<Map<String, dynamic>>())
        if ((r['A'] as num) < 180)
          (
            azimuth: (r['A'] as num).toDouble() + 180,
            elevation: (r['H_hor'] as num).toDouble(),
          ),
    ]);
  }
}
