import 'package:geo_kit/geo_kit.dart';
import 'package:test/test.dart';

/// Afirma que [input] produce las coordenadas esperadas.
void expectPoint(String input, double lat, double lon) {
  final result = MapLinkParser.parse(input);
  expect(result, isA<MapLinkCoordinates>(), reason: input);
  final point = (result as MapLinkCoordinates).point;
  expect(point.latitude, closeTo(lat, 1e-6), reason: input);
  expect(point.longitude, closeTo(lon, 1e-6), reason: input);
}

void main() {
  group('Google Maps', () {
    test('vista con @lat,lon,zoom', () {
      expectPoint(
        'https://www.google.com/maps/@25.6866142,-100.3161126,17z',
        25.6866142,
        -100.3161126,
      );
    });

    test('lugar: prefiere el pin !3d!4d sobre el centro @', () {
      expectPoint(
        'https://www.google.com/maps/place/Macroplaza/@25.6700,-100.3100,17z/'
        'data=!3m1!4b1!4m6!3m5!1s0x866295!8m2!3d25.6694!4d-100.3097',
        25.6694,
        -100.3097,
      );
    });

    test('?q=lat,lon con + y espacios codificados', () {
      expectPoint(
        'https://maps.google.com/?q=25.6866,+-100.3161',
        25.6866,
        -100.3161,
      );
      expectPoint(
        'https://maps.google.com/maps?q=loc:19.4326%2C-99.1332',
        19.4326,
        -99.1332,
      );
    });

    test('API de URLs: ?api=1&query=lat,lon', () {
      expectPoint(
        'https://www.google.com/maps/search/?api=1&query=20.6597,-103.3496',
        20.6597,
        -103.3496,
      );
    });

    test('dominio de país y coordenadas como segmento', () {
      expectPoint(
        'https://www.google.com.mx/maps/search/29.0729,+-110.9559',
        29.0729,
        -110.9559,
      );
    });

    test('lugar en grados, minutos y segundos', () {
      expectPoint(
        'https://www.google.com/maps/place/'
        "25%C2%B041'11.8%22N+100%C2%B018'58.0%22W",
        25.686611,
        -100.316111,
      );
    });

    test('enlace dentro de un texto compartido', () {
      expectPoint(
        'Casa de Ana\nhttps://www.google.com/maps?q=25.6,-100.3 (mándamelo)',
        25.6,
        -100.3,
      );
    });

    test('enlace sin coordenadas: devuelve el lugar para geocodificar', () {
      final result = MapLinkParser.parse(
        'https://www.google.com/maps/place/Parque+Fundidora,+Monterrey',
      );
      expect(result, isA<MapLinkPlaceQuery>());
      expect(
        (result as MapLinkPlaceQuery).query,
        'Parque Fundidora, Monterrey',
      );
    });

    test('enlaces cortos se marcan para expandir', () {
      for (final url in [
        'https://maps.app.goo.gl/AbCdEf123',
        'https://goo.gl/maps/xyz987',
        'https://g.co/kgs/abc',
      ]) {
        expect(
          MapLinkParser.parse(url),
          isA<MapLinkNeedsExpansion>(),
          reason: url,
        );
      }
    });

    test('google.com sin /maps no es un enlace de mapa', () {
      expect(
        MapLinkParser.parse('https://www.google.com/search?q=25.6,-100.3'),
        isA<MapLinkUnrecognized>(),
      );
    });
  });

  group('Apple Maps', () {
    test('?ll= y ?q=', () {
      expectPoint(
        'https://maps.apple.com/?ll=25.6866,-100.3161&q=Pin',
        25.6866,
        -100.3161,
      );
      expectPoint(
        'http://maps.apple.com/?q=19.4326,-99.1332',
        19.4326,
        -99.1332,
      );
    });

    test('formato nuevo /place?coordinate=', () {
      expectPoint(
        'https://maps.apple.com/place?coordinate=20.6597,-103.3496'
        '&name=Ubicaci%C3%B3n+marcada',
        20.6597,
        -103.3496,
      );
    });

    test('?address= con ?ll= prefiere coordenadas', () {
      expectPoint(
        'https://maps.apple.com/?address=Av.+Constituci%C3%B3n+100,+Monterrey'
        '&auid=123&ll=25.6694,-100.3097&lsp=9902&q=Macroplaza',
        25.6694,
        -100.3097,
      );
    });

    test('solo dirección: devuelve el lugar', () {
      final result = MapLinkParser.parse(
        'https://maps.apple.com/?address=Calle+Morelos+5,+Saltillo',
      );
      expect((result as MapLinkPlaceQuery).query, 'Calle Morelos 5, Saltillo');
    });

    test('enlace corto maps.apple', () {
      expect(
        MapLinkParser.parse('https://maps.apple/p/AbC.dEf'),
        isA<MapLinkNeedsExpansion>(),
      );
    });
  });

  group('otros formatos', () {
    test('geo: de Android', () {
      expectPoint('geo:25.6866,-100.3161', 25.6866, -100.3161);
      expectPoint('geo:0,0?q=25.6866,-100.3161(Casa)', 25.6866, -100.3161);
    });

    test('texto con coordenadas decimales', () {
      expectPoint('25.6866, -100.3161', 25.6866, -100.3161);
      expectPoint('  -33.45 -70.66 ', -33.45, -70.66);
    });

    test('texto en grados, minutos y segundos (N/S y E/W/O)', () {
      expectPoint(
        '25°41\u{27}11.8"N 100°18\u{27}58.0"W',
        25.686611,
        -100.316111,
      );
      expectPoint(
        '100°18\u{27}58.0"O, 25°41\u{27}11.8"N',
        25.686611,
        -100.316111,
      );
      expectPoint("33°27'S 70°40'W", -33.45, -70.666667);
    });

    test('fuera de rango o basura: no reconocido', () {
      for (final input in [
        '',
        'hola',
        '95.0, 10.0',
        '10.0, 190.0',
        'https://example.com/?q=25.6,-100.3',
      ]) {
        expect(
          MapLinkParser.parse(input),
          isA<MapLinkUnrecognized>(),
          reason: input,
        );
      }
    });
  });
}
