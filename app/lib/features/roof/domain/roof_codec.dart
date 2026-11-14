import 'dart:convert';

import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';

/// Conversión de la geometría del techo a/desde el JSON que guarda la
/// base (columnas de texto de `packages/persistence`). Todo en metros.
abstract final class RoofCodec {
  /// `[[x,y],...]`.
  static String encodePolygon(List<Vec2> pts) =>
      jsonEncode([for (final p in pts) _round(p).toJson()]);

  /// Lee `[[x,y],...]` (vacío si el texto no es válido).
  static List<Vec2> decodePolygon(String? json) {
    if (json == null || json.isEmpty) return const [];
    try {
      return [for (final p in jsonDecode(json) as List) Vec2.fromJson(p)];
    } on Object {
      return const [];
    }
  }

  /// `[{"a":[x,y],"b":[x,y],"w":ancho}]`.
  static String encodeWalkways(List<Walkway> ws) => jsonEncode([
    for (final w in ws)
      {
        'a': _round(w.start).toJson(),
        'b': _round(w.end).toJson(),
        'w': w.widthM,
      },
  ]);

  /// Lee los pasillos.
  static List<Walkway> decodeWalkways(String? json) {
    if (json == null || json.isEmpty) return const [];
    try {
      return [
        for (final m in jsonDecode(json) as List)
          Walkway(
            Vec2.fromJson((m as Map)['a']),
            Vec2.fromJson(m['b']),
            (m['w'] as num).toDouble(),
          ),
      ];
    } on Object {
      return const [];
    }
  }

  /// `[[azimut, elevación], ...]`.
  static String encodeHorizon(List<HorizonPoint> pts) => jsonEncode([
    for (final p in pts) [_r(p.azimuth), _r(p.elevation)],
  ]);

  /// Lee un perfil de horizonte.
  static List<HorizonPoint> decodeHorizon(String? json) {
    if (json == null || json.isEmpty) return const [];
    try {
      return [
        for (final p in jsonDecode(json) as List)
          (
            azimuth: ((p as List)[0] as num).toDouble(),
            elevation: (p[1] as num).toDouble(),
          ),
      ];
    } on Object {
      return const [];
    }
  }

  /// Línea de calibración a JSON.
  static String encodeLine(MeasuredLine line) => jsonEncode(line.toJson());

  /// Lee una línea de calibración (o `null`).
  static MeasuredLine? decodeLine(String? json) {
    if (json == null || json.isEmpty) return null;
    try {
      return MeasuredLine.fromJson(
        (jsonDecode(json) as Map).cast<String, Object?>(),
      );
    } on Object {
      return null;
    }
  }

  // Milímetros bastan; evita JSON con 16 decimales.
  static Vec2 _round(Vec2 p) => Vec2(_r(p.x), _r(p.y));
  static double _r(double v) => (v * 1000).roundToDouble() / 1000;
}
