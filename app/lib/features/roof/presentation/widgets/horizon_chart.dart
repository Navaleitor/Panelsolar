import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:solar_engine/solar_engine.dart' show HorizonProfile;

/// Perfil de horizonte: azimut (0–360°, N–E–S–O–N) contra elevación.
class HorizonChart extends StatelessWidget {
  /// Crea la gráfica.
  const new({required this.profile, required this.far, super.key});

  /// Perfil combinado (o null si no hay datos).
  final HorizonProfile? profile;

  /// Obstáculos lejanos (puntos marcados).
  final List<FarObstacle> far;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return CustomPaint(
      painter: _HorizonPainter(
        profile: profile,
        far: far,
        line: scheme.primary,
        grid: scheme.outlineVariant,
        labels: [
          l10n.roofCardinalN,
          l10n.roofCardinalE,
          l10n.roofCardinalS,
          l10n.roofCardinalW,
          l10n.roofCardinalN,
        ],
        text: scheme.onSurface,
      ),
      size: Size.infinite,
    );
  }
}

class _HorizonPainter extends CustomPainter {
  new({
    required this.profile,
    required this.far,
    required this.line,
    required this.grid,
    required this.labels,
    required this.text,
  });

  final HorizonProfile? profile;
  final List<FarObstacle> far;
  final Color line;
  final Color grid;
  final List<String> labels;
  final Color text;

  @override
  void paint(Canvas canvas, Size size) {
    const bottom = 16.0;
    final h = size.height - bottom;
    var maxE = 30.0;
    for (var az = 0; az < 360; az += 2) {
      final e = profile?.elevationAt(az.toDouble()) ?? 0;
      if (e > maxE) maxE = e;
    }
    double x(double az) => az / 360 * size.width;
    double y(double e) => h - e / maxE * h;
    final g = Paint()..color = grid;
    for (var i = 0; i <= 4; i++) {
      canvas.drawLine(Offset(x(i * 90.0), 0), Offset(x(i * 90.0), h), g);
      final tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(color: text, fontSize: 11),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(
          (x(i * 90.0) - tp.width / 2).clamp(0, size.width - tp.width),
          h + 2,
        ),
      );
    }
    canvas.drawLine(Offset(0, h), Offset(size.width, h), g);
    if (profile != null) {
      final path = Path()..moveTo(0, h);
      for (var az = 0; az <= 360; az++) {
        path.lineTo(x(az.toDouble()), y(profile!.elevationAt(az.toDouble())));
      }
      path
        ..lineTo(size.width, h)
        ..close();
      canvas
        ..drawPath(path, Paint()..color = line.withValues(alpha: 0.3))
        ..drawPath(
          path,
          Paint()
            ..color = line
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        );
    }
    for (final f in far) {
      for (final p in f.points) {
        canvas.drawCircle(
          Offset(x(p.azimuth), y(p.elevation)),
          3,
          Paint()..color = Colors.green,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_HorizonPainter old) =>
      old.profile != profile || old.far != far;
}
