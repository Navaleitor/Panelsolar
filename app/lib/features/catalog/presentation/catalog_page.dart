import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/empty_module_view.dart';

/// Pantalla principal del módulo Catálogo (vacía hasta la fase F4).
class CatalogPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return EmptyModuleView(
      title: l10n.navCatalog,
      description: l10n.catalogDescription,
      icon: Icons.inventory_2,
      phase: 'F4',
    );
  }
}
