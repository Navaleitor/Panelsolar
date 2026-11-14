import 'dart:math' as math;

import 'package:solar_engine/src/design/strings/string_sizing.dart';

/// Un grupo de strings iguales en una entrada MPPT de un inversor.
class StringGroup {
  /// Crea el grupo.
  const new({
    required this.inverterIndex,
    required this.mpptIndex,
    required this.series,
    required this.parallel,
  });

  /// Inversor (0 = el primero).
  final int inverterIndex;

  /// Entrada MPPT del inversor (0 = la primera).
  final int mpptIndex;

  /// Paneles en serie por string.
  final int series;

  /// Strings en paralelo en esta entrada.
  final int parallel;

  /// Paneles del grupo.
  int get panels => series * parallel;

  /// Copia con cambios.
  StringGroup copyWith({
    int? inverterIndex,
    int? mpptIndex,
    int? series,
    int? parallel,
  }) => StringGroup(
    inverterIndex: inverterIndex ?? this.inverterIndex,
    mpptIndex: mpptIndex ?? this.mpptIndex,
    series: series ?? this.series,
    parallel: parallel ?? this.parallel,
  );
}

/// Propuesta automática de strings.
class StringProposal {
  /// Crea la propuesta.
  const new({required this.groups, required this.unusedPanels});

  /// Grupos por entrada MPPT.
  final List<StringGroup> groups;

  /// Paneles que no caben en strings válidos.
  final int unusedPanels;

  /// Paneles conectados.
  int get usedPanels => groups.fold(0, (s, g) => s + g.panels);
}

/// Propone strings (B.6 punto 14).
/// Ficha: docs/formulas/22-dimensionamiento-de-strings.md
abstract final class StringPlanner {
  /// Propuesta para [totalPanels] paneles en [inverterCount] inversores de
  /// [mpptCount] entradas, con los [limits] del panel y del inversor.
  ///
  /// Prueba cada número de paneles en serie válido, se queda con el que
  /// conecta más paneles (a igualdad, el de más paneles en serie: menos
  /// corriente y cable) y reparte los strings entre las entradas.
  /// Con [microinverter] cada entrada lleva un solo panel.
  static StringProposal propose({
    required int totalPanels,
    required StringLimits limits,
    required int inverterCount,
    required int mpptCount,
    bool microinverter = false,
  }) {
    if (totalPanels <= 0 || inverterCount <= 0 || mpptCount <= 0) {
      return StringProposal(groups: const [], unusedPanels: totalPanels);
    }
    if (microinverter) {
      final groups = <StringGroup>[];
      final slots = inverterCount * mpptCount;
      for (var k = 0; k < math.min(totalPanels, slots); k++) {
        groups.add(
          StringGroup(
            inverterIndex: k ~/ mpptCount,
            mpptIndex: k % mpptCount,
            series: 1,
            parallel: 1,
          ),
        );
      }
      return StringProposal(
        groups: groups,
        unusedPanels: totalPanels - groups.length,
      );
    }
    if (!limits.feasible) {
      return StringProposal(groups: const [], unusedPanels: totalPanels);
    }
    final slots = inverterCount * mpptCount;
    final capacity = slots * limits.maxParallelPerMppt;
    var bestSeries = 0;
    var bestStrings = 0;
    for (var s = limits.minSeries; s <= limits.maxSeries; s++) {
      final strings = math.min(totalPanels ~/ s, capacity);
      final used = strings * s;
      if (used > bestSeries * bestStrings ||
          (used == bestSeries * bestStrings && used > 0)) {
        bestSeries = s;
        bestStrings = strings;
      }
    }
    if (bestStrings == 0) {
      return StringProposal(groups: const [], unusedPanels: totalPanels);
    }
    final groups = <StringGroup>[];
    for (var k = 0; k < slots; k++) {
      final n = bestStrings ~/ slots + (k < bestStrings % slots ? 1 : 0);
      if (n == 0) continue;
      groups.add(
        StringGroup(
          inverterIndex: k % inverterCount,
          mpptIndex: k ~/ inverterCount,
          series: bestSeries,
          parallel: n,
        ),
      );
    }
    groups.sort(
      (a, b) => a.inverterIndex != b.inverterIndex
          ? a.inverterIndex.compareTo(b.inverterIndex)
          : a.mpptIndex.compareTo(b.mpptIndex),
    );
    return StringProposal(
      groups: groups,
      unusedPanels: totalPanels - bestSeries * bestStrings,
    );
  }
}
