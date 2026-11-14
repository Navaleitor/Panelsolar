import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Plano (agua) del techo: polígono en metros, coordenadas locales del
/// sitio (x = este, y = norte), vista desde arriba.
///
/// Historial de esquema:
/// - v5: tabla nueva (F3).
@DataClassName('RoofPlane')
class RoofPlanes extends Table with BaseColumns {
  /// Proyecto.
  TextColumn get projectId => text().references(Projects, #id)();

  /// Nombre visible ("Plano 1", "Agua sur"...).
  TextColumn get name => text()();

  /// Vértices en JSON `[[x,y],...]` (metros).
  TextColumn get polygon => text()();

  /// Inclinación (grados, 0 = plano).
  RealColumn get tiltDeg => real().withDefault(const Constant(0))();

  /// De dónde salió la inclinación.
  TextColumn get tiltSource =>
      textEnum<TiltSource>().withDefault(Constant(TiltSource.manual.name))();

  /// Azimut hacia donde baja el plano (grados, 180 = sur).
  RealColumn get azimuthDeg => real().withDefault(const Constant(180))();

  /// Arista elegida como orilla baja para calcular el azimut, si hay.
  IntColumn get azimuthEdgeIndex => integer().nullable()();

  /// Retiro de borde (m) en todo el contorno.
  RealColumn get edgeSetbackM => real().withDefault(const Constant(0))();

  /// Pasillos de mantenimiento en JSON
  /// `[{"a":[x,y],"b":[x,y],"w":ancho}]` (metros).
  TextColumn get walkways => text().withDefault(const Constant('[]'))();

  /// Orden en la lista.
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
