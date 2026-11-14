import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/seed.dart';

void main() {
  testWidgets('crear plan desde la plantilla, registrar visita y avisos', (
    tester,
  ) async {
    final env = TestEnv();
    final (_, project) = await seedClientWithProject(tester, env);
    await tester.pumpPanelsolar(env: env);
    await openProject(tester);

    await tester.tapKey('maintenance-card');
    expect(
      find.text('Este proyecto aún no tiene plan de mantenimiento.'),
      findsOneWidget,
    );
    await tester.tapKey('plan-from-template');
    await tester.pumpAndSettle();
    // 5 servicios básicos (la termografía viene desactivada).
    expect(find.text('Limpieza de paneles'), findsOneWidget);
    expect(find.text('Revisión de protecciones'), findsOneWidget);
    expect(find.text('Termografía'), findsNothing);
    expect(find.text('Cada 6 meses'), findsNWidgets(2));

    // Se programaron avisos (7 días antes y el día) para cada servicio.
    await tester.runAsync(() => Future<void>.delayed(Durations.short2));
    await tester.pump();
    expect(env.reminders.scheduled, hasLength(10));

    // Registrar visita marcando solo la limpieza.
    final plan = await tester.runAsync(
      () => MaintenanceRepository(env.db).watchPlan(project.id).first,
    );
    final cleaning = plan!.firstWhere(
      (p) => p.kind == MaintenanceServiceKind.cleaning,
    );
    await tester.tapKey('visit-new');
    await tester.tapKey('visit-done-${cleaning.id}');
    await tester.enterKey('visit-notes', 'Paneles con polvo');
    await tester.tapKey('visit-save');
    expect(find.text('Paneles con polvo'), findsOneWidget);
    expect(find.text('Fotos de la visita'), findsOneWidget);

    await tester.systemBack();
    expect(find.textContaining('1 servicio'), findsOneWidget);
    final after = await tester.runAsync(
      () => MaintenanceRepository(env.db).watchPlan(project.id).first,
    );
    final done = after!.firstWhere((p) => p.id == cleaning.id);
    expect(done.lastDoneAt, isNotNull);

    // Calendario en la pestaña Mantenimiento.
    await tester.systemBack();
    await tester.systemBack();
    await tester.tap(find.text('Mantenimiento'));
    await tester.pumpAndSettle();
    expect(find.text('Casa Cumbres · Ana'), findsNWidgets(5));
  });

  testWidgets('la plantilla se puede editar', (tester) async {
    await tester.pumpPanelsolar();
    await tester.tap(find.text('Mantenimiento'));
    await tester.pumpAndSettle();
    await tester.tapKey('maintenance-template');
    expect(find.text('Termografía'), findsOneWidget);

    await tester.tap(find.text('Limpieza de paneles'));
    await tester.pumpAndSettle();
    await tester.enterKey('service-months', '3');
    await tester.tapKey('service-save');
    expect(find.text('Cada 3 meses'), findsOneWidget);

    await tester.tapKey('template-add');
    await tester.enterKey('service-title', 'Lavado de canaleta');
    await tester.enterKey('service-months', '0');
    await tester.tapKey('service-save');
    expect(find.text('Escribe de 1 a 120 meses'), findsOneWidget);
    await tester.enterKey('service-months', '12');
    await tester.tapKey('service-save');
    expect(find.text('Lavado de canaleta'), findsOneWidget);
  });
}
