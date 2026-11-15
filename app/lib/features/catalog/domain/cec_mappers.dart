import 'package:data_sources/data_sources.dart';
import 'package:drift/drift.dart';
import 'package:persistence/persistence.dart';

/// Equipos del catálogo CEC → filas del catálogo propio.
abstract final class CecMappers {
  /// Panel CEC → fila. Las medidas faltantes quedan en 0 (el instalador
  /// debe completarlas antes de usarlo).
  static PanelModelsCompanion panel(CecModule m) => PanelModelsCompanion.insert(
    manufacturer: m.manufacturer,
    model: m.model,
    pmaxW: m.pmaxW,
    vocV: m.vocV,
    iscA: m.iscA,
    vmpV: m.vmpV,
    impA: m.impA,
    gammaPmaxPct: Value(_round(m.gammaPmaxPct)),
    betaVocPct: Value(_round(m.betaVocPct)),
    betaVmpPct: Value(_round(m.betaVmpPctEstimate)),
    lengthM: m.lengthM > 0 ? m.lengthM : 1.7,
    widthM: m.widthM > 0 ? m.widthM : 1.0,
    cellType: Value(switch (m.technology) {
      CecTechnology.mono => CellType.mono,
      CecTechnology.poly => CellType.poly,
      CecTechnology.thinFilm => CellType.thinFilm,
      CecTechnology.other => CellType.other,
    }),
    cellCount: Value(m.cells > 0 ? m.cells : null),
    bifacial: Value(m.bifacial),
    source: const Value(EquipmentSource.cec),
    notes: Value(
      m.lengthM > 0
          ? null
          : 'CEC sin medidas: revisar largo y ancho en la hoja de datos.',
    ),
  );

  /// Inversor CEC → fila (1 MPPT con la corriente DC máxima: revisar).
  static InverterModelsCompanion inverter(CecInverter i) =>
      InverterModelsCompanion.insert(
        manufacturer: i.manufacturer,
        model: i.model,
        kind: Value(i.isMicro ? InverterKind.micro : InverterKind.string),
        pacW: i.pacW,
        vdcMaxV: i.vdcMaxV,
        mpptMinV: i.mpptMinV,
        mpptMaxV: i.mpptMaxV < i.vdcMaxV ? i.mpptMaxV : i.vdcMaxV,
        imaxPerMpptA: i.idcMaxA > 0 ? i.idcMaxA : 10,
        efficiencyPct: Value(_round(i.efficiencyPct)),
        acVoltageV: Value(i.acVoltageV),
        source: const Value(EquipmentSource.cec),
        notes: const Value(
          'CEC: revisar número de MPPT y corriente por MPPT en la hoja.',
        ),
      );

  static double _round(double v) => (v * 1000).roundToDouble() / 1000;
}
