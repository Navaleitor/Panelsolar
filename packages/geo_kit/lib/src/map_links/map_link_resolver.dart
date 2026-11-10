import 'package:geo_kit/src/map_links/map_link_parser.dart';
import 'package:geo_kit/src/map_links/map_link_result.dart';

/// Pide al servidor de [uri] **una** respuesta sin seguir redirecciones y
/// devuelve el destino (`Location`), o `null` si no redirige.
///
/// La implementación con HTTP vive en la app; aquí solo se usa la
/// interfaz para que `geo_kit` siga sin depender de la red.
typedef RedirectFetcher = Future<Uri?> Function(Uri uri);

/// Lee un enlace compartido y, si es corto, sigue sus redirecciones hasta
/// encontrar coordenadas (o un lugar en texto).
class MapLinkResolver {
  /// Crea el resolvedor con la función que consulta redirecciones.
  const new(this._fetchRedirect, {this.maxRedirects = 5});

  final RedirectFetcher _fetchRedirect;

  /// Máximo de saltos a seguir (evita ciclos).
  final int maxRedirects;

  /// Interpreta [input]; si contiene un enlace corto lo expande.
  ///
  /// Devuelve [MapLinkNeedsExpansion] solo si se agotaron los saltos o el
  /// servidor dejó de redirigir sin llegar a un enlace de mapa reconocible.
  Future<MapLinkResult> resolve(String input) async {
    var result = MapLinkParser.parse(input);
    var hops = 0;
    while (result is MapLinkNeedsExpansion && hops < maxRedirects) {
      final current = result.uri;
      final next = await _fetchRedirect(current);
      if (next == null) return result;
      final absolute = current.resolveUri(next);
      hops++;
      final parsed = MapLinkParser.parseUri(absolute);
      // Un salto intermedio a otro dominio (p. ej. página de consentimiento)
      // que trae el destino en `continue`: seguir desde ahí.
      if (parsed is MapLinkUnrecognized) {
        final inner = absolute.queryParameters['continue'];
        if (inner == null) return const MapLinkUnrecognized();
        result = MapLinkParser.parse(inner);
      } else {
        result = parsed;
      }
    }
    return result;
  }
}
