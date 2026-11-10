import 'dart:async';
import 'dart:io';

import 'package:panelsolar/core/app_info.dart';

/// Pide [uri] **sin** seguir redirecciones y devuelve el destino
/// (`Location`), o `null` si no redirige. Es la pieza de red de
/// `MapLinkResolver` (`geo_kit`) para expandir enlaces cortos.
///
/// Solo se lee la cabecera de redirección: no se descarga ni se muestra
/// ningún contenido del proveedor del mapa (ADR-005).
Future<Uri?> fetchRedirect(
  Uri uri, {
  Duration timeout = const Duration(seconds: 10),
}) async {
  if (uri.scheme != 'https' && uri.scheme != 'http') return null;
  final client = HttpClient()
    ..connectionTimeout = timeout
    ..userAgent = AppInfo.userAgent;
  try {
    final request = await client.getUrl(uri).timeout(timeout);
    request.followRedirects = false;
    final response = await request.close().timeout(timeout);
    await response.drain<void>();
    if (!response.isRedirect) return null;
    final location = response.headers.value(HttpHeaders.locationHeader);
    return location == null ? null : Uri.tryParse(location);
  } finally {
    client.close(force: true);
  }
}
