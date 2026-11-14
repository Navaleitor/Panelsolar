import 'dart:math' as math;

import 'package:persistence/persistence.dart';
import 'package:regional_packs/regional_packs.dart';
import 'package:solar_engine/solar_engine.dart';

/// Límite de caída por tramo (%), el de `RunRequest`.
const double maxRunDropPercent = 3;

/// Límite de caída total (%).
const double maxTotalDropPercent = 5;

/// Datos eléctricos del sistema para calcular los tramos.
typedef ElectricalContext = ({
  double moduleIscA,
  double moduleImpA,
  double stringVmpV,
  double acCurrentA,
  double gridVoltageV,
  int phases,
});

/// Resultado de un tramo.
typedef RunEvaluation = ({
  /// Calibre mínimo que cumple (nulo si ninguno).
  RunResult? minimum,

  /// Calibre elegido a mano (si hay) con su revisión.
  RunResult? chosen,

  /// Corriente de diseño para la ampacidad (A).
  double designCurrentA,
});

/// Cableado y protecciones con las tablas de NOM-001-SEDE (fichas 24–25).
/// Siempre indicativo: requiere revisión de un profesional.
abstract final class ElectricalDesign {
  /// Calibres de la norma para un tramo, con la ampacidad ya corregida.
  static List<ConductorOption> options(
    ElectricalRun run, {
    ConductorStandard standard = const NomConductors(),
  }) {
    final material = run.material == CableMaterial.copper
        ? WireMaterial.copper
        : WireMaterial.aluminum;
    final raceway = RacewayType.values.byName(run.raceway.name);
    return [
      for (final s in standard.sizes(material))
        ConductorOption(
          label: s.label,
          areaMm2: s.areaMm2,
          resistanceOhmPerKm: s.resistanceOhmPerKm,
          ampacityA: standard.correctedAmpacity(
            s,
            ambientC: run.ambientC,
            raceway: raceway,
            currentCarryingConductors: run.conductors,
          ),
        ),
    ];
  }

  /// Revisa un tramo: calibre mínimo y, si hay, el elegido a mano.
  static RunEvaluation evaluate(ElectricalRun run, ElectricalContext c) {
    final dc = run.kind == RunKind.dcString;
    final request = RunRequest(
      kind: dc
          ? CircuitKind.dc
          : (c.phases == 3 ? CircuitKind.ac3 : CircuitKind.ac1),
      lengthM: run.lengthM,
      operatingCurrentA: dc ? c.moduleImpA : c.acCurrentA,
      designCurrentA: dc
          ? c.moduleIscA * ProtectionSizing.continuousFactor
          : c.acCurrentA * 1.25,
      voltageV: dc ? c.stringVmpV : c.gridVoltageV,
      material: run.material == CableMaterial.copper
          ? ConductorMaterial.copper
          : ConductorMaterial.aluminum,
    );
    final opts = options(run);
    final chosen = opts.where((o) => o.label == run.chosenSize).firstOrNull;
    return (
      minimum: ConductorSelector.minimum(request, opts),
      chosen: chosen == null
          ? null
          : ConductorSelector.evaluate(request, chosen),
      designCurrentA: request.designCurrentA,
    );
  }

  /// Caída total = la mayor de CD + la mayor de CA (%).
  static double totalDrop(Map<RunKind, List<double>> drops) =>
      (drops[RunKind.dcString] ?? const []).fold<double>(0, math.max) +
      (drops[RunKind.acOutput] ?? const []).fold<double>(0, math.max);

  /// Protecciones sugeridas para un inversor.
  static List<ProtectionSuggestion> protections({
    required StringModule module,
    required StringLimits limits,
    required List<StringGroup> groups,
    required double acCurrentA,
    required double gridVoltageV,
  }) {
    final perInput = <(int, int), int>{};
    var series = 0;
    for (final g in groups) {
      final k = (g.inverterIndex, g.mpptIndex);
      perInput[k] = (perInput[k] ?? 0) + g.parallel;
      series = math.max(series, g.series);
    }
    final strings = groups
        .where((g) => g.inverterIndex == 0)
        .fold(0, (s, g) => s + g.parallel);
    return ProtectionSizing.suggest(
      ProtectionInput(
        moduleIscA: module.iscA,
        stringsInParallel: perInput.values.fold(0, math.max),
        totalStrings: math.max(strings, 1),
        maxStringVocV: series * limits.vocColdV,
        inverterAcCurrentA: acCurrentA,
        gridVoltageV: gridVoltageV,
        standardRatingsA: NomProtections.breakerRatingsA,
        fuseRatingsA: NomProtections.pvFuseRatingsA,
        groundingTable: NomProtections.groundingCopper,
        moduleMaxSeriesFuseA: module.maxSeriesFuseA,
      ),
    );
  }
}
