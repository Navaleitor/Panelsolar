import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:persistence/persistence.dart';

/// Tablas que **no** se reemplazan al restaurar: son propias de este
/// teléfono (historial de respaldos y ajustes como la cuenta de Drive).
const Set<String> deviceOnlyTables = {'backup_logs', 'app_settings'};

/// Tablas que se cuentan en la vista previa.
const List<String> previewTables = [
  'clients',
  'projects',
  'photos',
  'documents',
  'maintenance_visits',
  'production_readings',
];

/// Copia la base abierta [db] a [target] (archivo SQLite compacto) con
/// `VACUUM INTO`, sin cerrar la base.
Future<void> writeSnapshot(AppDatabase db, File target) async {
  if (target.existsSync()) target.deleteSync();
  await db.customStatement('VACUUM INTO ?', [target.path]);
}

/// Registros activos de las tablas de [previewTables] en [db].
Future<Map<String, int>> activeCounts(AppDatabase db) async {
  final counts = <String, int>{};
  for (final table in previewTables) {
    final row = await db
        .customSelect(
          'SELECT COUNT(*) AS n FROM "$table" WHERE deleted_at IS NULL',
        )
        .getSingle();
    counts[table] = row.read<int>('n');
  }
  return counts;
}

/// Abre la foto [snapshot] como base de la app (aplica migraciones si
/// viene de una versión anterior) y devuelve sus conteos.
Future<Map<String, int>> upgradeSnapshot(File snapshot) async {
  // Es otro archivo (no la base de la app): abrir dos instancias es seguro.
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  final db = AppDatabase(NativeDatabase(snapshot));
  try {
    return await activeCounts(db);
  } finally {
    await db.close();
  }
}

/// Reemplaza el contenido de [db] por el de [snapshot] (ya migrado con
/// [upgradeSnapshot]). Todo o nada: si algo falla, la base queda igual.
Future<void> restoreSnapshot(AppDatabase db, File snapshot) async {
  final tables = [
    for (final t in db.allTables)
      if (!deviceOnlyTables.contains(t.actualTableName)) t,
  ];
  await db.customStatement('ATTACH DATABASE ? AS snap', [snapshot.path]);
  try {
    await db.transaction(() async {
      await db.customStatement('PRAGMA defer_foreign_keys = ON');
      for (final t in tables.reversed) {
        await db.customStatement('DELETE FROM "${t.actualTableName}"');
      }
      for (final t in tables) {
        final cols = t.$columns.map((c) => '"${c.name}"').join(', ');
        await db.customStatement(
          'INSERT INTO main."${t.actualTableName}" ($cols) '
          'SELECT $cols FROM snap."${t.actualTableName}"',
        );
      }
    });
  } finally {
    await db.customStatement('DETACH DATABASE snap');
  }
  db.notifyUpdates({for (final t in tables) TableUpdate.onTable(t)});
}
