import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/pump_app.dart';

void main() {
  testWidgets('arranca en Clientes con la lista vacía', (tester) async {
    await tester.pumpPanelsolar();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.widgetWithText(AppBar, 'Clientes'), findsOneWidget);
    expect(find.text('Aún no hay clientes. Toca «Nuevo cliente».'), findsOne);
  });

  testWidgets('cada pestaña abre su pantalla', (tester) async {
    await tester.pumpPanelsolar();

    const tabs = {
      'Proyectos': 'No hay proyectos.',
      'Catálogo': 'Disponible en la fase F4.',
      'Mantenimiento':
          'No hay visitas programadas. Abre un proyecto → '
          'Mantenimiento → "Crear plan".',
      'Ajustes': 'Exportar a archivo .zip',
      'Clientes': 'Aún no hay clientes. Toca «Nuevo cliente».',
    };
    for (final MapEntry(key: tab, value: text) in tabs.entries) {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(tab),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, tab), findsOneWidget);
      expect(find.text(text), findsOneWidget);
    }
  });

  testWidgets('Ajustes muestra la base de datos funcionando', (tester) async {
    await tester.pumpPanelsolar();
    await tester.tap(find.text('Ajustes'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.textContaining('Funcionando'),
      200,
      scrollable: find.byType(Scrollable).first,
    );

    expect(find.text('Funcionando · esquema v4'), findsOneWidget);
  });

  testWidgets('en inglés usa los textos en inglés', (tester) async {
    await tester.pumpPanelsolar(locale: const Locale('en'));

    expect(find.widgetWithText(AppBar, 'Clients'), findsOneWidget);
    expect(find.text('Maintenance'), findsOneWidget);
    expect(find.text('New client'), findsOneWidget);
  });
}
