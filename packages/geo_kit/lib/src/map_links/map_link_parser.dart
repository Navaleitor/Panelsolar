import 'package:geo_kit/src/lat_lng.dart';
import 'package:geo_kit/src/map_links/coordinate_text.dart';
import 'package:geo_kit/src/map_links/map_link_result.dart';

/// Lee coordenadas de lo que el usuario pega: un enlace compartido de
/// Google Maps o Apple Maps, un texto que lo contiene, un `geo:` o un par
/// de coordenadas escrito a mano. No usa red: los enlaces cortos se marcan
/// como [MapLinkNeedsExpansion] (ver `MapLinkResolver`).
///
/// Orden de prioridad dentro de un enlace (del más preciso al menos):
/// 1. `!3d<lat>!4d<lon>` (el pin del lugar en Google Maps);
/// 2. parámetros `q`, `query`, `ll`, `coordinate`, `destination`, `daddr`,
///    `center`, `sll`, `saddr` con coordenadas;
/// 3. `@lat,lon` (centro de la vista en Google Maps);
/// 4. coordenadas como segmento de la ruta (`/maps/search/25.6,-100.3`);
/// 5. si no hay coordenadas, el lugar en texto ([MapLinkPlaceQuery]).
abstract final class MapLinkParser {
  /// Dominios de enlaces cortos que solo redirigen al enlace completo.
  static const shortLinkHosts = {
    'maps.app.goo.gl',
    'goo.gl',
    'g.co',
    'maps.apple',
    'apple.co',
  };

  static final _urlInText = RegExp(r'(?:https?://|geo:)[^\s<>"]+');
  static final _pinPattern = RegExp(
    r'!3d(-?\d+(?:\.\d+)?)!4d(-?\d+(?:\.\d+)?)',
  );
  static final _atPattern = RegExp(r'@(-?\d+(?:\.\d+)?),(-?\d+(?:\.\d+)?)');
  static const _coordinateParams = [
    'q',
    'query',
    'll',
    'coordinate',
    'destination',
    'daddr',
    'center',
    'sll',
    'saddr',
  ];
  static const _textParams = ['q', 'query', 'address', 'daddr', 'destination'];

  /// Interpreta [input] (texto libre que puede contener un enlace).
  static MapLinkResult parse(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) return const MapLinkUnrecognized();

    final urlMatch = _urlInText.firstMatch(trimmed);
    if (urlMatch == null) {
      final point = parseCoordinateText(trimmed);
      return point == null
          ? const MapLinkUnrecognized()
          : MapLinkCoordinates(point);
    }
    final uri = Uri.tryParse(_stripTrailingPunctuation(urlMatch.group(0)!));
    if (uri == null) return const MapLinkUnrecognized();
    return parseUri(uri);
  }

  /// Interpreta un enlace ya separado del texto.
  static MapLinkResult parseUri(Uri uri) {
    if (uri.scheme == 'geo') return _parseGeo(uri);

    final host = uri.host.toLowerCase();
    if (_isShortLink(host, uri.path)) return MapLinkNeedsExpansion(uri);
    if (!_isMapHost(host, uri.path)) return const MapLinkUnrecognized();

    final decoded = Uri.decodeFull(uri.toString());
    final pins = _pinPattern.allMatches(decoded).toList();
    if (pins.isNotEmpty) {
      final point = _pair(pins.last.group(1)!, pins.last.group(2)!);
      if (point != null) return MapLinkCoordinates(point, source: uri);
    }

    final params = uri.queryParameters;
    for (final name in _coordinateParams) {
      final value = params[name];
      if (value == null) continue;
      final point = parseCoordinateText(_stripLocPrefix(value));
      if (point != null) return MapLinkCoordinates(point, source: uri);
    }

    final at = _atPattern.firstMatch(decoded);
    if (at != null) {
      final point = _pair(at.group(1)!, at.group(2)!);
      if (point != null) return MapLinkCoordinates(point, source: uri);
    }

    for (final segment in uri.pathSegments.reversed) {
      final point = parseCoordinateText(segment);
      if (point != null) return MapLinkCoordinates(point, source: uri);
    }

    final query = _placeText(uri);
    if (query != null) return MapLinkPlaceQuery(query, source: uri);
    return const MapLinkUnrecognized();
  }

  static bool _isShortLink(String host, String path) {
    if (host == 'goo.gl') return path.startsWith('/maps');
    if (host == 'g.co') return path.startsWith('/kgs');
    return shortLinkHosts.contains(host);
  }

  static bool _isMapHost(String host, String path) {
    if (host == 'maps.apple.com') return true;
    final isGoogle = RegExp(r'(^|\.)google\.[a-z]{2,3}(\.[a-z]{2})?$')
        .hasMatch(host);
    if (!isGoogle) return false;
    return host.startsWith('maps.') || path.startsWith('/maps');
  }

  static MapLinkResult _parseGeo(Uri uri) {
    // geo:lat,lon;u=35?q=lat,lon(Etiqueta)  — RFC 5870 / Android.
    final raw = uri.toString().substring(4);
    final pathPart = raw.split('?').first.split(';').first;
    final q = uri.queryParameters['q'];
    final fromQ = q == null
        ? null
        : parseCoordinateText(q.replaceAll(RegExp(r'\(.*$'), ''));
    final fromPath = parseCoordinateText(pathPart);
    final point = (fromPath != null && fromPath != const LatLng(0, 0))
        ? fromPath
        : fromQ;
    if (point != null) return MapLinkCoordinates(point, source: uri);
    if (q != null && q.trim().isNotEmpty) {
      return MapLinkPlaceQuery(q.trim(), source: uri);
    }
    return const MapLinkUnrecognized();
  }

  static String? _placeText(Uri uri) {
    for (final name in _textParams) {
      final value = uri.queryParameters[name]?.trim();
      if (value != null && value.isNotEmpty) return value;
    }
    final segments = uri.pathSegments;
    final placeIndex = segments.indexOf('place');
    if (placeIndex >= 0 && placeIndex + 1 < segments.length) {
      final name = segments[placeIndex + 1].replaceAll('+', ' ').trim();
      if (name.isNotEmpty && !name.startsWith('@')) return name;
    }
    final name = uri.queryParameters['name']?.trim();
    return (name == null || name.isEmpty) ? null : name;
  }

  static LatLng? _pair(String lat, String lon) =>
      LatLng.tryCreate(double.parse(lat), double.parse(lon));

  static String _stripLocPrefix(String value) =>
      value.trim().replaceFirst(RegExp('^loc:', caseSensitive: false), '');

  /// Quita la puntuación pegada al final del enlace dentro de un texto
  /// ("...?q=1,2)." → "...?q=1,2"), pero conserva un `)` que cierra un
  /// `(` del propio enlace, como en `geo:0,0?q=1,2(Casa)`.
  static String _stripTrailingPunctuation(String url) {
    var result = url.replaceFirst(RegExp(r'[.,;:!?\]]+$'), '');
    while (result.endsWith(')') &&
        ')'.allMatches(result).length > '('.allMatches(result).length) {
      result = result
          .substring(0, result.length - 1)
          .replaceFirst(RegExp(r'[.,;:!?\]]+$'), '');
    }
    return result;
  }
}
