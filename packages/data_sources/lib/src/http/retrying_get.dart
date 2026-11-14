import 'dart:async';

import 'package:http/http.dart' as http;

/// Error de una fuente de datos remota.
class DataSourceException implements Exception {
  /// Crea el error.
  const new(this.message, {this.statusCode});

  /// Mensaje legible (en español).
  final String message;

  /// Código HTTP, si lo hubo.
  final int? statusCode;

  @override
  String toString() => 'DataSourceException($statusCode): $message';
}

/// User-Agent propio: las políticas de NASA POWER, PVGIS y OSM piden
/// identificar la aplicación (sin datos personales).
const String panelsolarUserAgent = 'Panelsolar/0.1 (app de diseno FV)';

/// GET con reintentos y espera exponencial ante 429 (demasiadas
/// peticiones), 529 (PVGIS saturado), errores 5xx y fallos de red.
///
/// [delays] son las esperas entre intentos (por defecto 2, 4, 8 y 16 s).
Future<http.Response> retryingGet(
  http.Client client,
  Uri uri, {
  List<Duration> delays = const [
    Duration(seconds: 2),
    Duration(seconds: 4),
    Duration(seconds: 8),
    Duration(seconds: 16),
  ],
  Duration timeout = const Duration(seconds: 120),
}) async {
  for (var attempt = 0; ; attempt++) {
    final canRetry = attempt < delays.length;
    try {
      final r = await client
          .get(uri, headers: {'User-Agent': panelsolarUserAgent})
          .timeout(timeout);
      final retryable = r.statusCode == 429 || r.statusCode >= 500;
      if (!retryable || !canRetry) return r;
    } on TimeoutException {
      if (!canRetry) {
        throw const DataSourceException('El servidor no respondió a tiempo.');
      }
    } on http.ClientException catch (e) {
      if (!canRetry) {
        throw DataSourceException('Sin conexión con el servidor: ${e.message}');
      }
    }
    await Future<void>.delayed(delays[attempt]);
  }
}
