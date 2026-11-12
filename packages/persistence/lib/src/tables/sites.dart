import 'package:drift/drift.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/tables/base_columns.dart';
import 'package:persistence/src/tables/projects.dart';

/// Ubicación del sitio de un proyecto (uno por proyecto). Solo coordenadas:
/// la app no muestra mapa ni imagen de proveedores (ADR-005).
///
/// Historial de esquema:
/// - v3: tabla nueva (F1).
@DataClassName('Site')
class Sites extends Table with BaseColumns {
  /// Proyecto al que pertenece (único).
  TextColumn get projectId => text().unique().references(Projects, #id)();

  /// Latitud WGS84 en grados decimales (−90 a 90).
  RealColumn get latitude => real()();

  /// Longitud WGS84 en grados decimales (−180 a 180).
  RealColumn get longitude => real()();

  /// Altitud sobre el nivel del mar, en metros (si se conoce).
  RealColumn get altitudeM => real().nullable()();

  /// Zona horaria IANA (p. ej. `America/Monterrey`).
  TextColumn get timeZone => text().nullable()();

  /// Cómo se obtuvo la ubicación.
  TextColumn get source => textEnum<LocationSource>()();

  /// Texto de origen: la dirección buscada o el enlace pegado.
  TextColumn get sourceText => text().nullable()();

  /// Precisión horizontal del GPS en metros (solo origen GPS).
  RealColumn get accuracyM => real().nullable()();
}
