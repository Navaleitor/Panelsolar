import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/app.dart';
import 'package:panelsolar/core/database/database_providers.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/features/site/data/site_data_providers.dart';
import 'package:persistence/persistence.dart';

import 'fakes.dart';

/// Base SQLite en memoria para pruebas (cierra sus *streams* al instante
/// para no dejar temporizadores pendientes).
AppDatabase newTestDatabase() => AppDatabase(
  DatabaseConnection(NativeDatabase.memory(), closeStreamsSynchronously: true),
);

/// Dependencias falsas de una prueba de la app completa.
class TestEnv {
  new({AppDatabase? db})
    : db = db ?? newTestDatabase(),
      storageDir = Directory.systemTemp.createTempSync('panelsolar_test');

  final AppDatabase db;
  final Directory storageDir;
  final location = FakeLocationService();
  final geocoder = FakeGeocoder();
  final timeZones = FakeTimeZoneService();

  /// Redirecciones falsas para enlaces cortos (`corto → completo`).
  final redirects = <String, String>{};

  List<Override> get overrides => [
    appDatabaseProvider.overrideWithValue(db),
    appStorageProvider.overrideWithValue(AppStorage(storageDir)),
    locationServiceProvider.overrideWithValue(location),
    geocoderProvider.overrideWithValue(geocoder),
    timeZoneServiceProvider.overrideWithValue(timeZones),
    mapLinkResolverProvider.overrideWithValue(
      MapLinkResolver((uri) async {
        final target = redirects[uri.toString()];
        return target == null ? null : Uri.parse(target);
      }),
    ),
  ];

  Future<void> dispose() async {
    await db.close();
    if (storageDir.existsSync()) storageDir.deleteSync(recursive: true);
  }
}

/// Arranca la app completa en una prueba, con base en memoria.
extension PumpApp on WidgetTester {
  Future<TestEnv> pumpPanelsolar({
    Locale locale = const Locale('es'),
    TestEnv? env,
    List<Override> extraOverrides = const [],
  }) async {
    final testEnv = env ?? TestEnv();
    addTearDown(() => runAsync(testEnv.dispose));
    // Pantalla de teléfono alto para que quepan las fichas sin desplazar.
    view.physicalSize = const Size(1080, 2400);
    view.devicePixelRatio = 2.5;
    addTearDown(view.reset);
    await pumpWidget(
      ProviderScope(
        overrides: [...testEnv.overrides, ...extraOverrides],
        child: PanelsolarApp(locale: locale),
      ),
    );
    await pumpAndSettle();
    return testEnv;
  }

  /// Toca el widget con [key] (desplazando si hace falta) y espera.
  Future<void> tapKey(String key) async {
    final finder = find.byKey(Key(key));
    await ensureVisible(finder);
    await pumpAndSettle();
    await tap(finder);
    await pumpAndSettle();
  }

  /// Botón "atrás" del sistema.
  Future<void> systemBack() async {
    await binding.handlePopRoute();
    await pumpAndSettle();
  }

  /// Escribe [text] en el campo con [key].
  Future<void> enterKey(String key, String text) async {
    final finder = find.byKey(Key(key));
    await ensureVisible(finder);
    await enterText(finder, text);
    await pump();
  }
}
