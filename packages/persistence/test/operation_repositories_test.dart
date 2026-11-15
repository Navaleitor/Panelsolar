import 'package:drift/native.dart';
import 'package:persistence/persistence.dart';
import 'package:test/test.dart';

void main() {
  late AppDatabase db;
  late Project project;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    final client = await ClientRepository(db).create(name: 'Ana');
    project = await ProjectRepository(db).create(
      clientId: client.id,
      name: 'Casa',
      projectDate: DateTime.utc(2026),
    );
  });

  tearDown(() => db.close());

  test('addMonthsUtc respeta fin de mes y cambio de año', () {
    expect(
      addMonthsUtc(DateTime.utc(2026, 1, 31), 1),
      DateTime.utc(2026, 2, 28),
    );
    expect(
      addMonthsUtc(DateTime.utc(2026, 11, 15), 3),
      DateTime.utc(2027, 2, 15),
    );
    expect(
      addMonthsUtc(DateTime.utc(2024, 2, 29), 12),
      DateTime.utc(2025, 2, 28),
    );
  });

  group('InstalledEquipmentRepository', () {
    test('alta, edición y borrado lógico', () async {
      final repo = InstalledEquipmentRepository(db);
      final item = await repo.create(project.id, (
        kind: EquipmentKind.panel,
        brand: '  Canadian Solar ',
        model: 'CS6R-410',
        serialNumber: '',
        installedAt: DateTime.utc(2026, 11, 10, 15),
        warrantyUntil: null,
        notes: null,
      ));
      expect(item.brand, 'Canadian Solar');
      expect(item.serialNumber, isNull);
      expect(item.installedAt, DateTime.utc(2026, 11, 10));
      await repo.softDelete(item.id);
      expect(await repo.watchByProject(project.id).first, isEmpty);
    });

    test('rechaza marca vacía', () {
      expect(
        () => InstalledEquipmentRepository(db).create(project.id, (
          kind: EquipmentKind.other,
          brand: ' ',
          model: null,
          serialNumber: null,
          installedAt: null,
          warrantyUntil: null,
          notes: null,
        )),
        throwsArgumentError,
      );
    });
  });

  group('CommissioningRepository', () {
    test('saveRecord crea y luego reemplaza; strings en orden', () async {
      final repo = CommissioningRepository(db);
      CommissioningInput input(CommissioningStatus s) => (
        status: s,
        testedAt: DateTime.utc(2026, 11, 12),
        technician: 'Luis',
        polarityOk: true,
        insulationMohm: 40,
        insulationTestVoltageV: 1000,
        groundingOk: true,
        groundingOhm: null,
        labelingOk: null,
        notes: null,
      );
      await repo.saveRecord(project.id, input(CommissioningStatus.pending));
      await repo.saveRecord(project.id, input(CommissioningStatus.approved));
      final record = await repo.watchRecord(project.id).first;
      expect(record!.status, CommissioningStatus.approved);
      expect(await db.select(db.commissioningRecords).get(), hasLength(1));

      await repo.addString(project.id, (
        label: 'S1',
        expectedVocV: 400,
        measuredVocV: 398,
        expectedIscA: 10,
        measuredIscA: 9.8,
        polarityOk: true,
      ));
      final s2 = await repo.addString(project.id, (
        label: 'S2',
        expectedVocV: 400,
        measuredVocV: null,
        expectedIscA: null,
        measuredIscA: null,
        polarityOk: null,
      ));
      expect(s2.sortOrder, 1);
      final strings = await repo.watchStrings(project.id).first;
      expect(strings.map((s) => s.label), ['S1', 'S2']);
    });
  });

  group('Mantenimiento', () {
    test('plantilla → plan → visita recorre la próxima fecha', () async {
      final repo = MaintenanceRepository(db);
      final visits = MaintenanceVisitRepository(db);
      await repo.seedTemplateIfEmpty([
        (kind: MaintenanceServiceKind.cleaning, title: null, intervalMonths: 6),
        (
          kind: MaintenanceServiceKind.thermography,
          title: null,
          intervalMonths: 12,
        ),
      ]);
      // Llamar de nuevo no duplica.
      await repo.seedTemplateIfEmpty([
        (kind: MaintenanceServiceKind.other, title: 'X', intervalMonths: 1),
      ]);
      final template = await repo.watchTemplate().first;
      expect(template, hasLength(2));
      await repo.updateTemplateItem(template[1].id, (
        kind: MaintenanceServiceKind.thermography,
        title: null,
        intervalMonths: 12,
      ), enabled: false);

      final created = await repo.createPlanFromTemplate(
        project.id,
        DateTime.utc(2026, 11, 10),
      );
      expect(created, 1);
      final plan = await repo.watchPlan(project.id).first;
      expect(plan.single.nextDueAt, DateTime.utc(2027, 5, 10));

      final upcoming = await repo.watchUpcoming().first;
      expect(upcoming.single.projectName, 'Casa');
      expect(upcoming.single.clientName, 'Ana');

      await visits.logVisit(
        projectId: project.id,
        visitDate: DateTime.utc(2027, 5, 2),
        doneItemIds: [plan.single.id],
        notes: 'Paneles con polvo',
      );
      final after = await repo.watchPlan(project.id).first;
      expect(after.single.lastDoneAt, DateTime.utc(2027, 5, 2));
      expect(after.single.nextDueAt, DateTime.utc(2027, 11, 2));
      expect(await visits.watchVisits(project.id).first, hasLength(1));
    });

    test('rechaza frecuencia fuera de rango', () {
      expect(
        () => MaintenanceRepository(db).addTemplateItem((
          kind: MaintenanceServiceKind.cleaning,
          title: null,
          intervalMonths: 0,
        )),
        throwsArgumentError,
      );
    });
  });

  group('ProductionRepository', () {
    test('una lectura por mes y ajustes con umbral', () async {
      final repo = ProductionRepository(db);
      await repo.saveReading(
        projectId: project.id,
        month: DateTime.utc(2026, 10, 20),
        actualKwh: 600,
        expectedKwh: 700,
      );
      await repo.saveReading(
        projectId: project.id,
        month: DateTime.utc(2026, 10),
        actualKwh: 650,
        expectedKwh: 700,
      );
      final readings = await repo.watchReadings(project.id).first;
      expect(readings.single.actualKwh, 650);
      expect(readings.single.month, DateTime.utc(2026, 10));

      expect(await repo.watchSettings(project.id).first, isNull);
      await repo.saveSettings(
        project.id,
        systemKwp: 5.2,
        alertThresholdPct: -10,
      );
      await repo.saveSettings(
        project.id,
        systemKwp: 5.5,
        alertThresholdPct: -20,
      );
      final settings = await repo.watchSettings(project.id).first;
      expect(settings!.systemKwp, 5.5);
      expect(settings.alertThresholdPct, -20);
    });

    test('rechaza kWh negativos', () {
      expect(
        () => ProductionRepository(db).saveReading(
          projectId: project.id,
          month: DateTime.utc(2026),
          actualKwh: -1,
        ),
        throwsArgumentError,
      );
    });
  });

  test('AppSettings y BackupLog', () async {
    final settings = AppSettingsRepository(db);
    expect(await settings.get('a'), isNull);
    await settings.set('a', '1');
    await settings.set('a', '2');
    expect(await settings.get('a'), '2');
    await settings.set('a', null);
    expect(await settings.get('a'), isNull);

    final logs = BackupLogRepository(db);
    await logs.add(
      target: BackupTarget.zip,
      trigger: BackupTrigger.manual,
      status: BackupStatus.success,
      fileName: 'a.zip',
    );
    await logs.add(
      target: BackupTarget.zip,
      trigger: BackupTrigger.manual,
      status: BackupStatus.failed,
    );
    expect((await logs.lastSuccess(BackupTarget.zip))!.fileName, 'a.zip');
    expect(await logs.lastSuccess(BackupTarget.drive), isNull);
    expect(await logs.watchRecent().first, hasLength(2));
  });
}
