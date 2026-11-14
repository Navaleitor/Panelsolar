import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/roof/domain/roof_space.dart';

/// Lienzo con zoom y arrastre (dos dedos o un dedo para mover). Muestra la
/// imagen del techo (o la cuadrícula del croquis) y encima lo que dibuje
/// [painterBuilder].
/// Los toques llegan en píxeles del lienzo.
class RoofCanvas extends StatefulWidget {
  /// Crea el lienzo.
  const new({
    required this.space,
    required this.painterBuilder,
    this.imageFile,
    this.onTapPx,
    this.controller,
    super.key,
  });

  /// Tamaño y marco.
  final RoofSpace space;

  /// Archivo de la imagen (null en croquis).
  final File? imageFile;

  /// Dibujo encima; recibe el zoom actual para grosores constantes.
  final CustomPainter Function(double zoom) painterBuilder;

  /// Toque en píxeles del lienzo.
  final void Function(Vec2 px, double zoom)? onTapPx;

  /// Controlador de zoom (opcional).
  final TransformationController? controller;

  @override
  State<RoofCanvas> createState() => _RoofCanvasState();
}

class _RoofCanvasState extends State<RoofCanvas> {
  late final TransformationController _controller =
      widget.controller ?? TransformationController();
  Size? _fittedFor;

  double get _zoom => _controller.value.getMaxScaleOnAxis();

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _fit(Size viewport) {
    if (_fittedFor == viewport) return;
    _fittedFor = viewport;
    final s = [
      viewport.width / widget.space.widthPx,
      viewport.height / widget.space.heightPx,
    ].reduce((a, b) => a < b ? a : b);
    final dx = (viewport.width - widget.space.widthPx * s) / 2;
    final dy = (viewport.height - widget.space.heightPx * s) / 2;
    _controller.value = Matrix4.identity()
      ..translateByDouble(dx, dy, 0, 1)
      ..scaleByDouble(s, s, 1, 1);
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.space.widthPx;
    final h = widget.space.heightPx;
    return LayoutBuilder(
      builder: (context, constraints) {
        _fit(constraints.biggest);
        return ColoredBox(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: InteractiveViewer(
            transformationController: _controller,
            constrained: false,
            minScale: 0.02,
            maxScale: 20,
            boundaryMargin: EdgeInsets.all(w > h ? w : h),
            child: GestureDetector(
              key: const Key('roof-canvas-content'),
              behavior: HitTestBehavior.opaque,
              onTapUp: widget.onTapPx == null
                  ? null
                  : (d) => widget.onTapPx!(
                      Vec2(d.localPosition.dx, d.localPosition.dy),
                      _zoom,
                    ),
              child: SizedBox(
                width: w,
                height: h,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (widget.imageFile case final f?)
                      Image.file(f, fit: BoxFit.fill, gaplessPlayback: true)
                    else
                      const ColoredBox(color: Colors.white),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, _) =>
                          CustomPaint(painter: widget.painterBuilder(_zoom)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
