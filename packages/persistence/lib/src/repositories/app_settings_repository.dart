import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Acceso a `app_settings`: ajustes clave → valor.
class AppSettingsRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  /// Valor de [key] o `null`.
  Future<String?> get(String key) async => (await (_db.select(
    _db.appSettings,
  )..where((s) => s.key.equals(key))).getSingleOrNull())?.value;

  /// Valor de [key] (y sus cambios).
  Stream<String?> watch(String key) => (_db.select(
    _db.appSettings,
  )..where((s) => s.key.equals(key))).watchSingleOrNull().map((s) => s?.value);

  /// Guarda [value] en [key]; `null` borra la clave.
  Future<void> set(String key, String? value) async {
    if (value == null) {
      await (_db.delete(_db.appSettings)..where((s) => s.key.equals(key))).go();
      return;
    }
    await _db
        .into(_db.appSettings)
        .insert(
          AppSettingsCompanion.insert(key: key, value: value),
          onConflict: DoUpdate(
            (_) => AppSettingsCompanion(
              value: Value(value),
              updatedAt: Value(utcNow()),
            ),
            target: [_db.appSettings.key],
          ),
        );
  }
}
