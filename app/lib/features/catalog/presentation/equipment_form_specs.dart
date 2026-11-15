import 'package:drift/drift.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/catalog/domain/equipment_type.dart';
import 'package:panelsolar/features/catalog/presentation/widgets/spec_form.dart';
import 'package:persistence/persistence.dart';

/// Campos de cada tipo de equipo.
List<SpecField> equipmentFields(EquipmentType t, AppLocalizations l) {
  final common = [
    SpecField(
      id: 'manufacturer',
      label: l.specManufacturer,
      kind: SpecKind.text,
    ),
    SpecField(id: 'model', label: l.specModel, kind: SpecKind.text),
  ];
  final notes = SpecField(
    id: 'notes',
    label: l.fieldNotes,
    kind: SpecKind.text,
    required: false,
  );
  return switch (t) {
    EquipmentType.panel => [
      ...common,
      SpecField(id: 'pmaxW', label: l.specPmax, unit: 'W'),
      SpecField(id: 'vocV', label: l.specVoc, unit: 'V', help: l.specVocHelp),
      SpecField(id: 'iscA', label: l.specIsc, unit: 'A', help: l.specIscHelp),
      SpecField(id: 'vmpV', label: l.specVmp, unit: 'V'),
      SpecField(id: 'impA', label: l.specImp, unit: 'A'),
      SpecField(
        id: 'gammaPmaxPct',
        label: l.specGammaPmax,
        unit: '%/°C',
        allowNegative: true,
        help: l.specCoeffHelp,
      ),
      SpecField(
        id: 'betaVocPct',
        label: l.specBetaVoc,
        unit: '%/°C',
        allowNegative: true,
      ),
      SpecField(
        id: 'betaVmpPct',
        label: l.specBetaVmp,
        unit: '%/°C',
        allowNegative: true,
      ),
      SpecField(id: 'lengthM', label: l.specLength, unit: 'm'),
      SpecField(id: 'widthM', label: l.specWidth, unit: 'm'),
      SpecField(
        id: 'weightKg',
        label: l.specWeight,
        unit: 'kg',
        required: false,
      ),
      SpecField(
        id: 'cellType',
        label: l.specCellType,
        kind: SpecKind.choice,
        choices: [
          (CellType.mono.name, l.cellMono),
          (CellType.poly.name, l.cellPoly),
          (CellType.thinFilm.name, l.cellThinFilm),
          (CellType.other.name, l.cellOther),
        ],
      ),
      SpecField(
        id: 'cellCount',
        label: l.specCellCount,
        kind: SpecKind.integer,
        required: false,
      ),
      SpecField(id: 'bifacial', label: l.specBifacial, kind: SpecKind.toggle),
      SpecField(
        id: 'maxSeriesFuseA',
        label: l.specMaxFuse,
        unit: 'A',
        required: false,
      ),
      notes,
    ],
    EquipmentType.inverter => [
      ...common,
      SpecField(
        id: 'kind',
        label: l.specInverterKind,
        kind: SpecKind.choice,
        choices: [
          (InverterKind.string.name, l.inverterString),
          (InverterKind.micro.name, l.inverterMicro),
          (InverterKind.hybrid.name, l.inverterHybrid),
        ],
      ),
      SpecField(id: 'pacW', label: l.specPac, unit: 'W'),
      SpecField(id: 'vdcMaxV', label: l.specVdcMax, unit: 'V'),
      SpecField(id: 'mpptMinV', label: l.specMpptMin, unit: 'V'),
      SpecField(id: 'mpptMaxV', label: l.specMpptMax, unit: 'V'),
      SpecField(
        id: 'mpptCount',
        label: l.specMpptCount,
        kind: SpecKind.integer,
        help: l.specMpptCountHelp,
      ),
      SpecField(id: 'imaxPerMpptA', label: l.specImaxMppt, unit: 'A'),
      SpecField(id: 'efficiencyPct', label: l.specEfficiency, unit: '%'),
      SpecField(
        id: 'phases',
        label: l.specPhases,
        kind: SpecKind.choice,
        choices: [('1', l.phaseSingle), ('3', l.phaseThree)],
      ),
      SpecField(id: 'acVoltageV', label: l.specAcVoltage, unit: 'V'),
      SpecField(id: 'iacMaxA', label: l.specIacMax, unit: 'A', required: false),
      notes,
    ],
    EquipmentType.optimizer => [
      ...common,
      SpecField(id: 'pmaxInW', label: l.specPmaxIn, unit: 'W'),
      SpecField(id: 'vinMaxV', label: l.specVinMax, unit: 'V'),
      SpecField(id: 'imaxInA', label: l.specImaxIn, unit: 'A'),
      SpecField(
        id: 'voutMaxV',
        label: l.specVoutMax,
        unit: 'V',
        required: false,
      ),
      SpecField(
        id: 'ioutMaxA',
        label: l.specIoutMax,
        unit: 'A',
        required: false,
      ),
      SpecField(id: 'efficiencyPct', label: l.specEfficiency, unit: '%'),
      notes,
    ],
    EquipmentType.battery => [
      ...common,
      SpecField(
        id: 'chemistry',
        label: l.specChemistry,
        kind: SpecKind.choice,
        choices: [
          (BatteryChemistry.lfp.name, 'LFP (LiFePO₄)'),
          (BatteryChemistry.nmc.name, 'NMC'),
          (BatteryChemistry.leadAcid.name, l.chemLeadAcid),
          (BatteryChemistry.other.name, l.cellOther),
        ],
      ),
      SpecField(id: 'capacityKwh', label: l.specCapacity, unit: 'kWh'),
      SpecField(
        id: 'usableKwh',
        label: l.specUsable,
        unit: 'kWh',
        required: false,
      ),
      SpecField(id: 'nominalVoltageV', label: l.specNominalVoltage, unit: 'V'),
      SpecField(
        id: 'maxChargeKw',
        label: l.specMaxCharge,
        unit: 'kW',
        required: false,
      ),
      SpecField(
        id: 'maxDischargeKw',
        label: l.specMaxDischarge,
        unit: 'kW',
        required: false,
      ),
      SpecField(
        id: 'cycles',
        label: l.specCycles,
        kind: SpecKind.integer,
        required: false,
      ),
      notes,
    ],
  };
}

/// Valores por defecto de un equipo nuevo.
SpecValues equipmentDefaults(EquipmentType t) => switch (t) {
  EquipmentType.panel => {
    'gammaPmaxPct': -0.35,
    'betaVocPct': -0.28,
    'betaVmpPct': -0.37,
    'cellType': CellType.mono.name,
  },
  EquipmentType.inverter => {
    'kind': InverterKind.string.name,
    'mpptCount': 2,
    'efficiencyPct': 97.0,
    'phases': '1',
    'acVoltageV': 220.0,
  },
  EquipmentType.optimizer => {'efficiencyPct': 99.0},
  EquipmentType.battery => {'chemistry': BatteryChemistry.lfp.name},
};

/// Fila → valores del formulario.
SpecValues equipmentValues(Object row) => switch (row) {
  final PanelModel p => {...p.toJson(), 'cellType': p.cellType.name},
  final InverterModel i => {
    ...i.toJson(),
    'kind': i.kind.name,
    'phases': '${i.phases}',
  },
  final OptimizerModel o => o.toJson(),
  final BatteryModel b => {...b.toJson(), 'chemistry': b.chemistry.name},
  _ => const {},
};

double _d(SpecValues v, String k) => (v[k]! as num).toDouble();
double? _dn(SpecValues v, String k) => (v[k] as num?)?.toDouble();
String _s(SpecValues v, String k) => v[k]! as String;
Value<String?> _notes(SpecValues v) => Value(v['notes'] as String?);

/// Guarda los valores como equipo [t]; [id] = editar uno existente.
Future<void> saveEquipment(
  EquipmentType t,
  SpecValues v, {
  required PanelModelRepository panels,
  required InverterModelRepository inverters,
  required OptimizerModelRepository optimizers,
  required BatteryModelRepository batteries,
  String? id,
}) async {
  final idValue = id == null ? const Value<String>.absent() : Value(id);
  switch (t) {
    case EquipmentType.panel:
      await panels.save(
        PanelModelsCompanion.insert(
          id: idValue,
          manufacturer: _s(v, 'manufacturer'),
          model: _s(v, 'model'),
          pmaxW: _d(v, 'pmaxW'),
          vocV: _d(v, 'vocV'),
          iscA: _d(v, 'iscA'),
          vmpV: _d(v, 'vmpV'),
          impA: _d(v, 'impA'),
          gammaPmaxPct: Value(_d(v, 'gammaPmaxPct')),
          betaVocPct: Value(_d(v, 'betaVocPct')),
          betaVmpPct: Value(_d(v, 'betaVmpPct')),
          lengthM: _d(v, 'lengthM'),
          widthM: _d(v, 'widthM'),
          weightKg: Value(_dn(v, 'weightKg')),
          cellType: Value(CellType.values.byName(_s(v, 'cellType'))),
          cellCount: Value(v['cellCount'] as int?),
          bifacial: Value(v['bifacial'] as bool? ?? false),
          maxSeriesFuseA: Value(_dn(v, 'maxSeriesFuseA')),
          notes: _notes(v),
        ),
      );
    case EquipmentType.inverter:
      await inverters.save(
        InverterModelsCompanion.insert(
          id: idValue,
          manufacturer: _s(v, 'manufacturer'),
          model: _s(v, 'model'),
          kind: Value(InverterKind.values.byName(_s(v, 'kind'))),
          pacW: _d(v, 'pacW'),
          vdcMaxV: _d(v, 'vdcMaxV'),
          mpptMinV: _d(v, 'mpptMinV'),
          mpptMaxV: _d(v, 'mpptMaxV'),
          mpptCount: Value(v['mpptCount']! as int),
          imaxPerMpptA: _d(v, 'imaxPerMpptA'),
          efficiencyPct: Value(_d(v, 'efficiencyPct')),
          phases: Value(int.parse(_s(v, 'phases'))),
          acVoltageV: Value(_d(v, 'acVoltageV')),
          iacMaxA: Value(_dn(v, 'iacMaxA')),
          notes: _notes(v),
        ),
      );
    case EquipmentType.optimizer:
      await optimizers.save(
        OptimizerModelsCompanion.insert(
          id: idValue,
          manufacturer: _s(v, 'manufacturer'),
          model: _s(v, 'model'),
          pmaxInW: _d(v, 'pmaxInW'),
          vinMaxV: _d(v, 'vinMaxV'),
          imaxInA: _d(v, 'imaxInA'),
          voutMaxV: Value(_dn(v, 'voutMaxV')),
          ioutMaxA: Value(_dn(v, 'ioutMaxA')),
          efficiencyPct: Value(_d(v, 'efficiencyPct')),
          notes: _notes(v),
        ),
      );
    case EquipmentType.battery:
      await batteries.save(
        BatteryModelsCompanion.insert(
          id: idValue,
          manufacturer: _s(v, 'manufacturer'),
          model: _s(v, 'model'),
          chemistry: Value(BatteryChemistry.values.byName(_s(v, 'chemistry'))),
          capacityKwh: _d(v, 'capacityKwh'),
          usableKwh: Value(_dn(v, 'usableKwh')),
          nominalVoltageV: _d(v, 'nominalVoltageV'),
          maxChargeKw: Value(_dn(v, 'maxChargeKw')),
          maxDischargeKw: Value(_dn(v, 'maxDischargeKw')),
          cycles: Value(v['cycles'] as int?),
          notes: _notes(v),
        ),
      );
  }
}
