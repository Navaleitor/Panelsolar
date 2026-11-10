import 'package:drift/drift.dart';
import 'package:persistence/src/tables/base_columns.dart';

/// Perfil de la empresa instaladora (datos para reportes y cotizaciones).
///
/// Historial de esquema:
/// - v1: name, phone, email.
/// - v2: taxId, logoPath (migración de ejemplo de F0).
@DataClassName('Company')
class Companies extends Table with BaseColumns {
  /// Nombre comercial (obligatorio).
  TextColumn get name => text().withLength(min: 1, max: 200)();

  /// Teléfono de contacto.
  TextColumn get phone => text().nullable()();

  /// Correo de contacto.
  TextColumn get email => text().nullable()();

  /// Identificador fiscal (RFC en México). Agregado en v2.
  TextColumn get taxId => text().nullable()();

  /// Ruta local del logo para reportes. Agregado en v2.
  TextColumn get logoPath => text().nullable()();
}
