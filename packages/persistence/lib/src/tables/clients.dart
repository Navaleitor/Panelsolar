import 'package:drift/drift.dart';
import 'package:persistence/src/tables/base_columns.dart';

/// Cliente del instalador: datos de contacto. Un cliente tiene varios
/// proyectos (`projects`) y recibos de luz (`utility_bills`).
///
/// Historial de esquema:
/// - v3: tabla nueva (F1).
@DataClassName('Client')
class Clients extends Table with BaseColumns {
  /// Nombre o razón social (obligatorio).
  TextColumn get name => text().withLength(min: 1, max: 200)();

  /// Teléfono de contacto.
  TextColumn get phone => text().nullable()();

  /// Correo de contacto.
  TextColumn get email => text().nullable()();

  /// Dirección postal (texto libre).
  TextColumn get address => text().nullable()();

  /// Notas libres.
  TextColumn get notes => text().nullable()();
}
