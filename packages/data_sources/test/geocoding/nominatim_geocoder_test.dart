import 'dart:io';

import 'package:data_sources/geocoding.dart';
import 'package:test/test.dart';

const _body = '''
[
  {"lat": "25.6694", "lon": "-100.3097", "display_name": "Macroplaza, Monterrey, Nuevo León, México"},
  {"lat": "25.6700", "lon": "-100.3100", "display_name": "Centro, Monterrey"}
]
''';

void main() {
  late List<(Uri, Map<String, String>)> requests;

  NominatimGeocoder geocoder({
    HttpTextResponse response = const HttpTextResponse(200, _body),
    Exception? error,
    Uri? baseUri,
  }) {
    requests = [];
    return NominatimGeocoder(
      userAgent: 'Panelsolar/0.1.0',
      baseUri: baseUri,
      rateLimiter: RateLimiter(Duration.zero),
      httpGet: (uri, headers) async {
        requests.add((uri, headers));
        if (error != null) throw error;
        return response;
      },
    );
  }

  test('convierte la respuesta jsonv2 en resultados', () async {
    final results = await geocoder().search('Macroplaza, Monterrey');
    expect(results, hasLength(2));
    expect(results.first.latitude, 25.6694);
    expect(results.first.longitude, -100.3097);
    expect(results.first.displayName, startsWith('Macroplaza'));
  });

  test('envía User-Agent propio, formato, límite e idioma', () async {
    await geocoder().search('  Av. Constitución 100  ', languageCode: 'es');
    final (uri, headers) = requests.single;
    expect(uri.host, 'nominatim.openstreetmap.org');
    expect(uri.path, '/search');
    expect(uri.queryParameters, {
      'q': 'Av. Constitución 100',
      'format': 'jsonv2',
      'limit': '5',
      'accept-language': 'es',
    });
    expect(headers['User-Agent'], 'Panelsolar/0.1.0');
  });

  test('la URL del servicio es configurable', () async {
    await geocoder(baseUri: Uri.parse('https://geo.example.com/nominatim/'))
        .search('x');
    expect(
      requests.single.$1.toString(),
      startsWith('https://geo.example.com/nominatim/search?'),
    );
  });

  test('búsqueda vacía no hace petición', () async {
    expect(await geocoder().search('   '), isEmpty);
    expect(requests, isEmpty);
  });

  test('429 y 403 → rateLimited', () async {
    for (final code in [429, 403]) {
      await expectLater(
        geocoder(response: HttpTextResponse(code, '')).search('x'),
        throwsA(
          isA<GeocodingException>().having(
            (e) => e.failure,
            'failure',
            GeocodingFailure.rateLimited,
          ),
        ),
      );
    }
  });

  test('sin red → network; respuesta rara → badResponse', () async {
    await expectLater(
      geocoder(error: const SocketException('sin red')).search('x'),
      throwsA(
        isA<GeocodingException>().having(
          (e) => e.failure,
          'failure',
          GeocodingFailure.network,
        ),
      ),
    );
    await expectLater(
      geocoder(response: const HttpTextResponse(200, '{"x":1}')).search('x'),
      throwsA(
        isA<GeocodingException>().having(
          (e) => e.failure,
          'failure',
          GeocodingFailure.badResponse,
        ),
      ),
    );
    await expectLater(
      geocoder(response: const HttpTextResponse(500, '')).search('x'),
      throwsA(isA<GeocodingException>()),
    );
  });

  test('muestra la atribución de OpenStreetMap', () {
    expect(geocoder().attribution, contains('OpenStreetMap'));
  });
}
