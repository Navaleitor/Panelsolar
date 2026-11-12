import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// Respuesta HTTP mínima (código y cuerpo en texto).
class HttpTextResponse {
  /// Crea la respuesta.
  const new(this.statusCode, this.body);

  /// Código HTTP.
  final int statusCode;

  /// Cuerpo decodificado como UTF-8.
  final String body;
}

/// Hace un GET y devuelve la respuesta. Se inyecta para poder probar sin red.
typedef HttpGetter = Future<HttpTextResponse> Function(
  Uri uri,
  Map<String, String> headers,
);

/// [HttpGetter] real con `dart:io` (sin dependencias extra). Lanza
/// [SocketException], [HttpException] o [TimeoutException] si falla la red.
Future<HttpTextResponse> dartIoGet(
  Uri uri,
  Map<String, String> headers, {
  Duration timeout = const Duration(seconds: 15),
}) async {
  final client = HttpClient()..connectionTimeout = timeout;
  try {
    final request = await client.getUrl(uri).timeout(timeout);
    headers.forEach(request.headers.set);
    final response = await request.close().timeout(timeout);
    final body = await response.transform(utf8.decoder).join().timeout(timeout);
    return HttpTextResponse(response.statusCode, body);
  } finally {
    client.close(force: true);
  }
}
