import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:solar_engine/solar_engine.dart';

/// Lee un archivo de test/fixtures.
String fixture(String name) => File('test/fixtures/$name').readAsStringSync();

/// Sitio de las respuestas grabadas (Monterrey).
const Site fixtureSite = Site(
  latitude: 25.67,
  longitude: -100.31,
  elevation: 540,
);

/// Cliente falso que responde según la ruta pedida y cuenta las llamadas.
class FakeServer {
  /// Respuestas por fragmento de ruta → (código, cuerpo).
  final Map<String, (int, String)> routes = {};

  /// Número de peticiones recibidas.
  int calls = 0;

  /// Últimas URLs pedidas.
  final List<Uri> requested = [];

  /// Cliente HTTP falso.
  http.Client get client => MockClient((request) async {
    calls++;
    requested.add(request.url);
    for (final e in routes.entries) {
      if (request.url.path.contains(e.key)) {
        return http.Response(e.value.$2, e.value.$1);
      }
    }
    return http.Response('no encontrado', 404);
  });
}
