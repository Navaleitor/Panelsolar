import 'package:data_sources/src/geocoding/geocode_cache.dart';
import 'package:data_sources/src/geocoding/geocoder.dart';

/// Envuelve otro [Geocoder] y guarda cada búsqueda en una [GeocodeCache]:
/// la misma dirección no se vuelve a pedir al servicio.
class CachedGeocoder implements Geocoder {
  /// Usa [_inner] solo cuando la búsqueda no está en [_cache].
  const new(this._inner, this._cache);

  final Geocoder _inner;
  final GeocodeCache _cache;

  @override
  String get attribution => _inner.attribution;

  @override
  Future<List<GeocodeResult>> search(
    String query, {
    String? languageCode,
    int limit = 5,
  }) async {
    final key = cacheKey(query, languageCode: languageCode, limit: limit);
    final cached = await _cache.read(key);
    if (cached != null) return cached;
    final results = await _inner.search(
      query,
      languageCode: languageCode,
      limit: limit,
    );
    await _cache.write(key, results);
    return results;
  }

  /// Clave normalizada: minúsculas, espacios colapsados, idioma y límite.
  static String cacheKey(String query, {String? languageCode, int limit = 5}) {
    final normalized = query.trim().toLowerCase().replaceAll(
      RegExp(r'\s+'),
      ' ',
    );
    return '${languageCode ?? '-'}|$limit|$normalized';
  }
}
