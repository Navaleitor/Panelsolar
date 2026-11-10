import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('desde la ficha del cliente se crea un proyecto y avanza '
      'de estado', (tester) async {
    final env = TestEnv();
    await tester.runAsync(() => ClientRepository(env.db).create(name: 'Ana'));
    await tester.pumpPanelsolar(env: env);

    await tester.tap(find.text('Ana'));
    await tester.pumpAndSettle();
    await tester.tapKey('client-add-project');
    expect(find.text('Nuevo proyecto'), findsOneWidget);
    // Viene del cliente: no pide elegirlo.
    expect(find.byKey(const Key('project-client')), findsNothing);

    await tester.enterKey('project-name', 'Casa Cumbres');
    await tester.tapKey('project-save');

    expect(find.widgetWithText(AppBar, 'Casa Cumbres'), findsOneWidget);
    expect(find.text('Prospecto'), findsOneWidget);
    expect(find.text('Sin ubicación'), findsOneWidget);

    await tester.tapKey('project-advance');
    expect(find.text('Diseño'), findsOneWidget);
    final project = (await tester.runAsync(
      () => env.db.select(env.db.projects).get(),
    ))!.single;
    expect(project.status, ProjectStatus.design);
  });

  testWidgets('la pestaña Proyectos lista y filtra por estado', (tester) async {
    final env = TestEnv();
    final ana = (await tester.runAsync(
      () => ClientRepository(env.db).create(name: 'Ana'),
    ))!;
    final projects = ProjectRepository(env.db);
    await tester.runAsync(
      () => projects.create(
        clientId: ana.id,
        name: 'Casa',
        projectDate: DateTime.utc(2026, 3),
      ),
    );
    await tester.runAsync(
      () => projects.create(
        clientId: ana.id,
        name: 'Bodega',
        projectDate: DateTime.utc(2026, 4),
        status: ProjectStatus.installed,
      ),
    );
    await tester.pumpPanelsolar(env: env);

    await tester.tap(find.text('Proyectos'));
    await tester.pumpAndSettle();
    expect(find.text('Casa'), findsOneWidget);
    expect(find.text('Bodega'), findsOneWidget);

    final chip = find.widgetWithText(ChoiceChip, 'Instalado');
    await tester.ensureVisible(chip);
    await tester.pumpAndSettle();
    await tester.tap(chip);
    await tester.pumpAndSettle();
    expect(find.text('Casa'), findsNothing);
    expect(find.text('Bodega'), findsOneWidget);
  });

  testWidgets('nuevo proyecto desde la pestaña pide elegir cliente', (
    tester,
  ) async {
    final env = TestEnv();
    await tester.runAsync(() => ClientRepository(env.db).create(name: 'Beto'));
    await tester.pumpPanelsolar(env: env);

    await tester.tap(find.text('Proyectos'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Nuevo proyecto'));
    await tester.pumpAndSettle();

    await tester.enterKey('project-name', 'Techo');
    await tester.tapKey('project-save');
    expect(find.text('Obligatorio'), findsOneWidget);

    await tester.tap(find.byKey(const Key('project-client')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Beto').last);
    await tester.pumpAndSettle();
    await tester.tapKey('project-save');

    expect(find.widgetWithText(AppBar, 'Techo'), findsOneWidget);
    expect(find.text('Beto'), findsOneWidget);
  });
}
