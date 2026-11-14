import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/roof_fakes.dart';
import '../../helpers/seed.dart';

void main() {
  testWidgets('la ficha del proyecto abre Techo y el croquis con cinta crea un '
      'plano de 80 m²', (tester) async {
    final env = TestEnv();
    final fakes = RoofFakes();
    final (_, project) = await seedClientWithProject(tester, env);
    await tester.pumpPanelsolar(env: env, extraOverrides: fakes.overrides);
    await openProject(tester);

    await tester.tapKey('project-roof');
    expect(find.text('Techo'), findsWidgets);
    expect(find.byKey(const Key('roof-base-status')), findsOneWidget);
    expect(
      find.textContaining('Importa una imagen vista desde arriba'),
      findsOneWidget,
    );

    await tester.tapKey('roof-sketch');
    for (final (i, v) in ['10', '8', '10', '8'].indexed) {
      await tester.enterText(find.byKey(Key('tape-length-$i')), v);
    }
    await tester.pump();
    expect(find.textContaining('80 m²'), findsOneWidget);
    await tester.tap(find.byKey(const Key('tape-save')));
    await tester.pumpAndSettle();

    expect(
      find.text('Croquis con medidas de cinta (sin imagen)'),
      findsOneWidget,
    );
    expect(find.text('Plano 1'), findsOneWidget);
    final planes = await tester.runAsync(
      () => RoofPlaneRepository(env.db).listByProject(project.id),
    );
    expect(planes!.single.azimuthDeg, 180); // alero al sur por defecto
    await tester.runAsync(() async {
      final poly = planes.single.polygon;
      expect(poly, '[[0.0,0.0],[10.0,0.0],[10.0,8.0],[0.0,8.0]]');
    });
    expect(PolygonMetrics.area(const [Vec2.zero]), 0);
  });

  testWidgets('importar muestra el aviso de derechos de uso', (tester) async {
    final env = TestEnv();
    await seedClientWithProject(tester, env);
    await tester.pumpPanelsolar(
      env: env,
      extraOverrides: RoofFakes().overrides,
    );
    await openProject(tester);
    await tester.tapKey('project-roof');
    await tester.tapKey('roof-import');
    expect(
      find.text('Usa solo imágenes que tengas derecho a usar.'),
      findsOneWidget,
    );
    expect(find.byKey(const Key('roof-source-gallery')), findsOneWidget);
    expect(find.byKey(const Key('roof-source-camera')), findsOneWidget);
  });

  testWidgets('en inglés', (tester) async {
    final env = TestEnv();
    await seedClientWithProject(tester, env);
    await tester.pumpPanelsolar(
      env: env,
      locale: const Locale('en'),
      extraOverrides: RoofFakes().overrides,
    );
    await tester.tap(find.text('Projects'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Casa Cumbres'));
    await tester.pumpAndSettle();
    await tester.tapKey('project-roof');
    expect(find.text('Roof base'), findsOneWidget);
    expect(find.text('Tape sketch'), findsOneWidget);
  });
}
