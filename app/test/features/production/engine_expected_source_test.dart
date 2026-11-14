import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/production/data/engine_expected_source.dart';
import 'package:persistence/persistence.dart';

void main() {
  late AppDatabase db;
  late Project project;
  setUp(() async {
    db = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
    final client = await ClientRepository(db).create(name: 'Ana');
    project = await ProjectRepository(db).create(
      clientId: client.id,
      name: 'Casa',
      projectDate: DateTime.utc(2026),
    );
  });
  tearDown(() => db.close());

  test(
    'esperado = kWh/kWp del mes × kWp; sin kWp o sitio no propone',
    () async {
      var calls = 0;
      final source = EngineExpectedSource(
        sites: SiteRepository(db),
        production: ProductionRepository(db),
        analyze: (job) async {
          calls++;
          expect(job.latitude, 25.7);
          return [for (var m = 1; m <= 12; m++) 100.0 + m];
        },
      );
      expect(
        await source.expectedFor(project.id, DateTime.utc(2026, 3)),
        isNull,
      );
      await ProductionRepository(db)
          .saveSettings(project.id, systemKwp: 5, alertThresholdPct: -15);
      expect(
        await source.expectedFor(project.id, DateTime.utc(2026, 3)),
        isNull,
      );
      await SiteRepository(db).save(
        projectId: project.id,
        latitude: 25.7,
        longitude: -100.3,
        source: LocationSource.manual,
      );
      final march = await source.expectedFor(project.id, DateTime.utc(2026, 3));
      expect(march!.expectedKwh, 515);
      final july = await source.expectedFor(project.id, DateTime.utc(2026, 7));
      expect(july!.expectedKwh, 535);
      expect(calls, 1, reason: 'el análisis se guarda en memoria');
    },
  );

  test('si el motor falla (sin red) no propone nada', () async {
    await ProductionRepository(db)
        .saveSettings(project.id, systemKwp: 5, alertThresholdPct: -15);
    await SiteRepository(db).save(
      projectId: project.id,
      latitude: 25.7,
      longitude: -100.3,
      source: LocationSource.manual,
    );
    final source = EngineExpectedSource(
      sites: SiteRepository(db),
      production: ProductionRepository(db),
      analyze: (job) => throw Exception('sin red'),
    );
    expect(await source.expectedFor(project.id, DateTime.utc(2026)), isNull);
  });
}
