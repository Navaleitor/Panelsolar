import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Tramo de cableado con lo que captura el instalador y el resultado.
///
/// Historial de esquema:
/// - v7: tabla nueva (F4).
@DataClassName('ElectricalRun')
class ElectricalRuns extends Table with BaseColumns {
  /// Proyecto.
  TextColumn get projectId => text().references(Projects, #id)();

  /// String → inversor o inversor → tablero.
  TextColumn get kind => textEnum<RunKind>()();

  /// Nombre visible.
  TextColumn get name => text()();

  /// Longitud en un sentido (m).
  RealColumn get lengthM => real()();

  /// Material.
  TextColumn get material => textEnum<CableMaterial>().withDefault(
    Constant(CableMaterial.copper.name),
  )();

  /// Canalización.
  TextColumn get raceway => textEnum<RacewayKind>().withDefault(
    Constant(RacewayKind.rooftop13to90mm.name),
  )();

  /// Temperatura ambiente de diseño (°C).
  RealColumn get ambientC => real().withDefault(const Constant(40))();

  /// Conductores portadores de corriente en la canalización.
  IntColumn get conductors => integer().withDefault(const Constant(2))();

  /// Calibre elegido a mano (nulo = el mínimo calculado).
  TextColumn get chosenSize => text().nullable()();

  /// Calibre resultante.
  TextColumn get resultSize => text().nullable()();

  /// Caída de tensión resultante (%).
  RealColumn get dropPercent => real().nullable()();

  /// Orden.
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
