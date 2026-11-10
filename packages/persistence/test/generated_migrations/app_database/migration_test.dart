// Prueba de migraciones del esquema (plan D: "cada migración desde la versión
// anterior sin pérdida"). Esqueleto creado por `drift_dev make-migrations` y
// adaptado a `package:test` (este paquete es Dart puro, sin Flutter).
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:persistence/persistence.dart';
import 'package:test/test.dart';

import 'generated/schema.dart';
import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;

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
}
