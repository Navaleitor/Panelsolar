import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// Genera un UUID v4 nuevo. Es pública porque drift copia la expresión
/// `clientDefault` al código generado (`app_database.g.dart`).
String newUuid() => const Uuid().v4();

/// Columnas comunes a TODAS las tablas (convención base, plan B.3).
///
/// - `id`: UUID v4 en texto. Permite fusionar/restaurar respaldos sin choques.
/// - `createdAt` / `updatedAt`: fecha en UTC; los repositorios actualizan
///   `updatedAt` en cada cambio.
/// - `deletedAt`: borrado lógico. `null` = registro activo. Nunca se borra
///   físicamente desde la UI.
mixin BaseColumns on Table {
  /// Identificador UUID v4.
  TextColumn get id => text().clientDefault(newUuid)();

  /// Momento de creación (UTC).
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();

  /// Momento de la última modificación (UTC).
  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
