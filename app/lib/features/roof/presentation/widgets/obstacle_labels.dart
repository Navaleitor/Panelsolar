import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';

/// Nombre visible de cada tipo de obstáculo.
String obstacleTypeLabel(AppLocalizations l10n, ObstacleType t) => switch (t) {
  ObstacleType.waterTank => l10n.obstacleWaterTank,
  ObstacleType.antenna => l10n.obstacleAntenna,
  ObstacleType.parapet => l10n.obstacleParapet,
  ObstacleType.gasTank => l10n.obstacleGasTank,
  ObstacleType.minisplit => l10n.obstacleMinisplit,
  ObstacleType.dome => l10n.obstacleDome,
  ObstacleType.stairwell => l10n.obstacleStairwell,
  ObstacleType.tree => l10n.obstacleTree,
  ObstacleType.neighborBuilding => l10n.obstacleNeighborBuilding,
};
