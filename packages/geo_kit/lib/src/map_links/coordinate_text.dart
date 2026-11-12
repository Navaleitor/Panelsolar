import 'package:geo_kit/src/lat_lng.dart';

final _decimalPair = RegExp(
  r'^\s*([+-]?\d{1,3}(?:\.\d+)?)\s*(?:,|\s)\s*([+-]?\d{1,3}(?:\.\d+)?)\s*$',
);

const _dmsPart =
    r'''(\d{1,3})\s*°\s*(?:(\d{1,2}(?:\.\d+)?)\s*['′]\s*)?'''
    r'''(?:(\d{1,2}(?:\.\d+)?)\s*(?:"|″|'')\s*)?([NSEWnsewOo])''';

final _dmsPair = RegExp('^\\s*$_dmsPart[\\s,]+$_dmsPart\\s*\$');

/// Interpreta un texto con un par de coordenadas.
///
/// Acepta:
/// - decimal: `25.6866, -100.3161`, `25.6866 -100.3161`, `+25.6,-100.3`;
/// - grados, minutos y segundos: `25°41'11.8"N 100°18'58.0"W` (también
///   `O` de "oeste").
///
/// Devuelve `null` si no es un par válido o está fuera de rango.
LatLng? parseCoordinateText(String text) {
  final cleaned = text.replaceAll('+', ' ').replaceAll(RegExp(r'\s+'), ' ');
  final decimal = _decimalPair.firstMatch(cleaned);
  if (decimal != null) {
    return LatLng.tryCreate(
      double.parse(decimal.group(1)!),
      double.parse(decimal.group(2)!),
    );
  }
  final dms = _dmsPair.firstMatch(cleaned);
  if (dms != null) {
    final first = _dmsValue(dms, 1);
    final second = _dmsValue(dms, 5);
    final firstIsLat = 'NS'.contains(dms.group(4)!.toUpperCase());
    final secondIsLat = 'NS'.contains(dms.group(8)!.toUpperCase());
    if (firstIsLat == secondIsLat) return null;
    return firstIsLat
        ? LatLng.tryCreate(first, second)
        : LatLng.tryCreate(second, first);
  }
  return null;
}

double _dmsValue(RegExpMatch m, int start) {
  final degrees = double.parse(m.group(start)!);
  final minutes = double.tryParse(m.group(start + 1) ?? '') ?? 0;
  final seconds = double.tryParse(m.group(start + 2) ?? '') ?? 0;
  final value = degrees + minutes / 60 + seconds / 3600;
  final hemisphere = m.group(start + 3)!.toUpperCase();
  final negative = hemisphere == 'S' || hemisphere == 'W' || hemisphere == 'O';
  return negative ? -value : value;
}
