import 'package:panelsolar/features/design/domain/design_models.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:persistence/persistence.dart' show LayoutOrientation, MountType;
import 'package:solar_engine/solar_engine.dart';

/// Datos del panel que necesita el análisis.
typedef PanelSpec = ({
  double pmaxW,
  double gammaPct,
  double lengthM,
  double widthM,
});

/// Datos del inversor que necesita el análisis. `independent` = micro o con
/// optimizadores (cada panel trabaja solo).
typedef InverterSpec = ({
  double pacW,
  double efficiencyPct,
  int count,
  bool independent,
});

/// Paneles de un plano con su montaje.
typedef PlaneArray = ({
  String planeId,
  List<DesignPanel> panels,
  LayoutOrientation orientation,
  MountType mount,
  double rackTiltDeg,
  double rackAzimuthDeg,
});

/// Ubicación para el análisis.
typedef DesignSite = ({
  double latitude,
  double longitude,
  double? elevation,
  String? timeZone,
  double? utcOffsetHours,
});

/// Datos que necesita el análisis del diseño (se manda a un isolate).
class DesignJobInput {
  /// Crea la entrada.
  const new({
    required this.projectId,
    required this.site,
    required this.planes,
    required this.obstacles,
    required this.terrain,
    required this.far,
    required this.arrays,
    required this.panel,
    required this.inverter,
    required this.strings,
    required this.losses,
    this.thresholdPct = 10,
    this.years = 25,
    this.forceRefresh = false,
    this.dayStep = 7,
    this.minuteStep = 30,
  });

  /// Proyecto (para la caché de clima).
  final String projectId;

  /// Ubicación.
  final DesignSite site;

  /// Planos del techo (F3).
  final List<RoofPlaneModel> planes;

  /// Obstáculos (F3).
  final List<ObstacleModel> obstacles;

  /// Horizonte del terreno (F3).
  final List<HorizonPoint> terrain;

  /// Obstáculos lejanos (F3).
  final List<FarObstacle> far;

  /// Paneles por plano.
  final List<PlaneArray> arrays;

  /// Panel.
  final PanelSpec panel;

  /// Inversor (nulo = aún no se elige: solo sombras y temperaturas).
  final InverterSpec? inverter;

  /// Grupos de strings (serie × paralelo) en orden.
  final List<({int series, int parallel})> strings;

  /// Pérdidas editables.
  final SystemLosses losses;

  /// Umbral de sombra que excluye paneles (%).
  final double thresholdPct;

  /// Años de vida útil.
  final int years;

  /// Volver a descargar el clima.
  final bool forceRefresh;

  /// Muestreo del Sol (días).
  final int dayStep;

  /// Muestreo del Sol (minutos).
  final int minuteStep;
}

/// Sombra de los paneles de un plano.
typedef PlaneShadeResult = ({
  String planeId,

  /// Un resultado por panel (nulo si el panel está apagado).
  List<PanelShadeResult?> panels,

  /// `true` por panel si cuenta en la producción (encendido y bajo el
  /// umbral).
  List<bool> active,

  /// Pérdida del plano con el efecto eléctrico (0–1).
  double loss,
});

/// Resultado del análisis.
class DesignJobResult {
  /// Crea el resultado.
  const new({
    required this.temperatures,
    required this.planes,
    required this.production,
    required this.weatherLabel,
    required this.diffuseShare,
  });

  /// Temperaturas de diseño (las más extremas de NASA y PVGIS).
  final SiteDesignTemperatures temperatures;

  /// Sombra por plano.
  final List<PlaneShadeResult> planes;

  /// Producción (nula si no hay inversor o paneles).
  final DesignProduction? production;

  /// Fuente del clima.
  final String weatherLabel;

  /// Parte difusa usada (0–1).
  final double diffuseShare;

  /// Paneles que cuentan.
  int get activePanels =>
      planes.fold(0, (s, p) => s + p.active.where((a) => a).length);

  /// Resultado de sombra de un panel.
  PanelShadeResult? panel(String planeId, int index) {
    for (final p in planes) {
      if (p.planeId == planeId && index < p.panels.length) {
        return p.panels[index];
      }
    }
    return null;
  }
}
