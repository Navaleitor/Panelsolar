import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/app.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:path_provider/path_provider.dart';

/// Punto de entrada. Toda la inyección de dependencias pasa por Riverpod.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documents = await getApplicationDocumentsDirectory();
  runApp(
    ProviderScope(
      overrides: [appStorageProvider.overrideWithValue(AppStorage(documents))],
      child: const PanelsolarApp(),
    ),
  );
}
