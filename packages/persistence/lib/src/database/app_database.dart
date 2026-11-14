import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.steps.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/clients.dart';
import 'package:persistence/src/tables/companies.dart';
import 'package:persistence/src/tables/documents.dart';
import 'package:persistence/src/tables/horizon_profiles.dart';
import 'package:persistence/src/tables/obstacles.dart';
import 'package:persistence/src/tables/photos.dart';
import 'package:persistence/src/tables/projects.dart';
import 'package:persistence/src/tables/roof_images.dart';
import 'package:persistence/src/tables/roof_planes.dart';
import 'package:persistence/src/tables/sites.dart';
import 'package:persistence/src/tables/utility_bills.dart';

part 'app_database.g.dart';

/// Base de datos principal de Panelsolar (SQLite vía drift).
///
/// Para cambiar el esquema: ver `packages/persistence/README.md`.
@DriftDatabase(
  tables: [
    Companies,
    Clients,
    Projects,
    Sites,
    UtilityBills,
    Photos,
    Documents,
    RoofImages,
    RoofPlanes,
    Obstacles,
    HorizonProfiles,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Crea la base con el ejecutor dado (archivo en la app, memoria en pruebas).
  new(super.e);

  @override
  int get schemaVersion => 5;

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
      // F1: clientes, proyectos, sitio, recibos, fotos y documentos.
      from2To3: (m, schema) async {
        await m.createTable(schema.clients);
        await m.createTable(schema.projects);
        await m.createTable(schema.sites);
        await m.createTable(schema.utilityBills);
        await m.createTable(schema.photos);
        await m.createTable(schema.documents);
      },
      // v4 está reservada para F6 (instalación, mantenimiento y respaldo),
      // que avanza en paralelo; aquí no cambia nada. Al integrar, el chat
      // principal sustituye este paso por el de F6.
      from3To4: (m, schema) async {},
      // F3: techo (imagen o croquis), planos, obstáculos y horizonte.
      from4To5: (m, schema) async {
        await m.createTable(schema.roofImages);
        await m.createTable(schema.roofPlanes);
        await m.createTable(schema.obstacles);
        await m.createTable(schema.horizonProfiles);
      },
    ),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
