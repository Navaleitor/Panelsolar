import 'dart:convert';
import 'dart:typed_data';

/// Polígono de una zona horaria ya decodificado (coordenadas en 1e-5°).
class TimeZonePolygon {
  /// Crea el polígono.
  new({
    required this.zoneIndex,
    required this.minLon,
    required this.minLat,
    required this.maxLon,
    required this.maxLat,
    required this.rings,
  });

  /// Índice de la zona en la lista de nombres.
  final int zoneIndex;

  /// Longitud mínima de la caja envolvente (1e-5°).
  final int minLon;

  /// Latitud mínima de la caja envolvente (1e-5°).
  final int minLat;

  /// Longitud máxima de la caja envolvente (1e-5°).
  final int maxLon;

  /// Latitud máxima de la caja envolvente (1e-5°).
  final int maxLat;

  /// Anillos: [lon0, lat0, lon1, lat1, ...] en 1e-5°. El primero es el
  /// exterior; los demás, huecos.
  final List<Int32List> rings;
}

/// Contenido del archivo `timezones.bin` (ver
/// `tools/timezones/build_timezones.py` para el formato).
typedef TimeZoneIndexData = ({
  List<String> zones,
  String dataVersion,
  List<TimeZonePolygon> polygons,
});

/// Lee el formato binario "PSTZ" versión 1 (ya descomprimido).
TimeZoneIndexData readTimeZoneIndex(Uint8List bytes) {
  final data = ByteData.sublistView(bytes);
  var offset = 0;
  int u8() => data.getUint8(offset++);
  int u16() {
    final v = data.getUint16(offset, Endian.little);
    offset += 2;
    return v;
  }

  int u32() {
    final v = data.getUint32(offset, Endian.little);
    offset += 4;
    return v;
  }

  int i32() {
    final v = data.getInt32(offset, Endian.little);
    offset += 4;
    return v;
  }

  String str() {
    final len = u8();
    final s = utf8.decode(bytes.sublist(offset, offset + len));
    offset += len;
    return s;
  }

  int varint() {
    var result = 0;
    var shift = 0;
    while (true) {
      final b = u8();
      result |= (b & 0x7F) << shift;
      if (b & 0x80 == 0) break;
      shift += 7;
    }
    // Zigzag → entero con signo.
    return (result >> 1) ^ -(result & 1);
  }

  if (String.fromCharCodes(bytes.sublist(0, 4)) != 'PSTZ') {
    throw const FormatException('No es un índice de zonas horarias PSTZ.');
  }
  offset = 4;
  final version = u16();
  if (version != 1) {
    throw FormatException('Versión de índice no soportada: $version');
  }
  final zones = [for (var i = u16(); i > 0; i--) str()];
  final dataVersion = str();
  final polygons = <TimeZonePolygon>[];
  for (var p = u32(); p > 0; p--) {
    final zone = u16();
    final minLon = i32();
    final minLat = i32();
    final maxLon = i32();
    final maxLat = i32();
    final rings = <Int32List>[];
    for (var r = u16(); r > 0; r--) {
      final n = u32();
      final ring = Int32List(n * 2);
      var x = i32();
      var y = i32();
      ring[0] = x;
      ring[1] = y;
      for (var k = 1; k < n; k++) {
        x += varint();
        y += varint();
        ring[2 * k] = x;
        ring[2 * k + 1] = y;
      }
      rings.add(ring);
    }
    polygons.add(
      TimeZonePolygon(
        zoneIndex: zone,
        minLon: minLon,
        minLat: minLat,
        maxLon: maxLon,
        maxLat: maxLat,
        rings: rings,
      ),
    );
  }
  return (zones: zones, dataVersion: dataVersion, polygons: polygons);
}
