import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/app.dart';

/// Punto de entrada. Toda la inyección de dependencias pasa por Riverpod.
void main() {
  runApp(const ProviderScope(child: PanelsolarApp()));
}
