import 'dart:io';

import 'package:data_sources/geocoding.dart';
import 'package:test/test.dart';

class _CountingGeocoder implements Geocoder {
  int calls = 0;

  @override
  String get attribution => 'test';

  @override
  Future<List<GeocodeResult>> search(
    String query, {
    String? languageCode,
    int limit = 5,
  }) async {
    calls++;
    return [
      GeocodeResult(latitude: 1, longitude: 2, displayName: query.trim()),
    ];
  }
}

void main() {
  test('la misma búsqueda (normalizada) se pide una sola vez', () async {
    final inner = _CountingGeocoder();
    final geocoder = CachedGeocoder(inner, InMemoryGeocodeCache());

    await geocoder.search('Calle Morelos 5', languageCode: 'es');
    final again = await geocoder.search(
      '  calle   MORELOS 5 ',
      languageCode: 'es',
    );
    await geocoder.search('Calle Morelos 5', languageCode: 'en');

    expect(inner.calls, 2);
    expect(again.single.displayName, 'Calle Morelos 5');
  });

  group('JsonFileGeocodeCache', () {
    late Directory dir;

    setUp(() => dir = Directory.systemTemp.createTempSync('geocache'));
    tearDown(() => dir.deleteSync(recursive: true));

    test('persiste entre instancias', () async {
      final file = File('${dir.path}/sub/cache.json');
      await JsonFileGeocodeCache(file).write('k', const [
        GeocodeResult(latitude: 25.5, longitude: -100.5, displayName: 'A'),
      ]);

      final reopened = await JsonFileGeocodeCache(file).read('k');
      expect(reopened!.single.latitude, 25.5);
      expect(reopened.single.displayName, 'A');
      expect(await JsonFileGeocodeCache(file).read('otra'), isNull);
    });

    test('descarta las entradas más antiguas al llenarse', () async {
      final cache = JsonFileGeocodeCache(
        File('${dir.path}/c.json'),
        maxEntries: 2,
      );
      for (final key in ['a', 'b', 'c']) {
        await cache.write(key, const []);
      }
      expect(await cache.read('a'), isNull);
      expect(await cache.read('b'), isEmpty);
      expect(await cache.read('c'), isEmpty);
    });

    test('un archivo dañado se trata como caché vacía', () async {
      final file = File('${dir.path}/bad.json')..writeAsStringSync('{no');
      expect(await JsonFileGeocodeCache(file).read('k'), isNull);
    });
  });
}
