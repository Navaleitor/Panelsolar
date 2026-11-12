import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:data_sources/src/geocoding/geocoder.dart';
import 'package:data_sources/src/geocoding/http_transport.dart';
import 'package:data_sources/src/geocoding/rate_limiter.dart';

/// [Geocoder] con Nominatim (OpenStreetMap), cumpliendo su política de uso
/// (ADR-004): máximo 1 petición/s, User-Agent propio, sin autocompletar
/// (solo se busca al confirmar) y atribución visible.
///
/// La URL es configurable para poder cambiar a otro servidor compatible
/// (propio o de pago) sin cambiar el código de las pantallas.
class NominatimGeocoder implements Geocoder {
  /// Crea el cliente. [userAgent] es obligatorio por la política de uso
  /// (p. ej. `Panelsolar/0.1.0`).
  new({
    required this.userAgent,
    Uri? baseUri,
    HttpGetter? httpGet,
    RateLimiter? rateLimiter,
  }) : baseUri = baseUri ?? defaultBaseUri,
       _get = httpGet ?? dartIoGet,
       _limiter = rateLimiter ?? RateLimiter(const Duration(seconds: 1));

  /// Servidor público de OpenStreetMap.
  static final Uri defaultBaseUri = Uri.parse(
    'https://nominatim.openstreetmap.org',
  );

  /// Raíz del servicio (sin `/search`).
  final Uri baseUri;

  /// User-Agent enviado en cada petición.
  final String userAgent;

  final HttpGetter _get;
  final RateLimiter _limiter;

  @override
  String get attribution => '© OpenStreetMap contributors (ODbL)';

  @override
  Future<List<GeocodeResult>> search(
    String query, {
    String? languageCode,
    int limit = 5,
  }) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return const [];
    final uri = baseUri.replace(
      path: '${baseUri.path.replaceFirst(RegExp(r'/$'), '')}/search',
      queryParameters: {
        'q': trimmed,
        'format': 'jsonv2',
        'limit': '$limit',
        'accept-language': ?languageCode,
      },
    );
    final HttpTextResponse response;
    try {
      response = await _limiter.run(
        () =>
            _get(uri, {'User-Agent': userAgent, 'Accept': 'application/json'}),
      );
    } on SocketException catch (e) {
      throw GeocodingException(GeocodingFailure.network, '$e');
    } on HttpException catch (e) {
      throw GeocodingException(GeocodingFailure.network, '$e');
    } on TimeoutException catch (e) {
      throw GeocodingException(GeocodingFailure.network, '$e');
    }
    if (response.statusCode == 429 || response.statusCode == 403) {
      throw GeocodingException(
        GeocodingFailure.rateLimited,
        'HTTP ${response.statusCode}',
      );
    }
    if (response.statusCode != 200) {
      throw GeocodingException(
        GeocodingFailure.badResponse,
        'HTTP ${response.statusCode}',
      );
    }
    return _parse(response.body);
  }

  List<GeocodeResult> _parse(String body) {
    try {
      final data = jsonDecode(body) as List<Object?>;
      return [
        for (final item in data.cast<Map<String, Object?>>())
          GeocodeResult(
            latitude: double.parse(item['lat']! as String),
            longitude: double.parse(item['lon']! as String),
            displayName: item['display_name']! as String,
          ),
      ];
    } on Object catch (e) {
      throw GeocodingException(GeocodingFailure.badResponse, '$e');
    }
  }
}
