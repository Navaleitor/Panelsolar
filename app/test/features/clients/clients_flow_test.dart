import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('alta de cliente con validación y aparece en la lista', (
    tester,
  ) async {
    final env = await tester.pumpPanelsolar();

    await tester.tap(find.text('Nuevo cliente'));
    await tester.pumpAndSettle();

    // Nombre vacío y correo inválido: no guarda.
    await tester.enterKey('client-email', 'ana@');
    await tester.tapKey('client-save');
    expect(find.text('Obligatorio'), findsOneWidget);
    expect(find.text('Correo no válido'), findsOneWidget);

    await tester.enterKey('client-name', 'Ana López');
    await tester.enterKey('client-email', 'ana@solar.mx');
    await tester.enterKey('client-phone', '81 1234 5678');
    await tester.tapKey('client-save');

    // Abre la ficha del cliente recién creado.
    expect(find.widgetWithText(AppBar, 'Ana López'), findsOneWidget);
    expect(find.text('ana@solar.mx'), findsOneWidget);
    expect(find.text('Sin proyectos'), findsOneWidget);

    await tester.systemBack();
    expect(find.text('Ana López'), findsOneWidget);
    final rows = await tester.runAsync(
      () => env.db.select(env.db.clients).get(),
    );
    expect(rows, hasLength(1));
  });

  testWidgets('la búsqueda filtra la lista', (tester) async {
    final env = TestEnv();
    final repo = ClientRepository(env.db);
    await tester.runAsync(
      () => repo.create(name: 'Ana López', phone: '8112345678'),
    );
    await tester.runAsync(
      () => repo.create(name: 'Beto Ruiz', email: 'beto@x.mx'),
    );
    await tester.pumpPanelsolar(env: env);

    expect(find.text('Ana López'), findsOneWidget);
    expect(find.text('Beto Ruiz'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('clients-search')), 'beto');
    await tester.pumpAndSettle();
    expect(find.text('Ana López'), findsNothing);
    expect(find.text('Beto Ruiz'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('clients-search')), 'zzz');
    await tester.pumpAndSettle();
    expect(
      find.text('Ningún cliente coincide con la búsqueda.'),
      findsOneWidget,
    );
  });

  testWidgets('editar y borrar (lógico) un cliente', (tester) async {
    final env = TestEnv();
    final client = (await tester.runAsync(
      () => ClientRepository(env.db).create(name: 'Ana'),
    ))!;
    await tester.pumpPanelsolar(env: env);

    await tester.tap(find.text('Ana'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Editar'));
    await tester.pumpAndSettle();
    expect(find.text('Editar cliente'), findsOneWidget);
    await tester.enterKey('client-name', 'Ana María');
    await tester.tapKey('client-save');
    expect(find.widgetWithText(AppBar, 'Ana María'), findsOneWidget);

    await tester.tap(find.byType(PopupMenuButton<void>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Borrar').last);
    await tester.pumpAndSettle();
    expect(find.text('¿Borrar cliente?'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Borrar'));
    await tester.pumpAndSettle();

    expect(find.text('Ana María'), findsNothing);
    final stored = await tester.runAsync(
      () => ClientRepository(env.db).findById(client.id),
    );
    expect(stored!.deletedAt, isNotNull);
  });
}
