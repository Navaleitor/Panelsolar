import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:geo_kit/geo_kit.dart';
import 'package:solar_engine/solar_engine.dart';

/// Un lugar para un panel en un plano (metros locales).
///
/// - `corners[0] → corners[1]`: a lo largo de la fila (abajo).
/// - `corners[0] → corners[3]`: cuesta arriba.
/// - [on]: `false` si el usuario lo quitó o si el cálculo del máximo lo
///   dejó fuera por sombra (se puede volver a poner con un toque).
@immutable
class DesignPanel {
  /// Crea el panel.
  const new({
    required this.corners,
    required this.row,
    required this.column,
    this.on = true,
  });

  /// Lee el panel del JSON `{"c":[[x,y]...],"r":0,"k":0,"on":true}`.
  factory fromJson(Map<String, Object?> j) => DesignPanel(
    corners: [for (final p in j['c']! as List) Vec2.fromJson(p)],
    row: (j['r'] as num?)?.toInt() ?? 0,
    column: (j['k'] as num?)?.toInt() ?? 0,
    on: j['on'] as bool? ?? true,
  );

  /// Esquinas.
  final List<Vec2> corners;

  /// Fila.
  final int row;

  /// Columna.
  final int column;

  /// Activo.
  final bool on;

  /// Centro.
  Vec2 get center => (corners[0] + corners[2]) * 0.5;

  /// Copia con otro estado.
  DesignPanel withOn({required bool on}) =>
      DesignPanel(corners: corners, row: row, column: column, on: on);

  /// JSON.
  Map<String, Object?> toJson() => {
    'c': [for (final p in corners) p.toJson()],
    'r': row,
    'k': column,
    'on': on,
  };

  /// Lista → JSON.
  static String encodeList(List<DesignPanel> panels) =>
      jsonEncode([for (final p in panels) p.toJson()]);

  /// JSON → lista (vacía si está mal).
  static List<DesignPanel> decodeList(String json) {
    try {
      final list = jsonDecode(json) as List;
      return [
        for (final e in list)
          if (e is Map<String, Object?> && e['c'] is List)
            DesignPanel.fromJson(e),
      ];
    } on FormatException {
      return const [];
    }
  }
}

/// Pérdidas editables (B.6 punto 8) ↔ JSON de `pv_designs.losses`.
abstract final class LossesCodec {
  /// JSON → pérdidas (valores por defecto del plan si faltan).
  static SystemLosses decode(String json) {
    Map<String, Object?> m;
    try {
      m = (jsonDecode(json) as Map).cast<String, Object?>();
    } on Object {
      m = const {};
    }
    double? v(String k) => (m[k] as num?)?.toDouble();
    return const SystemLosses().copyWith(
      soiling: v('soiling'),
      mismatch: v('mismatch'),
      wiring: v('wiring'),
      connections: v('connections'),
      lid: v('lid'),
      nameplate: v('nameplate'),
      availability: v('availability'),
      snow: v('snow'),
      annualDegradation: v('annualDegradation'),
    );
  }

  /// Pérdidas → JSON.
  static String encode(SystemLosses l) => jsonEncode({
    'soiling': l.soiling,
    'mismatch': l.mismatch,
    'wiring': l.wiring,
    'connections': l.connections,
    'lid': l.lid,
    'nameplate': l.nameplate,
    'availability': l.availability,
    'snow': l.snow,
    'annualDegradation': l.annualDegradation,
  });
}

/// Ajustes del cálculo de viento (JSON de `pv_designs.wind`).
@immutable
class WindSettings {
  /// Crea los ajustes.
  const new({
    this.city,
    this.speedKmh = 140,
    this.exposure = WindExposure.c,
    this.heightM = 6,
    this.gcrn = -1.5,
    this.anchorsPerPanel = 4,
  });

  /// Lee el JSON (valores por defecto si faltan).
  factory decode(String json) {
    Map<String, Object?> m;
    try {
      m = (jsonDecode(json) as Map).cast<String, Object?>();
    } on Object {
      m = const {};
    }
    return WindSettings(
      city: m['city'] as String?,
      speedKmh: (m['speedKmh'] as num?)?.toDouble() ?? 140,
      exposure:
          WindExposure.values.asNameMap()[m['exposure']] ?? WindExposure.c,
      heightM: (m['heightM'] as num?)?.toDouble() ?? 6,
      gcrn: (m['gcrn'] as num?)?.toDouble() ?? -1.5,
      anchorsPerPanel: (m['anchors'] as num?)?.toInt() ?? 4,
    );
  }

  /// Ciudad de referencia elegida.
  final String? city;

  /// Velocidad regional (km/h).
  final double speedKmh;

  /// Exposición.
  final WindExposure exposure;

  /// Altura del techo (m).
  final double heightM;

  /// Coeficiente neto GCrn.
  final double gcrn;

  /// Anclajes por panel.
  final int anchorsPerPanel;

  /// JSON.
  String encode() => jsonEncode({
    'city': ?city,
    'speedKmh': speedKmh,
    'exposure': exposure.name,
    'heightM': heightM,
    'gcrn': gcrn,
    'anchors': anchorsPerPanel,
  });
}
