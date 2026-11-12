import 'package:flutter_test/flutter_test.dart';
import 'package:persistence/persistence.dart';

import 'pump_app.dart';

/// Crea un cliente "Ana" con un proyecto "Casa Cumbres" (fuera del reloj
/// falso de la prueba) y devuelve ambos.
Future<(Client, Project)> seedClientWithProject(
  WidgetTester tester,
  TestEnv env,
) async {
  final result = await tester.runAsync(() async {
    final client = await ClientRepository(env.db).create(name: 'Ana');
    final project = await ProjectRepository(env.db).create(
      clientId: client.id,
      name: 'Casa Cumbres',
      projectDate: DateTime.utc(2026, 11, 10),
    );
    return (client, project);
  });
  return result!;
}

/// Abre la ficha del proyecto "Casa Cumbres" desde la pestaña Proyectos.
Future<void> openProject(WidgetTester tester) async {
  await tester.tap(find.text('Proyectos'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Casa Cumbres'));
  await tester.pumpAndSettle();
}
