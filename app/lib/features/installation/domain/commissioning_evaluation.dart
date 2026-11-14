import 'package:persistence/persistence.dart';

/// Resultado de comparar una medición contra su valor esperado.
enum MeasurementVerdict {
  /// Dentro de la tolerancia.
  ok,

  /// Fuera de la tolerancia (o con falla).
  outOfRange,

  /// Falta el valor esperado o el medido.
  incomplete,
}

/// Tolerancias de la puesta en marcha (IEC 62446-1). Ficha:
/// `docs/formulas/puesta-en-marcha-iec62446.md`.
class CommissioningLimits {
  const new({
    this.vocTolerancePct = 5,
    this.iscTolerancePct = 10,
    this.minInsulationMohm = 1,
  });

  /// Desviación máxima de Voc (%), en valor absoluto.
  final double vocTolerancePct;

  /// Desviación máxima de Isc (%): más amplia porque depende de la
  /// irradiancia del momento.
  final double iscTolerancePct;

  /// Resistencia de aislamiento mínima (MΩ).
  final double minInsulationMohm;
}

/// Desviación (%) de [measured] respecto de [expected]:
/// (medido − esperado) / esperado × 100. `null` si falta algún dato o el
/// esperado es 0.
double? deviationPct(double? expected, double? measured) {
  if (expected == null || measured == null || expected == 0) return null;
  return (measured - expected) / expected * 100;
}

/// Compara [measured] contra [expected] con [tolerancePct].
MeasurementVerdict evaluateMeasurement(
  double? expected,
  double? measured,
  double tolerancePct,
) {
  final dev = deviationPct(expected, measured);
  if (dev == null) return MeasurementVerdict.incomplete;
  return dev.abs() <= tolerancePct
      ? MeasurementVerdict.ok
      : MeasurementVerdict.outOfRange;
}

/// Veredicto de una revisión sí/no (`null` = sin revisar).
MeasurementVerdict evaluateCheck({required bool? ok}) => switch (ok) {
  null => MeasurementVerdict.incomplete,
  true => MeasurementVerdict.ok,
  false => MeasurementVerdict.outOfRange,
};

/// Combina varios veredictos: cualquier falla manda; si no, cualquier
/// dato faltante; si no, correcto.
MeasurementVerdict combine(Iterable<MeasurementVerdict> verdicts) {
  if (verdicts.contains(MeasurementVerdict.outOfRange)) {
    return MeasurementVerdict.outOfRange;
  }
  if (verdicts.isEmpty || verdicts.contains(MeasurementVerdict.incomplete)) {
    return MeasurementVerdict.incomplete;
  }
  return MeasurementVerdict.ok;
}

/// Veredicto de un string: Voc, Isc y polaridad.
MeasurementVerdict evaluateString(
  StringTest s, [
  CommissioningLimits limits = const CommissioningLimits(),
]) => combine([
  evaluateMeasurement(s.expectedVocV, s.measuredVocV, limits.vocTolerancePct),
  evaluateMeasurement(s.expectedIscA, s.measuredIscA, limits.iscTolerancePct),
  evaluateCheck(ok: s.polarityOk),
]);

/// Veredicto de la resistencia de aislamiento.
MeasurementVerdict evaluateInsulation(
  double? mohm, [
  CommissioningLimits limits = const CommissioningLimits(),
]) {
  if (mohm == null) return MeasurementVerdict.incomplete;
  return mohm >= limits.minInsulationMohm
      ? MeasurementVerdict.ok
      : MeasurementVerdict.outOfRange;
}

/// Estado que la app sugiere para el checklist: aprobado si todo está
/// medido y correcto, observaciones si algo falla, pendiente si falta algo.
CommissioningStatus suggestStatus(
  CommissioningRecord? record,
  List<StringTest> strings, [
  CommissioningLimits limits = const CommissioningLimits(),
]) {
  if (record == null) return CommissioningStatus.pending;
  final verdict = combine([
    for (final s in strings) evaluateString(s, limits),
    if (strings.isEmpty) MeasurementVerdict.incomplete,
    evaluateCheck(ok: record.polarityOk),
    evaluateInsulation(record.insulationMohm, limits),
    evaluateCheck(ok: record.groundingOk),
    evaluateCheck(ok: record.labelingOk),
  ]);
  return switch (verdict) {
    MeasurementVerdict.ok => CommissioningStatus.approved,
    MeasurementVerdict.outOfRange => CommissioningStatus.observations,
    MeasurementVerdict.incomplete => CommissioningStatus.pending,
  };
}
