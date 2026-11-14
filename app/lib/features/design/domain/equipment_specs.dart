import 'package:panelsolar/features/design/domain/design_inputs.dart';
import 'package:persistence/persistence.dart';
import 'package:solar_engine/solar_engine.dart';

/// Conversión de filas del catálogo a datos del motor.
abstract final class EquipmentSpecs {
  /// Panel → datos eléctricos para strings.
  static StringModule module(PanelModel p) => StringModule(
    pmaxW: p.pmaxW,
    vocV: p.vocV,
    iscA: p.iscA,
    vmpV: p.vmpV,
    impA: p.impA,
    betaVocPct: p.betaVocPct,
    betaVmpPct: p.betaVmpPct,
    gammaPmaxPct: p.gammaPmaxPct,
    maxSeriesFuseA: p.maxSeriesFuseA,
  );

  /// Inversor → entrada DC para strings.
  static StringInverter inverter(InverterModel i) => StringInverter(
    pacW: i.pacW,
    vdcMaxV: i.vdcMaxV,
    mpptMinV: i.mpptMinV,
    mpptMaxV: i.mpptMaxV,
    mpptCount: i.mpptCount,
    imaxPerMpptA: i.imaxPerMpptA,
    iscMaxPerMpptA: i.iscMaxPerMpptA,
  );

  /// Panel → datos del análisis.
  static PanelSpec panelSpec(PanelModel p) => (
    pmaxW: p.pmaxW,
    gammaPct: p.gammaPmaxPct,
    lengthM: p.lengthM,
    widthM: p.widthM,
  );

  /// Inversor → datos del análisis.
  static InverterSpec inverterSpec(
    InverterModel i, {
    required int count,
    required bool optimizers,
  }) => (
    pacW: i.pacW,
    efficiencyPct: i.efficiencyPct,
    count: count,
    independent: optimizers || i.kind == InverterKind.micro,
  );

  /// Corriente AC máxima de salida (A): la de la hoja o Pac / V (/√3 en
  /// trifásica).
  static double acCurrent(InverterModel i) =>
      i.iacMaxA ??
      i.pacW / (i.acVoltageV * (i.phases == 3 ? 1.7320508075688772 : 1));
}
