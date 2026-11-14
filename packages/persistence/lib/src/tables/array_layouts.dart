import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';
import 'package:persistence/src/tables/roof_planes.dart';

/// Paneles colocados en un plano del techo (uno por plano).
///
/// Historial de esquema:
/// - v7: tabla nueva (F4).
@DataClassName('ArrayLayout')
class ArrayLayouts extends Table with BaseColumns {
  /// Proyecto.
  TextColumn get projectId => text().references(Projects, #id)();

  /// Plano del techo.
  TextColumn get roofPlaneId => text().references(RoofPlanes, #id)();

  /// Panel usado (`panel_models.id`).
  TextColumn get panelModelId => text().nullable()();

  /// Vertical u horizontal.
  TextColumn get orientation => textEnum<LayoutOrientation>().withDefault(
    Constant(LayoutOrientation.portrait.name),
  )();

  /// Pegado al techo o en estructura inclinada.
  TextColumn get mount =>
      textEnum<MountType>().withDefault(Constant(MountType.flush.name))();

  /// Inclinación de la estructura (grados), solo en techo plano.
  RealColumn get rackTiltDeg => real().withDefault(const Constant(15))();

  /// Azimut de la estructura (grados).
  RealColumn get rackAzimuthDeg => real().withDefault(const Constant(180))();

  /// Separación entre paneles de una fila (m).
  RealColumn get gapM => real().withDefault(const Constant(0.02))();

  /// Separación entre filas pegadas al techo (m).
  RealColumn get rowGapM => real().withDefault(const Constant(0.02))();

  /// Holgura alrededor de obstáculos (m).
  RealColumn get clearanceM => real().withDefault(const Constant(0.3))();

  /// Separación libre entre filas de estructura calculada (m).
  RealColumn get rowSpacingM => real().nullable()();

  /// Paneles en JSON `[{"c":[[x,y],...4],"r":fila,"k":col,"on":true}]`
  /// (metros locales; `on` = falso si el usuario lo quitó).
  TextColumn get panels => text().withDefault(const Constant('[]'))();
}
