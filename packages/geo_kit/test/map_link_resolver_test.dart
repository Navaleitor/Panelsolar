import 'package:geo_kit/geo_kit.dart';
import 'package:test/test.dart';

void main() {
  test('expande un enlace corto de Google siguiendo la redirección', () async {
    final calls = <Uri>[];
    final resolver = MapLinkResolver((uri) async {
      calls.add(uri);
      return Uri.parse(
        'https://www.google.com/maps/place/X/@25.1,-100.1,17z/data=!3d25.2!4d-100.2',
      );
    });

    final result = await resolver.resolve(
      'Mira: https://maps.app.goo.gl/AbC123',
    );

    expect(calls.single.toString(), 'https://maps.app.goo.gl/AbC123');
    final coords = result as MapLinkCoordinates;
    expect(coords.point, const LatLng(25.2, -100.2));
    expect(coords.source!.host, 'www.google.com');
  });

  test('sigue varias redirecciones (corto → corto → completo)', () async {
    final hops = {
      'https://goo.gl/maps/a': 'https://maps.app.goo.gl/b',
      'https://maps.app.goo.gl/b': 'https://maps.apple.com/?ll=19.4,-99.1',
    };
    final resolver = MapLinkResolver(
      (uri) async => Uri.parse(hops[uri.toString()]!),
    );
    final result = await resolver.resolve('https://goo.gl/maps/a');
    expect((result as MapLinkCoordinates).point, const LatLng(19.4, -99.1));
  });

  test('acepta redirecciones relativas', () async {
    final resolver = MapLinkResolver(
      (uri) async => uri.host == 'maps.apple'
          ? Uri.parse('https://maps.apple.com/place?coordinate=20.1,-103.2')
          : null,
    );
    final result = await resolver.resolve('https://maps.apple/p/xyz');
    expect((result as MapLinkCoordinates).point, const LatLng(20.1, -103.2));
  });

  test('página de consentimiento: usa el destino de "continue"', () async {
    final resolver = MapLinkResolver(
      (uri) async => Uri.https('consent.google.com', '/ml', {
        'continue': 'https://www.google.com/maps?q=25.5,-100.5',
      }),
    );
    final result = await resolver.resolve('https://maps.app.goo.gl/zzz');
    expect((result as MapLinkCoordinates).point, const LatLng(25.5, -100.5));
  });

  test('si el servidor no redirige devuelve NeedsExpansion', () async {
    final resolver = MapLinkResolver((uri) async => null);
    final result = await resolver.resolve('https://maps.app.goo.gl/zzz');
    expect(result, isA<MapLinkNeedsExpansion>());
  });

  test('corta los ciclos de redirección', () async {
    var count = 0;
    final resolver = MapLinkResolver((uri) async {
      count++;
      return Uri.parse('https://maps.app.goo.gl/loop');
    }, maxRedirects: 3);
    final result = await resolver.resolve('https://maps.app.goo.gl/loop');
    expect(result, isA<MapLinkNeedsExpansion>());
    expect(count, 3);
  });

  test('enlace largo no hace peticiones', () async {
    final resolver = MapLinkResolver((uri) async => fail('no debe pedir nada'));
    final result = await resolver.resolve('https://maps.apple.com/?ll=1,2');
    expect((result as MapLinkCoordinates).point, const LatLng(1, 2));
  });
}
