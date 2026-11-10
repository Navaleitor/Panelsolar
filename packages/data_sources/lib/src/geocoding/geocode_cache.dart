import 'dart:convert';
import 'dart:io';

import 'package:data_sources/src/geocoding/geocoder.dart';

/// Caché de búsquedas de geocodificación (clave → resultados).
abstract interface class GeocodeCache {
  /// Resultados guardados para [key], o `null` si no hay.
  Future<List<GeocodeResult>?> read(String key);

  /// Guarda [results] para [key].
  Future<void> write(String key, List<GeocodeResult> results);
}

/// Caché en memoria (se pierde al cerrar la app). Útil en pruebas.
class InMemoryGeocodeCache implements GeocodeCache {
  final _entries = <String, List<GeocodeResult>>{};

  @override
  Future<List<GeocodeResult>?> read(String key) async => _entries[key];

  @override
  Future<void> write(String key, List<GeocodeResult> results) async {
    _entries[key] = List.unmodifiable(results);
  }
}

/// Caché persistente en un archivo JSON. Guarda como máximo [maxEntries]
/// búsquedas; al pasarse descarta las más antiguas.
class JsonFileGeocodeCache implements GeocodeCache {
  /// Usa (o crea) el archivo [file].
  new(this.file, {this.maxEntries = 500});

  /// Archivo JSON de la caché.
  final File file;

  /// Máximo de búsquedas guardadas.
  final int maxEntries;

  Map<String, List<GeocodeResult>>? _memory;

  @override
  Future<List<GeocodeResult>?> read(String key) async => (await _load())[key];

  @override
  Future<void> write(String key, List<GeocodeResult> results) async {
    final entries = await _load();
    entries
      ..remove(key)
      ..[key] = List.unmodifiable(results);
    while (entries.length > maxEntries) {
      entries.remove(entries.keys.first);
    }
    final json = {
      for (final MapEntry(:key, :value) in entries.entries)
        key: [for (final r in value) r.toJson()],
    };
    await file.parent.create(recursive: true);
    await file.writeAsString(jsonEncode(json));
  }

  Future<Map<String, List<GeocodeResult>>> _load() async {
    final cached = _memory;
    if (cached != null) return cached;
    final loaded = <String, List<GeocodeResult>>{};
    try {
      if (file.existsSync()) {
        final raw = jsonDecode(await file.readAsString());
        if (raw is Map<String, Object?>) {
          for (final MapEntry(:key, :value) in raw.entries) {
            if (value is! List) continue;
            loaded[key] = [
              for (final item in value)
                GeocodeResult.fromJson((item as Map).cast<String, Object?>()),
            ];
          }
        }
      }
    } on Object {
      // Archivo dañado: se empieza con la caché vacía.
      loaded.clear();
    }
    return _memory = loaded;
  }
}
