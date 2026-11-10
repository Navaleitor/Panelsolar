import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistence/persistence.dart';

/// Base de datos única de la app (archivo `panelsolar.sqlite` en el
/// directorio de documentos). Se cierra al destruir el contenedor.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase(driftDatabase(name: 'panelsolar'));
  ref.onDispose(db.close);
  return db;
});

/// Abre la base (aplicando migraciones) y devuelve la versión de esquema.
/// Sirve como verificación de salud en Ajustes.
final databaseHealthProvider = FutureProvider<int>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  await db.customSelect('SELECT 1').get();
  return db.schemaVersion;
});
