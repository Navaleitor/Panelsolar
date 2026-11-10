import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/projects/presentation/widgets/project_status_label.dart';
import 'package:persistence/persistence.dart';

/// Etiqueta de color con el estado del proyecto.
class ProjectStatusChip extends StatelessWidget {
  const new({required this.status, super.key});

  final ProjectStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (bg, fg) = switch (status) {
      ProjectStatus.prospect => (
        scheme.surfaceContainerHighest,
        scheme.onSurface,
      ),
      ProjectStatus.design => (
        scheme.secondaryContainer,
        scheme.onSecondaryContainer,
      ),
      ProjectStatus.quoted => (
        scheme.tertiaryContainer,
        scheme.onTertiaryContainer,
      ),
      ProjectStatus.installed => (
        scheme.primaryContainer,
        scheme.onPrimaryContainer,
      ),
      ProjectStatus.maintenance => (scheme.primary, scheme.onPrimary),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        projectStatusLabel(AppLocalizations.of(context), status),
        style: TextStyle(color: fg, fontWeight: FontWeight.w600),
      ),
    );
  }
}
