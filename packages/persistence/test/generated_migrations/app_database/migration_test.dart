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
import 'generated/schema_v7.dart' as v7;

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

  test('v6 (reservada para F6) no cambia el esquema de v5', () async {
    final schema = await verifier.schemaAt(5);
    final db = AppDatabase(schema.newConnection());
    await verifier.migrateAndValidate(db, 6);
    await db.close();
    expect(v6.DatabaseAtV6.new, isNotNull);
  });

  test('v5 → v7 conserva el techo y agrega las tablas de diseño', () async {
    const clientId = '11111111-1111-4111-8111-111111111111';
    const projectId = '22222222-2222-4222-8222-222222222222';
    const planeId = '33333333-3333-4333-8333-333333333333';
    const created = '2026-11-14T00:00:00.000Z';
    await verifier.testWithDataIntegrity(
      oldVersion: 5,
      newVersion: 7,
      createOld: v5.DatabaseAtV5.new,
      createNew: v7.DatabaseAtV7.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch
          ..insertAll(oldDb.clients, const [
            v5.ClientsData(
              id: clientId,
              createdAt: created,
              updatedAt: created,
              name: 'Ana López',
            ),
          ])
          ..insertAll(oldDb.projects, const [
            v5.ProjectsData(
              id: projectId,
              createdAt: created,
              updatedAt: created,
              clientId: clientId,
              name: 'Casa Cumbres',
              status: 'design',
              projectDate: created,
            ),
          ])
          ..insertAll(oldDb.roofPlanes, const [
            v5.RoofPlanesData(
              id: planeId,
              createdAt: created,
              updatedAt: created,
              projectId: projectId,
              name: 'Plano 1',
              polygon: '[[0,0],[10,0],[10,8],[0,8]]',
              tiltDeg: 0,
              tiltSource: 'manual',
              azimuthDeg: 180,
              edgeSetbackM: 0.3,
              walkways: '[]',
              sortOrder: 0,
            ),
          ]);
      },
      validateItems: (newDb) async {
        final planes = await newDb.select(newDb.roofPlanes).get();
        expect(planes.single.edgeSetbackM, 0.3);
        expect(await newDb.select(newDb.panelModels).get(), isEmpty);
        expect(await newDb.select(newDb.arrayLayouts).get(), isEmpty);
        expect(await newDb.select(newDb.simulationResults).get(), isEmpty);
      },
    );
  });

  test('tras migrar a v7 se guarda un diseño completo', () async {
    final schema = await verifier.schemaAt(5);
    final db = AppDatabase(schema.newConnection());
    await verifier.migrateAndValidate(db, 7);
    final client = await ClientRepository(db).create(name: 'Ana López');
    final project = await ProjectRepository(db).create(
      clientId: client.id,
      name: 'Casa Cumbres',
      projectDate: DateTime.utc(2026, 11, 14),
    );
    final panel = await PanelModelRepository(db).save(
      PanelModelsCompanion.insert(
        manufacturer: 'Marca',
        model: 'P-550',
        pmaxW: 550,
        vocV: 49.6,
        iscA: 14,
        vmpV: 41.7,
        impA: 13.2,
        lengthM: 2.278,
        widthM: 1.134,
      ),
    );
    final design = await PvDesignRepository(db)
        .save(project.id, PvDesignsCompanion(panelModelId: Value(panel.id)));
    expect(design.shadeThresholdPct, 10);
    expect(design.systemVoltageLimitV, 600);
    await db.close();
  });
}
