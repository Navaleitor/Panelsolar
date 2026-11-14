import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/roof/domain/roof_codec.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/roof_fakes.dart';
import '../../helpers/seed.dart';
import 'roof_test_utils.dart';

/// Croquis con un plano de 10 × 8 m y un tinaco al sur, en Monterrey.
Future<String> _seed(WidgetTester tester, TestEnv env) async {
  final (_, project) = await seedClientWithProject(tester, env);
  await seedMonterrey(tester, env, project.id);
  await tester.runAsync(() async {
    await RoofImageRepository(env.db).startSketch(project.id);
    await RoofPlaneRepository(env.db).add(
      projectId: project.id,
      name: 'Plano 1',
      polygon: '[[0,0],[10,0],[10,8],[0,8]]',
    );
    await ObstacleRepository(env.db).add(
      projectId: project.id,
      kind: ObstacleKind.waterTank,
      outline: ObstacleOutline.circle,
      centerX: 5,
      centerY: 1,
      widthM: 1.1,
      heightM: 1.7,
      heightSource: HeightSource.typical,
    );
  });
  return project.id;
}

void main() {
  testWidgets('sombras: posición del Sol y mapa de calor anual', (
    tester,
  ) async {
    final env = TestEnv();
    await _seed(tester, env);
    await tester.pumpPanelsolar(
      env: env,
      extraOverrides: RoofFakes().overrides,
    );
    await openProject(tester);
    await tester.tapKey('project-roof');
    await tester.tapKey('roof-shade');
    expect(find.byKey(const Key('sun-position')), findsOneWidget);
    expect(find.textContaining('Sol:'), findsOneWidget);

    await tester.tap(find.byKey(const Key('shade-compute')));
    await tester.pumpAndSettle();
    expect(find.textContaining('Plano 1: pierde'), findsOneWidget);
    expect(find.byKey(const Key('shade-heat-toggle')), findsOneWidget);
  });

  testWidgets('sin ubicación pide guardarla primero', (tester) async {
    final env = TestEnv();
    final (_, project) = await seedClientWithProject(tester, env);
    await tester.runAsync(() async {
      await RoofImageRepository(env.db).startSketch(project.id);
      await RoofPlaneRepository(env.db).add(
        projectId: project.id,
        name: 'Plano 1',
        polygon: '[[0,0],[10,0],[10,8],[0,8]]',
      );
    });
    await tester.pumpPanelsolar(
      env: env,
      extraOverrides: RoofFakes().overrides,
    );
    await openProject(tester);
    await tester.tapKey('project-roof');
    await tester.tapKey('roof-shade');
    expect(find.textContaining('Primero guarda la ubicación'), findsOneWidget);
  });

  testWidgets('horizonte: terreno de PVGIS y obstáculo lejano escrito', (
    tester,
  ) async {
    final env = TestEnv();
    final id = await _seed(tester, env);
    final fakes = RoofFakes();
    await tester.pumpPanelsolar(env: env, extraOverrides: fakes.overrides);
    await openProject(tester);
    await tester.tapKey('project-roof');
    await tester.tapKey('roof-horizon');
    expect(find.text('Sin descargar'), findsOneWidget);

    await tester.tap(find.byKey(const Key('terrain-download')));
    await tester.pumpAndSettle();
    expect(fakes.terrainCalls, 1);
    expect(find.textContaining('Descargado'), findsOneWidget);

    await tester.tap(find.byKey(const Key('far-add')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('far-name')), 'Árbol');
    for (final (az, el) in [('170', '20'), ('190', '25')]) {
      await tester.enterText(find.byKey(const Key('far-az')), az);
      await tester.enterText(find.byKey(const Key('far-el')), el);
      await tester.tap(find.byKey(const Key('far-add-point')));
      await tester.pump();
    }
    await tester.tap(find.byKey(const Key('far-save')));
    await tester.pumpAndSettle();
    expect(find.text('Árbol'), findsOneWidget);

    final rows = await tester.runAsync(
      () => HorizonProfileRepository(env.db).listByProject(id),
    );
    final far = rows!.firstWhere((r) => r.source == HorizonSource.manual);
    expect(RoofCodec.decodeHorizon(far.points), hasLength(2));
    expect(rows.where((r) => r.source == HorizonSource.terrain), hasLength(1));
  });
}
