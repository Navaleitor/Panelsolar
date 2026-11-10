import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';

/// Pantalla de un módulo todavía vacío: título, descripción y la fase en la
/// que se implementará. Se reemplaza al construir cada módulo.
class EmptyModuleView extends StatelessWidget {
  const new({
    required this.title,
    required this.description,
    required this.icon,
    required this.phase,
    this.children = const [],
    super.key,
  });

  final String title;
  final String description;
  final IconData icon;

  /// Fase del plan maestro (p. ej. `F1`).
  final String phase;

  /// Contenido extra opcional bajo el aviso.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Icon(icon, size: 72, color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            description,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.comingInPhase(phase),
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          ...children,
        ],
      ),
    );
  }
}
