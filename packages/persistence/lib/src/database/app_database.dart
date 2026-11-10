import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.steps.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/companies.dart';

part 'app_database.g.dart';

/// Base de datos principal de Panelsolar (SQLite vía drift).
///
/// Para cambiar el esquema: ver `packages/persistence/README.md`.
@DriftDatabase(tables: [Companies])
class AppDatabase extends _$AppDatabase {
  /// Crea la base con el ejecutor dado (archivo en la app, memoria en pruebas).
  new(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    // Una función por salto de versión; `schema` es una foto fija del
    // esquema en esa versión (generada en app_database.steps.dart).
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.addColumn(schema.companies, schema.companies.taxId);
        await m.addColumn(schema.companies, schema.companies.logoPath);
      },
    ),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
