import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';

/// Flecha que apunta al norte en la imagen ([angleDeg] horario desde
/// arriba).
class NorthArrow extends StatelessWidget {
  /// Crea la flecha.
  const new({required this.angleDeg, super.key});

  /// Ángulo del norte (grados).
  final double angleDeg;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Tooltip(
      message: l10n.roofNorthArrowTooltip,
      child: Card(
        shape: const CircleBorder(),
        child: SizedBox(
          width: 56,
          height: 56,
          child: Transform.rotate(
            key: const Key('north-arrow'),
            angle: angleDeg * math.pi / 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.navigation, color: Colors.red),
                Text(
                  l10n.roofNorthLetter,
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
