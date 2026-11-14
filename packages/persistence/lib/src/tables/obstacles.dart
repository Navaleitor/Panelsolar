import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Obstáculo del techo o de junto (B.7.1): huella en metros (coordenadas
/// locales) y altura sobre el techo.
///
/// Historial de esquema:
/// - v5: tabla nueva (F3).
@DataClassName('Obstacle')
class Obstacles extends Table with BaseColumns {
  /// Proyecto.
  TextColumn get projectId => text().references(Projects, #id)();

  /// Tipo (tinaco, antena...).
  TextColumn get kind => textEnum<ObstacleKind>()();

  /// Forma de la huella.
  TextColumn get outline => textEnum<ObstacleOutline>()();

  /// Centro, este (m). Círculo, rectángulo y punto.
  RealColumn get centerX => real().withDefault(const Constant(0))();

  /// Centro, norte (m).
  RealColumn get centerY => real().withDefault(const Constant(0))();

  /// Diámetro, ancho o espesor (m).
  RealColumn get widthM => real()();

  /// Fondo del rectángulo (m).
  RealColumn get depthM => real().nullable()();

  /// Giro del rectángulo (grados, antihorario).
  RealColumn get rotationDeg => real().withDefault(const Constant(0))();

  /// Puntos de la línea o del polígono en JSON `[[x,y],...]` (m).
  TextColumn get points => text().nullable()();

  /// Altura sobre el techo (m).
  RealColumn get heightM => real()();

  /// De dónde salió la altura.
  TextColumn get heightSource => textEnum<HeightSource>()();

  /// Capacidad del tinaco (L), si aplica.
  IntColumn get tankLiters => integer().nullable()();

  /// Nota opcional.
  TextColumn get label => text().nullable()();
}
