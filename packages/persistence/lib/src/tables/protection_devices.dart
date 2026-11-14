import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Protección del sistema (calculada y editable).
///
/// Historial de esquema:
/// - v7: tabla nueva (F4).
@DataClassName('ProtectionDevice')
class ProtectionDevices extends Table with BaseColumns {
  /// Proyecto.
  TextColumn get projectId => text().references(Projects, #id)();

  /// Tipo.
  TextColumn get kind => textEnum<ProtectionDeviceKind>()();

  /// Corriente nominal (A).
  RealColumn get ratingA => real().nullable()();

  /// Tensión (V).
  RealColumn get voltageV => real().nullable()();

  /// Cantidad.
  IntColumn get quantity => integer().withDefault(const Constant(1))();

  /// Calibre (solo conductor de tierra).
  TextColumn get conductorSize => text().nullable()();

  /// Notas.
  TextColumn get notes => text().nullable()();
}
