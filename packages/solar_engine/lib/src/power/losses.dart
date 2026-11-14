import 'dart:math' as math;

/// Desglose editable de pérdidas del sistema, en porcentaje (0–100).
/// Se combinan de forma multiplicativa, como `pvlib.pvsystem.pvwatts_losses`.
/// Ficha: docs/formulas/09-perdidas-y-degradacion.md
///
/// Pérdida total = 100·[1 − Π(1 − pᵢ/100)]
class SystemLosses {
  /// Crea el desglose. Valores por defecto del plan maestro (B.6 punto 8).
  const new({
    this.soiling = 2,
    this.shading = 0,
    this.snow = 0,
    this.mismatch = 2,
    this.wiring = 2,
    this.connections = 0.5,
    this.lid = 1.5,
    this.nameplate = 1,
    this.availability = 3,
    this.annualDegradation = 0.5,
  });

  /// Sin pérdidas (útil en pruebas).
  static const SystemLosses none = SystemLosses(
    soiling: 0,
    mismatch: 0,
    wiring: 0,
    connections: 0,
    lid: 0,
    nameplate: 0,
    availability: 0,
    annualDegradation: 0,
  );

  /// Suciedad (%), típico 2–5.
  final double soiling;

  /// Sombra (%). En F4 se sustituye por la sombra calculada.
  final double shading;

  /// Nieve (%).
  final double snow;

  /// Desajuste entre módulos (%).
  final double mismatch;

  /// Cableado DC (%).
  final double wiring;

  /// Conexiones (%).
  final double connections;

  /// Degradación inducida por luz, LID (%).
  final double lid;

  /// Tolerancia de placa (%).
  final double nameplate;

  /// Disponibilidad del sistema (%).
  final double availability;

  /// Degradación anual del módulo (%/año), típico 0.4–0.7.
  final double annualDegradation;

  /// Lista de pérdidas que se multiplican (sin degradación anual).
  List<double> get _items => [
    soiling,
    shading,
    snow,
    mismatch,
    wiring,
    connections,
    lid,
    nameplate,
    availability,
  ];

  /// Pérdida total combinada (%).
  double get totalPercent {
    var perf = 1.0;
    for (final p in _items) {
      perf *= 1 - p / 100;
    }
    return (1 - perf) * 100;
  }

  /// Factor que multiplica la potencia DC: 1 − total/100.
  double get factor => 1 - totalPercent / 100;

  /// Factor de degradación para el año [yearIndex] de operación
  /// (0 = primer año): (1 − d/100)^n.
  double degradationFactor(int yearIndex) =>
      math.pow(1 - annualDegradation / 100, yearIndex).toDouble();

  /// Copia con cambios.
  SystemLosses copyWith({
    double? soiling,
    double? shading,
    double? snow,
    double? mismatch,
    double? wiring,
    double? connections,
    double? lid,
    double? nameplate,
    double? availability,
    double? annualDegradation,
  }) => SystemLosses(
    soiling: soiling ?? this.soiling,
    shading: shading ?? this.shading,
    snow: snow ?? this.snow,
    mismatch: mismatch ?? this.mismatch,
    wiring: wiring ?? this.wiring,
    connections: connections ?? this.connections,
    lid: lid ?? this.lid,
    nameplate: nameplate ?? this.nameplate,
    availability: availability ?? this.availability,
    annualDegradation: annualDegradation ?? this.annualDegradation,
  );
}
