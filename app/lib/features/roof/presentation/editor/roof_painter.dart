import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:panelsolar/features/roof/domain/roof_space.dart';
import 'package:panelsolar/features/roof/presentation/roof_format.dart';
import 'package:solar_engine/solar_engine.dart' show ShadeHeatmap;

/// Capas que dibuja [RoofPainter] (todo opcional).
class RoofLayers {
  /// Crea las capas.
  const new({
    this.planes = const [],
    this.obstacles = const [],
    this.selectedPlaneId,
    this.selectedObstacleId,
    this.grabbedVertex,
    this.drawingPx = const [],
    this.linesPx = const [],
    this.shadows = const [],
    this.heatmaps = const [],
  });

  /// Planos (m).
  final List<RoofPlaneModel> planes;

  /// Obstáculos (m).
  final List<ObstacleModel> obstacles;

  /// Plano elegido.
  final String? selectedPlaneId;

  /// Obstáculo elegido.
  final String? selectedObstacleId;

  /// Vértice tomado para mover (índice en el plano elegido).
  final int? grabbedVertex;

  /// Trazo en curso (px) con medidas en vivo.
  final List<Vec2> drawingPx;

  /// Líneas de calibración/verificación/referencia (px) con color.
  final List<(List<Vec2>, Color)> linesPx;

  /// Sombras (m).
  final List<List<Vec2>> shadows;

  /// Mapas de calor (m).
  final List<ShadeHeatmap> heatmaps;
}

/// Dibuja el techo sobre el lienzo (en píxeles). Los grosores y textos se
/// dividen entre el zoom para verse igual a cualquier acercamiento.
class RoofPainter extends CustomPainter {
  /// Crea el pintor.
  new({
    required this.space,
    required this.layers,
    required this.zoom,
    required this.locale,
  });

  /// Lienzo y marco.
  final RoofSpace space;

  /// Qué dibujar.
  final RoofLayers layers;

  /// Zoom actual.
  final double zoom;

  /// Idioma para los números.
  final String locale;

  double get _px => 1 / zoom;

  Offset _o(Vec2 v) => Offset(v.x, v.y);

  Offset? _toPx(Vec2 local) {
    final f = space.frame;
    return f == null ? null : _o(f.toPixel(local));
  }

  Path? _path(List<Vec2> local) {
    if (local.length < 2 || space.frame == null) return null;
    final p = Path()..moveTo(_toPx(local.first)!.dx, _toPx(local.first)!.dy);
    for (final v in local.skip(1)) {
      final o = _toPx(v)!;
      p.lineTo(o.dx, o.dy);
    }
    return p..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (space.imagePath == null && space.frame != null) _grid(canvas, size);
    for (final m in layers.heatmaps) {
      _heatmap(canvas, m);
    }
    for (final s in layers.shadows) {
      final p = _path(s);
      if (p != null) {
        canvas.drawPath(
          p,
          Paint()..color = Colors.black.withValues(alpha: 0.45),
        );
      }
    }
    for (final plane in layers.planes) {
      _plane(canvas, plane, selected: plane.id == layers.selectedPlaneId);
    }
    for (final o in layers.obstacles) {
      final p = _path(o.footprint);
      if (p == null) continue;
      final sel = o.id == layers.selectedObstacleId;
      canvas
        ..drawPath(p, Paint()..color = Colors.orange.withValues(alpha: 0.55))
        ..drawPath(
          p,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = (sel ? 4 : 2) * _px
            ..color = sel ? Colors.red : Colors.deepOrange,
        );
    }
    for (final (pts, color) in layers.linesPx) {
      _line(canvas, pts, color);
    }
    _drawing(canvas);
  }

  void _grid(Canvas canvas, Size size) {
    final f = space.frame!;
    final step = 1 / f.metersPerPixel; // 1 m
    final paint = Paint()
      ..color = Colors.blueGrey.withValues(alpha: 0.15)
      ..strokeWidth = _px;
    for (var x = f.origin.x % step; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = f.origin.y % step; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  void _plane(Canvas canvas, RoofPlaneModel plane, {required bool selected}) {
    final p = _path(plane.polygon);
    if (p == null) return;
    canvas
      ..drawPath(p, Paint()..color = Colors.lightBlue.withValues(alpha: 0.25))
      ..drawPath(
        p,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = (selected ? 4 : 2.5) * _px
          ..color = selected ? Colors.indigo : Colors.blue,
      );
    for (final w in plane.walkways) {
      final wp = _path(w.polygon);
      if (wp != null) {
        canvas.drawPath(
          wp,
          Paint()..color = Colors.green.withValues(alpha: 0.4),
        );
      }
    }
    if (plane.edgeSetbackM > 0) {
      final inner = PolygonOps.inset(plane.polygon, plane.edgeSetbackM);
      final ip = inner == null ? null : _path(inner);
      if (ip != null) {
        canvas.drawPath(
          ip,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5 * _px
            ..color = Colors.green.shade800,
        );
      }
    }
    final pts = plane.polygon;
    final sides = PolygonMetrics.sideLengths(pts);
    for (var i = 0; i < pts.length; i++) {
      final mid = (pts[i] + pts[(i + 1) % pts.length]) * 0.5;
      _label(canvas, _toPx(mid)!, RoofFormat.meters(sides[i], locale));
    }
    if (plane.azimuthEdgeIndex case final e?) {
      final a = _toPx(pts[e % pts.length])!;
      final b = _toPx(pts[(e + 1) % pts.length])!;
      canvas.drawLine(
        a,
        b,
        Paint()
          ..strokeWidth = 5 * _px
          ..color = Colors.purple.withValues(alpha: 0.7),
      );
    }
    final c = _toPx(PolygonMetrics.centroid(pts))!;
    _label(
      canvas,
      c,
      '${plane.name}\n${RoofFormat.area(PolygonMetrics.area(pts), locale)}',
      background: Colors.indigo.withValues(alpha: 0.8),
    );
    if (selected) {
      for (final (i, v) in pts.indexed) {
        canvas.drawCircle(
          _toPx(v)!,
          (i == layers.grabbedVertex ? 10 : 6) * _px,
          Paint()
            ..color = i == layers.grabbedVertex ? Colors.red : Colors.indigo,
        );
      }
    }
  }

  void _drawing(Canvas canvas) {
    final pts = layers.drawingPx;
    if (pts.isEmpty) return;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3 * _px
      ..color = Colors.red;
    for (var i = 0; i + 1 < pts.length; i++) {
      canvas.drawLine(_o(pts[i]), _o(pts[i + 1]), paint);
    }
    for (final v in pts) {
      canvas.drawCircle(_o(v), 6 * _px, Paint()..color = Colors.red);
    }
    final f = space.frame;
    if (f == null) return;
    final local = pts.map(f.toLocal).toList();
    for (var i = 0; i + 1 < pts.length; i++) {
      _label(
        canvas,
        _o((pts[i] + pts[i + 1]) * 0.5),
        RoofFormat.meters(local[i].distanceTo(local[i + 1]), locale),
        background: Colors.red.withValues(alpha: 0.85),
      );
    }
    if (pts.length >= 3) {
      final angles = PolygonMetrics.interiorAngles(local);
      for (var i = 1; i < pts.length - 1; i++) {
        _label(
          canvas,
          _o(pts[i]) + Offset(0, -22 * _px),
          RoofFormat.degrees(angles[i], locale),
        );
      }
    }
  }

  void _line(Canvas canvas, List<Vec2> pts, Color color) {
    final paint = Paint()
      ..strokeWidth = 3 * _px
      ..color = color;
    for (final v in pts) {
      canvas.drawCircle(_o(v), 7 * _px, paint);
    }
    if (pts.length == 2) canvas.drawLine(_o(pts[0]), _o(pts[1]), paint);
  }

  void _heatmap(Canvas canvas, ShadeHeatmap m) {
    final f = space.frame;
    if (f == null) return;
    for (var r = 0; r < m.rows; r++) {
      for (var c = 0; c < m.columns; c++) {
        final v = m.at(c, r);
        if (v.isNaN) continue;
        final ctr = m.cellCenter(c, r);
        final h = m.cellSize / 2;
        final path = _path([
          Vec2(ctr.x - h, ctr.y - h),
          Vec2(ctr.x + h, ctr.y - h),
          Vec2(ctr.x + h, ctr.y + h),
          Vec2(ctr.x - h, ctr.y + h),
        ]);
        if (path != null) {
          canvas.drawPath(path, Paint()..color = heatColor(v));
        }
      }
    }
  }

  /// Color del mapa de calor: verde (0 %) → amarillo → rojo (≥ 30 %).
  static Color heatColor(double loss) {
    final t = math.min(1, loss / 0.3).toDouble();
    final c = t < 0.5
        ? Color.lerp(Colors.green, Colors.yellow, t * 2)!
        : Color.lerp(Colors.yellow, Colors.red, (t - 0.5) * 2)!;
    return c.withValues(alpha: 0.6);
  }

  void _label(Canvas canvas, Offset at, String text, {Color? background}) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: Colors.white, fontSize: 12 * _px),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    final rect = Rect.fromCenter(
      center: at,
      width: tp.width + 8 * _px,
      height: tp.height + 4 * _px,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(4 * _px)),
      Paint()..color = background ?? Colors.black.withValues(alpha: 0.7),
    );
    tp.paint(canvas, rect.topLeft + Offset(4 * _px, 2 * _px));
  }

  @override
  bool shouldRepaint(RoofPainter old) =>
      old.zoom != zoom || old.layers != layers || old.space != space;
}
