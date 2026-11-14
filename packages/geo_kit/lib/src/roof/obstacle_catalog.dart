import 'package:meta/meta.dart';

/// Forma con la que se dibuja la huella de un obstáculo.
enum ObstacleShape {
  /// Círculo (diámetro = ancho).
  circle,

  /// Rectángulo (ancho × fondo, girable).
  rectangle,

  /// Línea con espesor (muro, pretil).
  line,

  /// Punto (poste, antena) con diámetro pequeño.
  point,

  /// Polígono libre (edificio vecino).
  polygon,
}

/// Tipos de obstáculo de B.7.1. Los nombres se guardan en la base (no
/// renombrar).
enum ObstacleType {
  /// Tinaco (tanque de agua).
  waterTank,

  /// Antena o mástil.
  antenna,

  /// Pretil (murete del borde del techo).
  parapet,

  /// Tanque de gas estacionario.
  gasTank,

  /// Condensadora de minisplit.
  minisplit,

  /// Domo o tragaluz.
  dome,

  /// Cubo de escalera.
  stairwell,

  /// Árbol (copa circular).
  tree,

  /// Edificio vecino.
  neighborBuilding,
}

/// Valores típicos de un tipo de obstáculo (todo en metros). Son puntos de
/// partida editables, no datos de ninguna marca.
@immutable
class ObstaclePreset {
  /// Crea el valor típico.
  const new({
    required this.type,
    required this.shape,
    required this.widthM,
    required this.heightM,
    this.depthM,
  });

  /// Tipo.
  final ObstacleType type;

  /// Forma de la huella.
  final ObstacleShape shape;

  /// Ancho, diámetro (círculo) o espesor (línea), m.
  final double widthM;

  /// Fondo del rectángulo o largo de la línea, m.
  final double? depthM;

  /// Altura típica sobre el techo, m.
  final double heightM;
}

/// Tamaño comercial de tinaco: capacidad, diámetro y altura del cuerpo.
typedef WaterTankSize = ({int liters, double diameterM, double bodyHeightM});

/// Catálogo de obstáculos típicos (B.7.1).
abstract final class ObstacleCatalog {
  /// Altura típica de la base de un tinaco (m).
  static const double waterTankBaseM = 0.25;

  /// Tamaños comunes de tinaco (450 / 750 / 1100 / 2500 L). Medidas
  /// aproximadas de un tinaco vertical genérico.
  static const List<WaterTankSize> waterTankSizes = [
    (liters: 450, diameterM: 0.84, bodyHeightM: 1.03),
    (liters: 750, diameterM: 0.98, bodyHeightM: 1.24),
    (liters: 1100, diameterM: 1.10, bodyHeightM: 1.45),
    (liters: 2500, diameterM: 1.55, bodyHeightM: 1.75),
  ];

  /// Altura total típica de un tinaco de [liters] litros con base.
  static double waterTankHeight(int liters) =>
      waterTankSize(liters).bodyHeightM + waterTankBaseM;

  /// Tamaño de tinaco más cercano a [liters].
  static WaterTankSize waterTankSize(int liters) {
    var best = waterTankSizes.first;
    for (final s in waterTankSizes) {
      if ((s.liters - liters).abs() < (best.liters - liters).abs()) best = s;
    }
    return best;
  }

  /// Valores típicos por tipo.
  static const Map<ObstacleType, ObstaclePreset> presets = {
    ObstacleType.waterTank: ObstaclePreset(
      type: ObstacleType.waterTank,
      shape: ObstacleShape.circle,
      widthM: 1.10,
      heightM: 1.70,
    ),
    ObstacleType.antenna: ObstaclePreset(
      type: ObstacleType.antenna,
      shape: ObstacleShape.point,
      widthM: 0.10,
      heightM: 3,
    ),
    ObstacleType.parapet: ObstaclePreset(
      type: ObstacleType.parapet,
      shape: ObstacleShape.line,
      widthM: 0.15,
      depthM: 5,
      heightM: 0.90,
    ),
    ObstacleType.gasTank: ObstaclePreset(
      type: ObstacleType.gasTank,
      shape: ObstacleShape.rectangle,
      widthM: 1.40,
      depthM: 0.70,
      heightM: 0.90,
    ),
    ObstacleType.minisplit: ObstaclePreset(
      type: ObstacleType.minisplit,
      shape: ObstacleShape.rectangle,
      widthM: 0.80,
      depthM: 0.30,
      heightM: 0.60,
    ),
    ObstacleType.dome: ObstaclePreset(
      type: ObstacleType.dome,
      shape: ObstacleShape.rectangle,
      widthM: 1,
      depthM: 1,
      heightM: 0.30,
    ),
    ObstacleType.stairwell: ObstaclePreset(
      type: ObstacleType.stairwell,
      shape: ObstacleShape.rectangle,
      widthM: 2.50,
      depthM: 3,
      heightM: 2.40,
    ),
    ObstacleType.tree: ObstaclePreset(
      type: ObstacleType.tree,
      shape: ObstacleShape.circle,
      widthM: 4,
      heightM: 6,
    ),
    ObstacleType.neighborBuilding: ObstaclePreset(
      type: ObstacleType.neighborBuilding,
      shape: ObstacleShape.rectangle,
      widthM: 8,
      depthM: 10,
      heightM: 3,
    ),
  };
}
