import 'package:solar_engine/solar_engine.dart';

/// Análisis de strings listo para la pantalla.
typedef StringAnalysis = ({
  StringLimits limits,
  StringProposal proposal,
  List<StringIssue> issues,
  int connectedPanels,
});

/// Límites, propuesta automática y validación (B.6 punto 14, ficha 22).
/// Si [groups] es nulo se valida la propuesta.
StringAnalysis analyzeStrings({
  required StringModule module,
  required StringInverter inverter,
  required StringTemperatures temps,
  required int panels,
  required int inverterCount,
  required bool microinverter,
  double systemVoltageLimit = 600,
  List<StringGroup>? groups,
}) {
  final limits = StringSizing.limits(
    module: module,
    inverter: inverter,
    temps: temps,
    systemVoltageLimit: systemVoltageLimit,
  );
  final proposal = StringPlanner.propose(
    totalPanels: panels,
    limits: limits,
    inverterCount: inverterCount,
    mpptCount: inverter.mpptCount,
    microinverter: microinverter,
  );
  final used = groups ?? proposal.groups;
  return (
    limits: limits,
    proposal: proposal,
    issues: StringValidator.validate(
      groups: used,
      module: module,
      inverter: inverter,
      limits: limits,
      inverterCount: inverterCount,
      systemVoltageLimit: systemVoltageLimit,
    ),
    connectedPanels: used.fold(0, (s, g) => s + g.panels),
  );
}
