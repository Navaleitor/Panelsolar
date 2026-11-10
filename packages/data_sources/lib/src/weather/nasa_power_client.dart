import 'dart:convert';
import 'dart:typed_data';

import 'package:data_sources/src/http/retrying_get.dart';
import 'package:data_sources/src/weather/weather_dataset.dart';
import 'package:http/http.dart' as http;
import 'package:solar_engine/solar_engine.dart';

/// Cliente de la API horaria de NASA POWER (sin clave).
/// Documentación: https://power.larc.nasa.gov/docs/services/api/
///
/// Descarga GHI, DNI, DHI, temperatura a 2 m, viento a 10 m y albedo en hora
/// UTC. Cada valor es el promedio de la hora que empieza en la marca de
/// tiempo. El valor de relleno −999 se convierte en `NaN`.
class NasaPowerClient {
  /// Crea el cliente. [retryDelays] permite acelerar las pruebas.
  new({
    required this._client,
    this.baseUrl = 'https://power.larc.nasa.gov/api/temporal/hourly/point',
    this.retryDelays,
  });

  final http.Client _client;

  /// URL base del servicio horario.
  final String baseUrl;

  /// Esperas entre reintentos (nulo = valores por defecto).
  final List<Duration>? retryDelays;

  /// Parámetros pedidos a la API.
  static const parameters = [
    'ALLSKY_SFC_SW_DWN',
    'ALLSKY_SFC_SW_DNI',
    'ALLSKY_SFC_SW_DIFF',
    'T2M',
    'WS10M',
    'ALLSKY_SRF_ALB',
  ];

  /// Últimos [years] años calendario completos respecto a [now].
  static ({int start, int end}) lastCompleteYears(
    DateTime now, {
    int years = 5,
  }) => (start: now.year - years, end: now.year - 1);

  /// URL de la petición.
  Uri buildUri(double latitude, double longitude, int yearStart, int yearEnd) =>
      Uri.parse(baseUrl).replace(
        queryParameters: {
          'parameters': parameters.join(','),
          'community': 'RE',
          'longitude': longitude.toStringAsFixed(4),
          'latitude': latitude.toStringAsFixed(4),
          'start': '${yearStart}0101',
          'end': '${yearEnd}1231',
          'format': 'JSON',
          'time-standard': 'UTC',
        },
      );

  /// Descarga la serie horaria de [yearStart] a [yearEnd] (incluidos).
  Future<WeatherDataset> fetchHourly({
    required double latitude,
    required double longitude,
    required int yearStart,
    required int yearEnd,
    DateTime? now,
  }) async {
    final uri = buildUri(latitude, longitude, yearStart, yearEnd);
    final response = retryDelays == null
        ? await retryingGet(_client, uri)
        : await retryingGet(_client, uri, delays: retryDelays!);
    if (response.statusCode != 200) {
      throw DataSourceException(
        'NASA POWER respondió ${response.statusCode}: '
        '${_errorMessage(response.body)}',
        statusCode: response.statusCode,
      );
    }
    return parse(
      utf8.decode(response.bodyBytes),
      latitude: latitude,
      longitude: longitude,
      yearStart: yearStart,
      yearEnd: yearEnd,
      accessedAt: now ?? DateTime.now().toUtc(),
    );
  }

  /// Interpreta la respuesta JSON de NASA POWER.
  static WeatherDataset parse(
    String body, {
    required double latitude,
    required double longitude,
    required int yearStart,
    required int yearEnd,
    required DateTime accessedAt,
  }) {
    final json = jsonDecode(body) as Map<String, dynamic>;
    final header = json['header'] as Map<String, dynamic>? ?? {};
    final fill = (header['fill_value'] as num?)?.toDouble() ?? -999;
    final props = json['properties'] as Map<String, dynamic>;
    final params = props['parameter'] as Map<String, dynamic>;
    final ghiMap = params['ALLSKY_SFC_SW_DWN'] as Map<String, dynamic>;
    final keys = ghiMap.keys.toList()..sort();
    final n = keys.length;
    Float64List column(String name) {
      final m = params[name] as Map<String, dynamic>?;
      final out = Float64List(n);
      for (var i = 0; i < n; i++) {
        final v = (m?[keys[i]] as num?)?.toDouble();
        out[i] = (v == null || v == fill) ? double.nan : v;
      }
      return out;
    }

    final epochs = [
      for (final k in keys)
        DateTime.utc(
              int.parse(k.substring(0, 4)),
              int.parse(k.substring(4, 6)),
              int.parse(k.substring(6, 8)),
              int.parse(k.substring(8, 10)),
            ).millisecondsSinceEpoch ~/
            1000,
    ];
    final coords = (json['geometry'] as Map?)?['coordinates'] as List?;
    final api = header['api'] as Map<String, dynamic>?;
    return WeatherDataset(
      source: WeatherSource.nasaPower,
      latitude: latitude,
      longitude: longitude,
      elevation: coords != null && coords.length > 2
          ? (coords[2] as num).toDouble()
          : null,
      version: api?['version'] as String? ?? 'desconocida',
      accessedAt: accessedAt,
      yearStart: yearStart,
      yearEnd: yearEnd,
      series: WeatherSeries(
        startEpochSeconds: epochs,
        ghi: column('ALLSKY_SFC_SW_DWN'),
        dni: column('ALLSKY_SFC_SW_DNI'),
        dhi: column('ALLSKY_SFC_SW_DIFF'),
        tempAir: column('T2M'),
        windSpeed: column('WS10M'),
        albedo: column('ALLSKY_SRF_ALB'),
      ),
    );
  }

  static String _errorMessage(String body) {
    try {
      final j = jsonDecode(body);
      if (j is Map && j['messages'] != null) return j['messages'].toString();
      if (j is Map && j['message'] != null) return j['message'].toString();
    } on FormatException {
      // Cuerpo no JSON: se devuelve recortado.
    }
    return body.length > 200 ? body.substring(0, 200) : body;
  }
}
