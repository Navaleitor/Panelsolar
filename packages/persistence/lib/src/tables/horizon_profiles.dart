import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Perfil de horizonte (B.3): elevación (grados) por azimut (grados desde
/// el norte). Uno de terreno (PVGIS) por proyecto y uno por cada obstáculo
/// lejano medido en sitio.
///
/// La clase de fila se llama `HorizonProfileRecord` para no chocar con
/// `HorizonProfile` del motor solar.
///
/// Historial de esquema:
/// - v5: tabla nueva (F3).
@DataClassName('HorizonProfileRecord')
class HorizonProfiles extends Table with BaseColumns {
  /// Proyecto.
  TextColumn get projectId => text().references(Projects, #id)();

  /// Origen: terreno, manual o cámara.
  TextColumn get source => textEnum<HorizonSource>()();

  /// Nombre visible ("Árbol del vecino").
  TextColumn get name => text().nullable()();

  /// Puntos en JSON `[[azimut, elevación], ...]` (grados).
  TextColumn get points => text()();
}
