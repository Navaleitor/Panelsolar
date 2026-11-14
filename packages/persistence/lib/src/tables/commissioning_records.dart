import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Checklist de puesta en marcha de un proyecto (IEC 62446-1). Uno por
/// proyecto; las mediciones por string van en `string_tests`.
///
/// En los campos `...Ok`: `null` = sin revisar, `true` = correcto,
/// `false` = con falla.
///
/// Historial de esquema:
/// - v6: tabla nueva (F6).
@DataClassName('CommissioningRecord')
class CommissioningRecords extends Table with BaseColumns {
  /// Proyecto (único).
  TextColumn get projectId => text().unique().references(Projects, #id)();

  /// Pendiente, aprobado u observaciones.
  TextColumn get status => textEnum<CommissioningStatus>()();

  /// Fecha de la prueba.
  DateTimeColumn get testedAt => dateTime().nullable()();

  /// Quién hizo la prueba.
  TextColumn get technician => text().nullable()();

  /// Polaridad de todos los strings correcta.
  BoolColumn get polarityOk => boolean().nullable()();

  /// Resistencia de aislamiento medida (MΩ).
  RealColumn get insulationMohm => real().nullable()();

  /// Tensión de prueba del megóhmetro (V).
  RealColumn get insulationTestVoltageV => real().nullable()();

  /// Continuidad de la puesta a tierra correcta.
  BoolColumn get groundingOk => boolean().nullable()();

  /// Resistencia de puesta a tierra medida (Ω), si se midió.
  RealColumn get groundingOhm => real().nullable()();

  /// Etiquetado y señalización completos.
  BoolColumn get labelingOk => boolean().nullable()();

  /// Observaciones.
  TextColumn get notes => text().nullable()();
}
