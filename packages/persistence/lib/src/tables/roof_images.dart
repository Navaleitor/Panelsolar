import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Base del techo de un proyecto (uno por proyecto): la imagen importada
/// por el usuario y su calibración, o el modo croquis sin imagen
/// (ADR-005). Nunca guarda imágenes de proveedores.
///
/// Historial de esquema:
/// - v5: tabla nueva (F3).
@DataClassName('RoofImage')
class RoofImages extends Table with BaseColumns {
  /// Proyecto al que pertenece (único).
  TextColumn get projectId => text().unique().references(Projects, #id)();

  /// Imagen calibrada o croquis con cinta.
  TextColumn get mode => textEnum<RoofMode>()();

  /// Ruta relativa de la imagen (vacía en modo croquis).
  TextColumn get filePath => text().nullable()();

  /// SHA-256 de la imagen guardada.
  TextColumn get sha256 => text().nullable()();

  /// Ancho de la imagen en píxeles.
  IntColumn get widthPx => integer().nullable()();

  /// Alto de la imagen en píxeles.
  IntColumn get heightPx => integer().nullable()();

  /// Escala: metros por píxel (vacía hasta calibrar).
  RealColumn get metersPerPixel => real().nullable()();

  /// Línea de calibración en JSON `{"a":[x,y],"b":[x,y],"m":metros}`
  /// (píxeles de la imagen).
  TextColumn get calibrationLine => text().nullable()();

  /// Segunda línea opcional para verificar la escala (mismo formato).
  TextColumn get verificationLine => text().nullable()();

  /// Ángulo del norte en la imagen (grados, horario desde arriba).
  RealColumn get northAngleDeg => real().withDefault(const Constant(0))();

  /// De dónde salió el norte.
  TextColumn get northSource =>
      textEnum<NorthSource>().withDefault(Constant(NorthSource.imageUp.name))();

  /// Declinación magnética usada al confirmar con brújula (grados, WMM).
  RealColumn get magneticDeclinationDeg => real().nullable()();
}
