// Prueba de migraciones del esquema (plan D: "cada migración desde la versión
// anterior sin pérdida"). Esqueleto creado por `drift_dev make-migrations` y
// adaptado a `package:test` (este paquete es Dart puro, sin Flutter).
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift_dev/api/migrations_native.dart';
import 'package:persistence/persistence.dart';
import 'package:test/test.dart';

import 'generated/schema.dart';
import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;
import 'generated/schema_v3.dart' as v3;
import 'generated/schema_v4.dart' as v4;
import 'generated/schema_v5.dart' as v5;
import 'generated/schema_v6.dart' as v6;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('cada versión migra a todas las posteriores', () {
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('desde v$fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('a v$toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  test('v1 → v2 conserva los datos y agrega columnas vacías', () async {
    const id = '0b9f5f0e-3c1a-4b8e-9d2f-0a1b2c3d4e5f';
    const created = '2026-01-01T00:00:00.000Z';
    const updated = '2026-02-01T00:00:00.000Z';

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.companies, const [
          v1.CompaniesData(
            id: id,
            createdAt: created,
            updatedAt: updated,
            name: 'Solar del Norte',
            phone: '+52 81 0000 0000',
            email: 'contacto@example.com',
          ),
        ]);
      },
      validateItems: (newDb) async {
        expect(await newDb.select(newDb.companies).get(), const [
          v2.CompaniesData(
            id: id,
            createdAt: created,
            updatedAt: updated,
            name: 'Solar del Norte',
            phone: '+52 81 0000 0000',
            email: 'contacto@example.com',
          ),
        ]);
      },
    );
  });

  test('v2 → v3 conserva la empresa y crea las tablas de F1', () async {
    const id = '1c2d3e4f-5a6b-4c7d-8e9f-0a1b2c3d4e5f';
    const created = '2026-03-01T00:00:00.000Z';
    const company = v2.CompaniesData(
      id: id,
      createdAt: created,
      updatedAt: created,
      name: 'Solar del Norte',
      taxId: 'SNO010101AAA',
      logoPath: 'logo.png',
    );

    await verifier.testWithDataIntegrity(
      oldVersion: 2,
      newVersion: 3,
      createOld: v2.DatabaseAtV2.new,
      createNew: v3.DatabaseAtV3.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.companies, const [company]);
      },
      validateItems: (newDb) async {
        expect(await newDb.select(newDb.companies).get(), const [
          v3.CompaniesData(
            id: id,
            createdAt: created,
            updatedAt: created,
            name: 'Solar del Norte',
            taxId: 'SNO010101AAA',
            logoPath: 'logo.png',
          ),
        ]);
        expect(await newDb.select(newDb.clients).get(), isEmpty);
        expect(await newDb.select(newDb.projects).get(), isEmpty);
        expect(await newDb.select(newDb.sites).get(), isEmpty);
        expect(await newDb.select(newDb.utilityBills).get(), isEmpty);
        expect(await newDb.select(newDb.photos).get(), isEmpty);
        expect(await newDb.select(newDb.documents).get(), isEmpty);
      },
    );
  });

  test('tras migrar a v3 se pueden guardar clientes y proyectos', () async {
    final schema = await verifier.schemaAt(2);
    final db = AppDatabase(schema.newConnection());
    await verifier.migrateAndValidate(db, 3);

    final client = await ClientRepository(db).create(name: 'Ana López');
    final project = await ProjectRepository(db).create(
      clientId: client.id,
      name: 'Casa Cumbres',
      projectDate: DateTime.utc(2026, 11, 10),
    );
    expect(project.status, ProjectStatus.prospect);
    await db.close();
  });

  test(
    'v3 → v5 conserva clientes y proyectos y crea las tablas del techo',
    () async {
      const created = '2026-11-01T00:00:00.000Z';
      const clientId = '2d3e4f5a-6b7c-4d8e-9f0a-1b2c3d4e5f60';
      const projectId = '3e4f5a6b-7c8d-4e9f-8a1b-2c3d4e5f6071';

      await verifier.testWithDataIntegrity(
        oldVersion: 3,
        newVersion: 5,
        createOld: v3.DatabaseAtV3.new,
        createNew: v5.DatabaseAtV5.new,
        openTestedDatabase: AppDatabase.new,
        createItems: (batch, oldDb) {
          batch
            ..insertAll(oldDb.clients, const [
              v3.ClientsData(
                id: clientId,
                createdAt: created,
                updatedAt: created,
                name: 'Ana López',
              ),
            ])
            ..insertAll(oldDb.projects, const [
              v3.ProjectsData(
                id: projectId,
                createdAt: created,
                updatedAt: created,
                clientId: clientId,
                name: 'Casa Cumbres',
                status: 'design',
                projectDate: created,
              ),
            ]);
        },
        validateItems: (newDb) async {
          expect(await newDb.select(newDb.clients).get(), const [
            v5.ClientsData(
              id: clientId,
              createdAt: created,
              updatedAt: created,
              name: 'Ana López',
            ),
          ]);
          expect(await newDb.select(newDb.projects).get(), hasLength(1));
          expect(await newDb.select(newDb.roofImages).get(), isEmpty);
          expect(await newDb.select(newDb.roofPlanes).get(), isEmpty);
          expect(await newDb.select(newDb.obstacles).get(), isEmpty);
          expect(await newDb.select(newDb.horizonProfiles).get(), isEmpty);
        },
      );
    },
  );

  test('v4 (reservada para F6) no cambia el esquema de v3', () async {
    final schema = await verifier.schemaAt(3);
    final db = AppDatabase(schema.newConnection());
    await verifier.migrateAndValidate(db, 4);
    await db.close();
    expect(v4.DatabaseAtV4.new, isNotNull);
  });

  test('tras migrar a v5 se guarda el techo de un proyecto', () async {
    final schema = await verifier.schemaAt(3);
    final db = AppDatabase(schema.newConnection());
    await verifier.migrateAndValidate(db, 5);

    final client = await ClientRepository(db).create(name: 'Ana López');
    final project = await ProjectRepository(db).create(
      clientId: client.id,
      name: 'Casa Cumbres',
      projectDate: DateTime.utc(2026, 11, 14),
    );
    await RoofImageRepository(db).startSketch(project.id);
    final plane = await RoofPlaneRepository(db).add(
      projectId: project.id,
      name: 'Plano 1',
      polygon: '[[0,0],[10,0],[10,8],[0,8]]',
    );
    expect(plane.tiltDeg, 0);
    expect(plane.azimuthDeg, 180);
    expect(plane.walkways, '[]');
    await db.close();
  });

  test(
    'v3 → v6 conserva clientes, proyectos y fotos y crea las tablas de F6',
    () async {
      const t = '2026-11-01T00:00:00.000Z';
      await verifier.testWithDataIntegrity(
        oldVersion: 3,
        newVersion: 6,
        createOld: v3.DatabaseAtV3.new,
        createNew: v6.DatabaseAtV6.new,
        openTestedDatabase: AppDatabase.new,
        createItems: (batch, oldDb) {
          batch
            ..insertAll(oldDb.clients, const [
              v3.ClientsData(id: 'c1', createdAt: t, updatedAt: t, name: 'Ana'),
            ])
            ..insertAll(oldDb.projects, const [
              v3.ProjectsData(
                id: 'p1',
                createdAt: t,
                updatedAt: t,
                clientId: 'c1',
                name: 'Casa',
                status: 'installed',
                projectDate: t,
              ),
            ])
            ..insertAll(oldDb.photos, const [
              v3.PhotosData(
                id: 'f1',
                createdAt: t,
                updatedAt: t,
                projectId: 'p1',
                stage: 'installation',
                filePath: 'projects/p1/photos/abc.jpg',
                sha256: 'abc',
                widthPx: 1600,
                heightPx: 1200,
              ),
            ]);
        },
        validateItems: (newDb) async {
          expect(await newDb.select(newDb.clients).get(), const [
            v6.ClientsData(id: 'c1', createdAt: t, updatedAt: t, name: 'Ana'),
          ]);
          expect(await newDb.select(newDb.projects).get(), hasLength(1));
          expect(await newDb.select(newDb.photos).get(), const [
            v6.PhotosData(
              id: 'f1',
              createdAt: t,
              updatedAt: t,
              projectId: 'p1',
              stage: 'installation',
              filePath: 'projects/p1/photos/abc.jpg',
              sha256: 'abc',
              widthPx: 1600,
              heightPx: 1200,
            ),
          ]);
          expect(await newDb.select(newDb.installedEquipment).get(), isEmpty);
          expect(await newDb.select(newDb.maintenancePlanItems).get(), isEmpty);
          expect(await newDb.select(newDb.productionReadings).get(), isEmpty);
          expect(await newDb.select(newDb.backupLogs).get(), isEmpty);
          expect(await newDb.select(newDb.appSettings).get(), isEmpty);
        },
      );
    },
  );

  test('v5 → v6 conserva el techo y el horizonte de F3', () async {
    const t = '2026-11-14T00:00:00.000Z';
    const plane = v5.RoofPlanesData(
      id: 'r1',
      createdAt: t,
      updatedAt: t,
      projectId: 'p1',
      name: 'Losa',
      polygon: '[[0,0],[10,0],[10,8]]',
      tiltDeg: 5,
      tiltSource: 'manual',
      azimuthDeg: 180,
      edgeSetbackM: 0.5,
      walkways: '[]',
      sortOrder: 0,
    );
    const horizon = v5.HorizonProfilesData(
      id: 'h1',
      createdAt: t,
      updatedAt: t,
      projectId: 'p1',
      source: 'manual',
      points: '[[180,12]]',
    );
    await verifier.testWithDataIntegrity(
      oldVersion: 5,
      newVersion: 6,
      createOld: v5.DatabaseAtV5.new,
      createNew: v6.DatabaseAtV6.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch
          ..insertAll(oldDb.clients, const [
            v5.ClientsData(id: 'c1', createdAt: t, updatedAt: t, name: 'Ana'),
          ])
          ..insertAll(oldDb.projects, const [
            v5.ProjectsData(
              id: 'p1',
              createdAt: t,
              updatedAt: t,
              clientId: 'c1',
              name: 'Casa',
              status: 'design',
              projectDate: t,
            ),
          ])
          ..insertAll(oldDb.roofPlanes, const [plane])
          ..insertAll(oldDb.horizonProfiles, const [horizon]);
      },
      validateItems: (newDb) async {
        final planes = await newDb.select(newDb.roofPlanes).get();
        expect(planes.single.toJson(), plane.toJson());
        final horizons = await newDb.select(newDb.horizonProfiles).get();
        expect(horizons.single.toJson(), horizon.toJson());
        expect(await newDb.select(newDb.stringTests).get(), isEmpty);
      },
    );
  });

  test('tras migrar a v6 se guardan equipos y lecturas', () async {
    final schema = await verifier.schemaAt(5);
    final db = AppDatabase(schema.newConnection());
    await verifier.migrateAndValidate(db, 6);
    final client = await ClientRepository(db).create(name: 'Ana');
    final project = await ProjectRepository(db).create(
      clientId: client.id,
      name: 'Casa',
      projectDate: DateTime.utc(2026, 11),
    );
    await InstalledEquipmentRepository(db).create(project.id, (
      kind: EquipmentKind.inverter,
      brand: 'Fronius',
      model: 'Primo 5.0',
      serialNumber: 'SN-1',
      installedAt: null,
      warrantyUntil: DateTime.utc(2036, 11),
      notes: null,
    ));
    await ProductionRepository(db).saveReading(
      projectId: project.id,
      month: DateTime.utc(2026, 10),
      actualKwh: 640,
    );
    expect(
      await ProductionRepository(db).watchReadings(project.id).first,
      hasLength(1),
    );
    await db.close();
  });
}
