import 'package:geo_kit/geo_kit.dart';

/// Trazo en curso del editor, en píxeles del lienzo. Aplica el imán a
/// vértices existentes y a 90° (ficha 16).
class DrawingState {
  /// Puntos tocados (px).
  final List<Vec2> points = [];

  /// Último imán aplicado (para avisar en pantalla).
  SnapKind lastSnap = SnapKind.none;

  /// Imán activado.
  bool snapEnabled = true;

  /// Agrega un punto tocado en [px]. [vertices] son los vértices de los
  /// planos ya trazados; [zoom] ajusta el radio del imán a la pantalla.
  /// Devuelve `true` si el punto cerró el polígono (tocó el primero).
  bool add(Vec2 px, {List<Vec2> vertices = const [], double zoom = 1}) {
    final radius = 24 / zoom;
    if (points.length >= 3 && px.distanceTo(points.first) <= radius) {
      lastSnap = SnapKind.vertex;
      return true;
    }
    if (!snapEnabled) {
      points.add(px);
      lastSnap = SnapKind.none;
      return false;
    }
    final r = Snapping.snap(
      candidate: px,
      path: points,
      vertices: [...vertices, ...points],
      vertexRadius: radius,
    );
    points.add(r.point);
    lastSnap = r.kind;
    return false;
  }

  /// Quita el último punto.
  void undo() {
    if (points.isNotEmpty) points.removeLast();
    lastSnap = SnapKind.none;
  }

  /// Borra el trazo.
  void clear() {
    points.clear();
    lastSnap = SnapKind.none;
  }

  /// `true` si ya se puede cerrar (3 puntos y polígono simple).
  bool get canClose => points.length >= 3 && PolygonMetrics.isSimple(points);
}
