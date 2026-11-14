import 'package:flutter/foundation.dart' show immutable;
import 'package:geo_kit/geo_kit.dart';
import 'package:persistence/persistence.dart';

/// Pasillo de mantenimiento: franja de [widthM] centrada en [start]–[end]
/// (metros locales).
@immutable
class Walkway {
  /// Crea el pasillo.
  const new(this.start, this.end, this.widthM);

  /// Extremo inicial (m).
  final Vec2 start;

  /// Extremo final (m).
  final Vec2 end;

  /// Ancho (m).
  final double widthM;

  /// Polígono de la franja.
  List<Vec2> get polygon => PolygonOps.strip(start, end, widthM);
}

/// Plano (agua) del techo en metros locales (x = este, y = norte).
@immutable
class RoofPlaneModel {
  /// Crea el plano.
  const new({
    required this.id,
    required this.name,
    required this.polygon,
    this.tiltDeg = 0,
    this.tiltSource = TiltSource.manual,
    this.azimuthDeg = 180,
    this.azimuthEdgeIndex,
    this.edgeSetbackM = 0,
    this.walkways = const [],
  });

  /// Identificador (UUID de la base).
  final String id;

  /// Nombre visible.
  final String name;

  /// Vértices (m).
  final List<Vec2> polygon;

  /// Inclinación (grados).
  final double tiltDeg;

  /// De dónde salió la inclinación.
  final TiltSource tiltSource;

  /// Azimut de bajada (grados, 180 = sur).
  final double azimuthDeg;

  /// Arista del alero elegida para el azimut.
  final int? azimuthEdgeIndex;

  /// Retiro de borde (m).
  final double edgeSetbackM;

  /// Pasillos.
  final List<Walkway> walkways;

  /// Copia con cambios. [azimuthEdgeIndex] acepta `null` para borrarla;
  /// si no se pasa, se conserva.
  RoofPlaneModel copyWith({
    String? name,
    List<Vec2>? polygon,
    double? tiltDeg,
    TiltSource? tiltSource,
    double? azimuthDeg,
    Object? azimuthEdgeIndex = _keep,
    double? edgeSetbackM,
    List<Walkway>? walkways,
  }) => RoofPlaneModel(
    id: id,
    name: name ?? this.name,
    polygon: polygon ?? this.polygon,
    tiltDeg: tiltDeg ?? this.tiltDeg,
    tiltSource: tiltSource ?? this.tiltSource,
    azimuthDeg: azimuthDeg ?? this.azimuthDeg,
    azimuthEdgeIndex: identical(azimuthEdgeIndex, _keep)
        ? this.azimuthEdgeIndex
        : azimuthEdgeIndex as int?,
    edgeSetbackM: edgeSetbackM ?? this.edgeSetbackM,
    walkways: walkways ?? this.walkways,
  );
}

const Object _keep = Object();

/// Obstáculo en metros locales.
@immutable
class ObstacleModel {
  /// Crea el obstáculo.
  const new({
    required this.id,
    required this.type,
    required this.shape,
    required this.widthM,
    required this.heightM,
    required this.heightSource,
    this.center = Vec2.zero,
    this.depthM,
    this.rotationDeg = 0,
    this.points = const [],
    this.tankLiters,
  });

  /// Identificador.
  final String id;

  /// Tipo (B.7.1).
  final ObstacleType type;

  /// Forma de la huella.
  final ObstacleShape shape;

  /// Centro (m).
  final Vec2 center;

  /// Diámetro, ancho o espesor (m).
  final double widthM;

  /// Fondo del rectángulo (m).
  final double? depthM;

  /// Giro (grados, antihorario desde el este).
  final double rotationDeg;

  /// Extremos de la línea o vértices del polígono (m).
  final List<Vec2> points;

  /// Altura sobre el techo (m).
  final double heightM;

  /// De dónde salió la altura.
  final HeightSource heightSource;

  /// Capacidad del tinaco (L).
  final int? tankLiters;

  /// Copia con cambios.
  ObstacleModel copyWith({
    ObstacleType? type,
    ObstacleShape? shape,
    Vec2? center,
    double? widthM,
    Object? depthM = _keep,
    double? rotationDeg,
    List<Vec2>? points,
    double? heightM,
    HeightSource? heightSource,
    Object? tankLiters = _keep,
  }) => ObstacleModel(
    id: id,
    type: type ?? this.type,
    shape: shape ?? this.shape,
    center: center ?? this.center,
    widthM: widthM ?? this.widthM,
    depthM: identical(depthM, _keep) ? this.depthM : depthM as double?,
    rotationDeg: rotationDeg ?? this.rotationDeg,
    points: points ?? this.points,
    heightM: heightM ?? this.heightM,
    heightSource: heightSource ?? this.heightSource,
    tankLiters: identical(tankLiters, _keep)
        ? this.tankLiters
        : tankLiters as int?,
  );

  /// Huella (polígono en m).
  List<Vec2> get footprint => ObstacleFootprint.build(
    shape: shape,
    center: center,
    widthM: widthM,
    depthM: depthM,
    rotationDeg: rotationDeg,
    points: points,
  );
}

/// Punto de un perfil de horizonte (grados).
typedef HorizonPoint = ({double azimuth, double elevation});

/// Obstáculo lejano (árbol, edificio) medido con brújula e inclinómetro.
@immutable
class FarObstacle {
  /// Crea el obstáculo lejano.
  const new({required this.id, required this.name, required this.points});

  /// Identificador.
  final String id;

  /// Nombre visible.
  final String name;

  /// Borde superior de izquierda a derecha.
  final List<HorizonPoint> points;
}
