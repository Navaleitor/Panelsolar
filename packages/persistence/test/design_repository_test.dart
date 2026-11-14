import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:persistence/persistence.dart';
import 'package:test/test.dart';

PanelModelsCompanion panel({double vmp = 41.7}) => PanelModelsCompanion.insert(
  manufacturer: 'Marca',
  model: 'P-550',
  pmaxW: 550,
  vocV: 49.6,
  iscA: 14,
  vmpV: vmp,
  impA: 13.2,
  lengthM: 2.278,
  widthM: 1.134,
);

void main() {
  late AppDatabase db;
  late String projectId;
  late String planeId;

  setUp(() async {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    db = AppDatabase(NativeDatabase.memory());
    final c = await ClientRepository(db).create(name: 'Ana');
    projectId = (await ProjectRepository(
      db,
    ).create(clientId: c.id, name: 'Casa', projectDate: DateTime.utc(2026))).id;
    planeId = (await RoofPlaneRepository(db).add(
      projectId: projectId,
      name: 'Plano 1',
      polygon: '[[0,0],[10,0],[10,8],[0,8]]',
    )).id;
  });
  tearDown(() => db.close());

  group('Catálogo', () {
    test('panel: guardar, editar, validar y borrar', () async {
      final repo = PanelModelRepository(db);
      final p = await repo.save(panel());
      expect(p.source, EquipmentSource.manual);
      expect(p.cellType, CellType.mono);
      expect(p.bifacial, isFalse);
      await repo.save(p.toCompanion(false).copyWith(model: const Value('X')));
      expect((await repo.find(p.id))!.model, 'X');
      expect(await repo.watchAll().first, hasLength(1));
      expect(() => repo.save(panel(vmp: 60)), throwsArgumentError);
      expect(
        () => repo.save(panel().copyWith(pmaxW: const Value(0))),
        throwsArgumentError,
      );
      await repo.softDelete(p.id);
      expect(await repo.watchAll().first, isEmpty);
      expect(await repo.find(p.id), isNotNull);
    });

    test('inversor, optimizador y batería', () async {
      final inv = InverterModelRepository(db);
      final i = await inv.save(
        InverterModelsCompanion.insert(
          manufacturer: 'Marca',
          model: 'I-5K',
          pacW: 5000,
          vdcMaxV: 600,
          mpptMinV: 90,
          mpptMaxV: 520,
          imaxPerMpptA: 16,
        ),
      );
      expect(i.kind, InverterKind.string);
      expect(i.phases, 1);
      expect(await inv.find(i.id), isNotNull);
      expect(
        () => inv.save(
          InverterModelsCompanion.insert(
            manufacturer: 'M',
            model: 'mal',
            pacW: 5000,
            vdcMaxV: 600,
            mpptMinV: 500,
            mpptMaxV: 400,
            imaxPerMpptA: 16,
          ),
        ),
        throwsArgumentError,
      );
      await inv.softDelete(i.id);
      expect(await inv.watchAll().first, isEmpty);

      final opt = OptimizerModelRepository(db);
      final o = await opt.save(
        OptimizerModelsCompanion.insert(
          manufacturer: 'Marca',
          model: 'O-1',
          pmaxInW: 600,
          vinMaxV: 80,
          imaxInA: 15,
        ),
      );
      expect(await opt.watchAll().first, hasLength(1));
      await opt.softDelete(o.id);
      expect(await opt.watchAll().first, isEmpty);

      final bat = BatteryModelRepository(db);
      final b = await bat.save(
        BatteryModelsCompanion.insert(
          manufacturer: 'Marca',
          model: 'B-5',
          capacityKwh: 5.1,
          nominalVoltageV: 51.2,
        ),
      );
      expect(b.chemistry, BatteryChemistry.lfp);
      await bat.softDelete(b.id);
      expect(await bat.watchAll().first, isEmpty);
    });
  });

  group('Diseño', () {
    test('un diseño por proyecto, se actualiza', () async {
      final repo = PvDesignRepository(db);
      expect(await repo.getForProject(projectId), isNull);
      final d = await repo.save(
        projectId,
        const PvDesignsCompanion(inverterCount: Value(2)),
      );
      final d2 = await repo.save(
        projectId,
        const PvDesignsCompanion(shadeThresholdPct: Value(15)),
      );
      expect(d2.id, d.id);
      expect((d2.inverterCount, d2.shadeThresholdPct), (2, 15));
      expect(await repo.watchForProject(projectId).first, isNotNull);
      expect(
        () => repo.save(
          projectId,
          const PvDesignsCompanion(inverterCount: Value(0)),
        ),
        throwsArgumentError,
      );
    });

    test('arreglo por plano y strings', () async {
      final layouts = ArrayLayoutRepository(db);
      final a = await layouts.saveForPlane(
        projectId,
        planeId,
        const ArrayLayoutsCompanion(panels: Value('[{"on":true}]')),
      );
      final b = await layouts.saveForPlane(
        projectId,
        planeId,
        const ArrayLayoutsCompanion(
          orientation: Value(LayoutOrientation.landscape),
        ),
      );
      expect(b.id, a.id);
      expect(b.orientation, LayoutOrientation.landscape);
      expect(b.mount, MountType.flush);
      expect(await layouts.listByProject(projectId), hasLength(1));
      await layouts.softDelete(a.id);
      expect(await layouts.watchByProject(projectId).first, isEmpty);

      final strings = StringConfigRepository(db);
      await strings.replaceAll(projectId, [
        StringConfigsCompanion.insert(projectId: projectId, series: 10),
        StringConfigsCompanion.insert(
          projectId: projectId,
          series: 10,
          mpptIndex: const Value(1),
        ),
      ]);
      await strings.replaceAll(projectId, [
        StringConfigsCompanion.insert(projectId: projectId, series: 12),
      ]);
      final list = await strings.watchByProject(projectId).first;
      expect(list.single.series, 12);
      expect(
        () => strings.replaceAll(projectId, [
          StringConfigsCompanion.insert(projectId: projectId, series: 0),
        ]),
        throwsArgumentError,
      );
    });

    test('tramos, protecciones y resultados', () async {
      final runs = ElectricalRunRepository(db);
      final r = await runs.save(
        ElectricalRunsCompanion.insert(
          projectId: projectId,
          kind: RunKind.dcString,
          name: 'String 1',
          lengthM: 25,
        ),
      );
      expect(r.material, CableMaterial.copper);
      expect(r.raceway, RacewayKind.rooftop13to90mm);
      await runs.saveResult(r.id, '10 AWG', 1.2);
      final saved = (await runs.watchByProject(projectId).first).single;
      expect((saved.resultSize, saved.dropPercent), ('10 AWG', 1.2));
      expect(
        () => runs.save(
          ElectricalRunsCompanion.insert(
            projectId: projectId,
            kind: RunKind.acOutput,
            name: 'x',
            lengthM: 0,
          ),
        ),
        throwsArgumentError,
      );
      await runs.softDelete(r.id);
      expect(await runs.watchByProject(projectId).first, isEmpty);

      final prot = ProtectionDeviceRepository(db);
      await prot.replaceAll(projectId, [
        ProtectionDevicesCompanion.insert(
          projectId: projectId,
          kind: ProtectionDeviceKind.acBreaker,
          ratingA: const Value(30),
        ),
      ]);
      await prot.replaceAll(projectId, [
        ProtectionDevicesCompanion.insert(
          projectId: projectId,
          kind: ProtectionDeviceKind.dcSpd,
        ),
      ]);
      final p = await prot.watchByProject(projectId).first;
      expect(p.single.kind, ProtectionDeviceKind.dcSpd);

      final sims = SimulationResultRepository(db);
      expect(await sims.watchLatest(projectId).first, isNull);
      await sims.add(
        SimulationResultsCompanion.insert(
          projectId: projectId,
          pdcW: 5500,
          pacW: 5000,
          firstYearKwh: 9000,
          lifetimeKwh: 210000,
          monthlyKwh: '[]',
          yearlyKwh: '[]',
          specificYield: 1636,
          performanceRatio: 0.8,
        ),
      );
      expect((await sims.watchLatest(projectId).first)!.pdcW, 5500);
    });
  });
}
