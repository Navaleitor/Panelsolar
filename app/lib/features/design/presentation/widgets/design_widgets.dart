import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';

/// Aviso fijo: "indicativo, requiere revisión de un profesional".
class DesignDisclaimer extends StatelessWidget {
  /// Crea el aviso.
  const new({this.structural = false, super.key});

  /// `true` = revisión estructural (viento).
  final bool structural;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.tertiaryContainer,
      margin: const EdgeInsets.all(16),
      child: ListTile(
        leading: Icon(Icons.gpp_maybe, color: scheme.onTertiaryContainer),
        title: Text(
          structural ? l10n.designDisclaimerStructural : l10n.designDisclaimer,
          style: TextStyle(color: scheme.onTertiaryContainer),
        ),
      ),
    );
  }
}

/// Fila "etiqueta … valor".
class ValueRow extends StatelessWidget {
  /// Crea la fila.
  const new(this.label, this.value, {this.color, this.valueKey, super.key});

  /// Etiqueta.
  final String label;

  /// Valor.
  final String value;

  /// Color del valor (rojo si no cumple).
  final Color? color;

  /// Llave del texto del valor (pruebas).
  final Key? valueKey;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Row(
      children: [
        Expanded(child: Text(label)),
        Text(
          value,
          key: valueKey,
          style: TextStyle(fontWeight: FontWeight.w600, color: color),
        ),
      ],
    ),
  );
}

/// Mensaje centrado cuando falta un paso previo.
class MissingStep extends StatelessWidget {
  /// Crea el mensaje.
  const new(this.message, {super.key});

  /// Texto.
  final String message;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Text(message, textAlign: TextAlign.center),
    ),
  );
}

/// Color por pérdida de sombra (B.7.1): verde < 3 %, amarillo hasta el
/// umbral, rojo desde el umbral.
Color shadeColor(double lossPct, double thresholdPct) {
  if (lossPct >= thresholdPct) return Colors.red;
  if (lossPct >= 3) return Colors.amber;
  return Colors.green;
}
