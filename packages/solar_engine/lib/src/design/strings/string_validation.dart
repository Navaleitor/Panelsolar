import 'package:solar_engine/src/design/strings/string_design.dart';
import 'package:solar_engine/src/design/strings/string_equipment.dart';
import 'package:solar_engine/src/design/strings/string_sizing.dart';

/// Qué tan grave es un problema.
enum IssueSeverity {
  /// No cumple: se marca en rojo.
  error,

  /// Cumple pero conviene revisarlo.
  warning,
}

/// Tipo de problema de un grupo de strings.
enum StringIssueCode {
  /// Voc a Tmin × serie supera la tensión máxima del inversor o la norma.
  vocOverLimit,

  /// Vmp a Tc máx × serie queda bajo el MPPT mínimo (pierde energía con
  /// calor o el inversor se apaga).
  vmpBelowMppt,

  /// Vmp con frío × serie supera el MPPT máximo (no sigue el punto óptimo).
  vmpAboveMppt,

  /// Isc × 1.25 × paralelos supera la corriente máxima del MPPT.
  currentOverMppt,

  /// El grupo apunta a un inversor o MPPT que no existe.
  invalidInput,

  /// Dos grupos en la misma entrada MPPT con distinto número en serie.
  mixedSeriesInMppt,
}

/// Un problema encontrado, con el valor calculado y el límite.
class StringIssue {
  /// Crea el problema.
  const new({
    required this.code,
    required this.severity,
    required this.groupIndex,
    required this.value,
    required this.limit,
  });

  /// Tipo.
  final StringIssueCode code;

  /// Gravedad.
  final IssueSeverity severity;

  /// Grupo afectado.
  final int groupIndex;

  /// Valor calculado (V o A).
  final double value;

  /// Límite (V o A).
  final double limit;
}

/// Revisa una configuración de strings contra los límites.
/// Ficha: docs/formulas/22-dimensionamiento-de-strings.md
abstract final class StringValidator {
  /// Problemas de [groups] para el [module] en [inverterCount] inversores.
  static List<StringIssue> validate({
    required List<StringGroup> groups,
    required StringModule module,
    required StringInverter inverter,
    required StringLimits limits,
    required int inverterCount,
    double systemVoltageLimit = defaultSystemVoltageLimit,
  }) {
    final out = <StringIssue>[];
    final vLimit = inverter.vdcMaxV < systemVoltageLimit
        ? inverter.vdcMaxV
        : systemVoltageLimit;
    final iLimit = inverter.iscMaxPerMpptA == null
        ? inverter.imaxPerMpptA
        : (inverter.iscMaxPerMpptA! < inverter.imaxPerMpptA
              ? inverter.iscMaxPerMpptA!
              : inverter.imaxPerMpptA);
    final seriesByInput = <(int, int), int>{};
    final currentByInput = <(int, int), double>{};
    for (final (i, g) in groups.indexed) {
      void add(StringIssueCode c, IssueSeverity s, double v, double l) =>
          out.add(
            StringIssue(
              code: c,
              severity: s,
              groupIndex: i,
              value: v,
              limit: l,
            ),
          );
      if (g.inverterIndex < 0 ||
          g.inverterIndex >= inverterCount ||
          g.mpptIndex < 0 ||
          g.mpptIndex >= inverter.mpptCount ||
          g.series < 1 ||
          g.parallel < 1) {
        add(StringIssueCode.invalidInput, IssueSeverity.error, 0, 0);
        continue;
      }
      final voc = g.series * limits.vocColdV;
      if (voc > vLimit) {
        add(StringIssueCode.vocOverLimit, IssueSeverity.error, voc, vLimit);
      }
      final vmpHot = g.series * limits.vmpHotV;
      if (vmpHot < inverter.mpptMinV) {
        add(
          StringIssueCode.vmpBelowMppt,
          IssueSeverity.error,
          vmpHot,
          inverter.mpptMinV,
        );
      }
      final vmpCold = g.series * limits.vmpColdV;
      if (vmpCold > inverter.mpptMaxV) {
        add(
          StringIssueCode.vmpAboveMppt,
          IssueSeverity.warning,
          vmpCold,
          inverter.mpptMaxV,
        );
      }
      final key = (g.inverterIndex, g.mpptIndex);
      final prev = seriesByInput[key];
      if (prev != null && prev != g.series) {
        add(
          StringIssueCode.mixedSeriesInMppt,
          IssueSeverity.error,
          g.series.toDouble(),
          prev.toDouble(),
        );
      }
      seriesByInput[key] = prev ?? g.series;
      final current =
          (currentByInput[key] ?? 0) + g.parallel * limits.stringDesignCurrentA;
      currentByInput[key] = current;
      if (current > iLimit + 1e-9) {
        add(
          StringIssueCode.currentOverMppt,
          IssueSeverity.error,
          current,
          iLimit,
        );
      }
    }
    return out;
  }
}
