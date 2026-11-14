import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';

/// Panel del catálogo (hoja de datos en STC). Unidades SI; coeficientes
/// de temperatura en %/°C.
///
/// Historial de esquema:
/// - v7: tabla nueva (F4).
@DataClassName('PanelModel')
class PanelModels extends Table with BaseColumns {
  /// Fabricante.
  TextColumn get manufacturer => text()();

  /// Modelo.
  TextColumn get model => text()();

  /// Potencia máxima (W).
  RealColumn get pmaxW => real()();

  /// Tensión de circuito abierto (V).
  RealColumn get vocV => real()();

  /// Corriente de cortocircuito (A).
  RealColumn get iscA => real()();

  /// Tensión en máxima potencia (V).
  RealColumn get vmpV => real()();

  /// Corriente en máxima potencia (A).
  RealColumn get impA => real()();

  /// Coeficiente de Pmax (%/°C).
  RealColumn get gammaPmaxPct => real().withDefault(const Constant(-0.35))();

  /// Coeficiente de Voc (%/°C).
  RealColumn get betaVocPct => real().withDefault(const Constant(-0.28))();

  /// Coeficiente de Vmp (%/°C).
  RealColumn get betaVmpPct => real().withDefault(const Constant(-0.37))();

  /// Largo (m).
  RealColumn get lengthM => real()();

  /// Ancho (m).
  RealColumn get widthM => real()();

  /// Peso (kg).
  RealColumn get weightKg => real().nullable()();

  /// Tipo de celda.
  TextColumn get cellType =>
      textEnum<CellType>().withDefault(Constant(CellType.mono.name))();

  /// Número de celdas.
  IntColumn get cellCount => integer().nullable()();

  /// Bifacial.
  BoolColumn get bifacial => boolean().withDefault(const Constant(false))();

  /// Bifacialidad (%), si es bifacial.
  RealColumn get bifacialityPct => real().nullable()();

  /// Fusible máximo en serie (A).
  RealColumn get maxSeriesFuseA => real().nullable()();

  /// Tensión máxima del sistema (V).
  RealColumn get maxSystemVoltageV => real().nullable()();

  /// Origen.
  TextColumn get source => textEnum<EquipmentSource>().withDefault(
    Constant(EquipmentSource.manual.name),
  )();

  /// Notas.
  TextColumn get notes => text().nullable()();
}
