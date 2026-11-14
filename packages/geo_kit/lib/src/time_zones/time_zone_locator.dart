import 'dart:io';
import 'dart:typed_data';

import 'package:geo_kit/src/time_zones/time_zone_index_reader.dart';

/// Zona horaria IANA a partir de coordenadas, **sin conexión**.
///
/// Usa los límites de *timezone-boundary-builder* (incluye océanos),
/// simplificados a ~500 m y empaquetados en `assets/timezones.bin.gz`
/// (≈ 1.2 MB). Datos © OpenStreetMap contributors, licencia ODbL 1.0.
/// Para regenerarlos: `tools/timezones/build_timezones.py`.
class TimeZoneLocator {
  new _(TimeZoneIndexData data)
    : zones = List.unmodifiable(data.zones),
      dataVersion = data.dataVersion,
      _polygons = data.polygons;

  /// Crea el localizador desde el archivo comprimido con gzip.
  factory fromGzip(List<int> gzBytes) => TimeZoneLocator._(
    readTimeZoneIndex(Uint8List.fromList(gzip.decode(gzBytes))),
  );

  /// Ruta del archivo de datos dentro del paquete.
  static const String assetPath = 'assets/timezones.bin.gz';

  /// Ruta del archivo como asset de Flutter (desde la app).
  static const String flutterAssetKey = 'packages/geo_kit/$assetPath';

  /// Atribución obligatoria de los datos (ODbL).
  static const String attribution =
      'Zonas horarias: timezone-boundary-builder, '
      '© OpenStreetMap contributors (ODbL)';

  /// Nombres IANA incluidos.
  final List<String> zones;

  /// Versión de los datos de límites (p. ej. "2026f").
  final String dataVersion;

  final List<TimeZonePolygon> _polygons;

  /// Zona IANA en [latitude], [longitude] (grados). Siempre devuelve una
  /// zona: en el mar o en un hueco de la simplificación usa la zona
  /// náutica `Etc/GMT±N` según la longitud.
  String zoneAt(double latitude, double longitude) {
    final x = (longitude * 100000).round();
    final y = (latitude * 100000).round();
    for (final p in _polygons) {
      if (x < p.minLon || x > p.maxLon || y < p.minLat || y > p.maxLat) {
        continue;
      }
      if (_inside(p.rings, x, y)) return zones[p.zoneIndex];
    }
    return nauticalZone(longitude);
  }

  /// Zona náutica para una longitud: `Etc/GMT+6` = UTC−6 (signo invertido,
  /// convención IANA).
  static String nauticalZone(double longitude) {
    final hours = (longitude / 15).round().clamp(-12, 12);
    if (hours == 0) return 'Etc/GMT';
    return hours > 0 ? 'Etc/GMT-$hours' : 'Etc/GMT+${-hours}';
  }

  /// Regla par-impar sobre todos los anillos (exterior y huecos).
  static bool _inside(List<Int32List> rings, int x, int y) {
    var inside = false;
    for (final r in rings) {
      final n = r.length ~/ 2;
      var j = n - 1;
      for (var i = 0; i < n; i++) {
        final xi = r[2 * i];
        final yi = r[2 * i + 1];
        final xj = r[2 * j];
        final yj = r[2 * j + 1];
        if ((yi > y) != (yj > y) && x < (xj - xi) * (y - yi) / (yj - yi) + xi) {
          inside = !inside;
        }
        j = i;
      }
    }
    return inside;
  }
}
