import 'package:drift/drift.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Medición de un string en la puesta en marcha: Voc e Isc esperados
/// (editables) contra medidos.
///
/// Historial de esquema:
/// - v4: tabla nueva (F6).
@DataClassName('StringTest')
class StringTests extends Table with BaseColumns {
  /// Proyecto al que pertenece.
  TextColumn get projectId => text().references(Projects, #id)();

  /// Nombre del string (p. ej. "S1").
  TextColumn get label => text().withLength(min: 1, max: 40)();

  /// Orden en la lista.
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  /// Voc esperado (V).
  RealColumn get expectedVocV => real().nullable()();

  /// Voc medido (V).
  RealColumn get measuredVocV => real().nullable()();

  /// Isc esperado (A).
  RealColumn get expectedIscA => real().nullable()();

  /// Isc medido (A).
  RealColumn get measuredIscA => real().nullable()();

  /// Polaridad correcta (`null` = sin revisar).
  BoolColumn get polarityOk => boolean().nullable()();
}
