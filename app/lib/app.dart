import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_router.dart';
import 'package:panelsolar/core/theme/app_theme.dart';

/// Widget raíz: tema claro/oscuro, idiomas y navegación.
class PanelsolarApp extends ConsumerWidget {
  const new({super.key, this.locale});

  /// Idioma forzado (solo pruebas). `null` = idioma del sistema.
  final Locale? locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
