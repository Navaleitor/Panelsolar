import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/app.dart';
import 'package:panelsolar/core/database/database_providers.dart';

/// Arranca la app completa en una prueba, sin tocar SQLite real.
extension PumpApp on WidgetTester {
  Future<void> pumpPanelsolar({
    Locale locale = const Locale('es'),
    List<Override> overrides = const [],
  }) async {
    await pumpWidget(
      ProviderScope(
        overrides: [
          databaseHealthProvider.overrideWith((ref) async => 2),
          ...overrides,
        ],
        child: PanelsolarApp(locale: locale),
      ),
    );
    await pumpAndSettle();
  }
}
