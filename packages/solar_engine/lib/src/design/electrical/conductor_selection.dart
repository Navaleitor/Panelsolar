import 'package:solar_engine/src/design/electrical/voltage_drop.dart';

/// Un calibre disponible (lo da el paquete regional, p. ej. NOM-001-SEDE).
class ConductorOption {
  /// Crea la opción.
  const new({
    required this.label,
    required this.areaMm2,
    required this.resistanceOhmPerKm,
    required this.ampacityA,
  });

  /// Nombre ("10 AWG", "6 mm²").
  final String label;

  /// Sección (mm²).
  final double areaMm2;

  /// Resistencia DC a 75 °C (Ω/km).
  final double resistanceOhmPerKm;

  /// Ampacidad base a 75 °C (A), antes de factores de corrección.
  final double ampacityA;
}

/// Datos de un tramo para elegir calibre.
class RunRequest {
  /// Crea el tramo.
  const new({
    required this.kind,
    required this.lengthM,
    required this.operatingCurrentA,
    required this.designCurrentA,
    required this.voltageV,
    required this.material,
    this.ampacityFactor = 1,
    this.conductorTempC = 75,
    this.maxDropPercent = 3,
  });

  /// Tipo de circuito.
  final CircuitKind kind;

  /// Longitud en un sentido (m).
  final double lengthM;

  /// Corriente de operación para la caída (A): Imp del string o Iac.
  final double operatingCurrentA;

  /// Corriente para la ampacidad (A): 1.25·1.25·Isc en DC, 1.25·Iac en AC.
  final double designCurrentA;

  /// Tensión del circuito (V): Vmp del string o tensión de la red.
  final double voltageV;

  /// Material.
  final ConductorMaterial material;

  /// Producto de factores de corrección por temperatura y por número de
  /// conductores en la canalización (≤ 1).
  final double ampacityFactor;

  /// Temperatura del conductor para la resistencia (°C).
  final double conductorTempC;

  /// Límite de caída del tramo (%).
  final double maxDropPercent;
}

/// Resultado de un calibre para un tramo.
class RunResult {
  /// Crea el resultado.
  const new({
    required this.option,
    required this.correctedAmpacityA,
    required this.dropVolts,
    required this.dropPercent,
    required this.ampacityOk,
    required this.dropOk,
  });

  /// Calibre.
  final ConductorOption option;

  /// Ampacidad con factores (A).
  final double correctedAmpacityA;

  /// Caída (V).
  final double dropVolts;

  /// Caída (%).
  final double dropPercent;

  /// Cumple ampacidad.
  final bool ampacityOk;

  /// Cumple la caída.
  final bool dropOk;

  /// Cumple todo.
  bool get ok => ampacityOk && dropOk;
}

/// Elige el calibre mínimo que cumple ampacidad y caída (B.6 punto 15).
/// Ficha: docs/formulas/24-caida-de-tension-y-calibre.md
abstract final class ConductorSelector {
  /// Evalúa un calibre.
  static RunResult evaluate(RunRequest r, ConductorOption o) {
    final rT = VoltageDrop.resistanceAt(
      o.resistanceOhmPerKm,
      r.material,
      r.conductorTempC,
    );
    final dv = VoltageDrop.volts(
      kind: r.kind,
      lengthM: r.lengthM,
      currentA: r.operatingCurrentA,
      rOhmPerKm: rT,
    );
    final pct = r.voltageV <= 0 ? double.infinity : dv / r.voltageV * 100;
    final amp = o.ampacityA * r.ampacityFactor;
    return RunResult(
      option: o,
      correctedAmpacityA: amp,
      dropVolts: dv,
      dropPercent: pct,
      ampacityOk: amp >= r.designCurrentA,
      dropOk: pct <= r.maxDropPercent + 1e-9,
    );
  }

  /// El calibre más delgado de [options] que cumple; `null` si ninguno.
  /// Las opciones se ordenan por sección.
  static RunResult? minimum(RunRequest r, List<ConductorOption> options) {
    final sorted = [...options]..sort((a, b) => a.areaMm2.compareTo(b.areaMm2));
    for (final o in sorted) {
      final res = evaluate(r, o);
      if (res.ok) return res;
    }
    return null;
  }
}
