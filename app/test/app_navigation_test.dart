import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/pump_app.dart';

void main() {
  testWidgets('arranca en Clientes', (tester) async {
    await tester.pumpPanelsolar();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Clientes'), findsOneWidget);
    expect(find.text('Disponible en la fase F1.'), findsOneWidget);
  });

  testWidgets('cada pestaña abre su pantalla', (tester) async {
    await tester.pumpPanelsolar();

    const tabs = {
      'Proyectos': 'F1',
      'Catálogo': 'F4',
      'Mantenimiento': 'F6',
      'Ajustes': 'F1',
      'Clientes': 'F1',
    };
    for (final MapEntry(key: tab, value: phase) in tabs.entries) {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(tab),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, tab), findsOneWidget);
      expect(find.text('Disponible en la fase $phase.'), findsOneWidget);
    }
  });

  testWidgets('Ajustes muestra la base de datos funcionando', (tester) async {
    await tester.pumpPanelsolar();
    await tester.tap(find.text('Ajustes'));
    await tester.pumpAndSettle();

    expect(find.text('Funcionando · esquema v2'), findsOneWidget);
  });

  testWidgets('en inglés usa los textos en inglés', (tester) async {
    await tester.pumpPanelsolar(locale: const Locale('en'));

    expect(find.widgetWithText(AppBar, 'Clients'), findsOneWidget);
    expect(find.text('Maintenance'), findsOneWidget);
    expect(find.text('Available in phase F1.'), findsOneWidget);
  });
}
