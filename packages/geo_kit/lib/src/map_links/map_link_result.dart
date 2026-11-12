import 'package:geo_kit/src/lat_lng.dart';

/// Resultado de leer un enlace o texto de ubicación compartido.
sealed class MapLinkResult {
  const new();
}

/// Se encontraron coordenadas.
final class MapLinkCoordinates extends MapLinkResult {
  /// [point] encontrado en [source] (el enlace final, ya expandido).
  const new(this.point, {this.source});

  /// Coordenadas leídas.
  final LatLng point;

  /// Enlace del que se leyeron (o `null` si fue texto suelto).
  final Uri? source;
}

/// Enlace corto (p. ej. `maps.app.goo.gl/...`): hay que seguir su
/// redirección para conocer el enlace completo.
final class MapLinkNeedsExpansion extends MapLinkResult {
  /// Enlace corto [uri].
  const new(this.uri);

  /// Enlace corto a expandir.
  final Uri uri;
}

/// El enlace no trae coordenadas pero sí un lugar o dirección en texto,
/// que se puede buscar con el geocodificador.
final class MapLinkPlaceQuery extends MapLinkResult {
  /// Texto [query] encontrado en [source].
  const new(this.query, {required this.source});

  /// Lugar o dirección (ya decodificado).
  final String query;

  /// Enlace del que se leyó.
  final Uri source;
}

/// No se reconoció ningún enlace de mapa ni coordenadas.
final class MapLinkUnrecognized extends MapLinkResult {
  /// Resultado vacío.
  const new();
}
