import 'package:drift/drift.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Producción mensual real leída del inversor, con lo esperado.
///
/// Historial de esquema:
/// - v4: tabla nueva (F6).
@DataClassName('ProductionReading')
class ProductionReadings extends Table with BaseColumns {
  /// Proyecto al que pertenece.
  TextColumn get projectId => text().references(Projects, #id)();

  /// Mes (día 1 del mes, UTC).
  DateTimeColumn get month => dateTime()();

  /// Energía real del mes (kWh).
  RealColumn get actualKwh => real()();

  /// Energía esperada del mes (kWh): a mano ahora; del motor (F2) después.
  RealColumn get expectedKwh => real().nullable()();

  /// Irradiación en el plano de los paneles del mes (kWh/m²), para el PR.
  RealColumn get poaIrradiationKwhM2 => real().nullable()();

  /// Notas.
  TextColumn get notes => text().nullable()();
}
