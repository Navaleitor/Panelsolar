import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/roof/domain/roof_codec.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/roof_fakes.dart';
import '../../helpers/seed.dart';
import 'roof_test_utils.dart';

/// Abre el editor desde la ficha del proyecto (botón Calibrar o Trazar).
Future<void> _openEditor(WidgetTester tester, String button) async {
  await openProject(tester);
  await tester.tapKey('project-roof');
  await tester.tapKey(button);
}

/// Imagen calibrada a 0.025 m/px (40 px/m) con un plano de 12 × 9 m.
Future<String> _seedCalibratedRoof(WidgetTester tester, TestEnv env) async {
  final (_, project) = await seedClientWithProject(tester, env);
  await seedMonterrey(tester, env, project.id);
  await seedRoofImage(tester, env, project.id);
  await tester.runAsync(() async {
    await RoofImageRepository(env.db).saveCalibration(
      projectId: project.id,
      metersPerPixel: 0.025,
      calibrationLine: '{"a":[100,700],"b":[500,700],"m":10}',
    );
    // Imagen 1000 × 800 con origen al centro (500, 400): el plano ocupa
    // los píxeles (200,100)–(680,460).
    await RoofPlaneRepository(env.db).add(
      projectId: project.id,
      name: 'Plano 1',
      polygon: RoofCodec.encodePolygon(const [
        Vec2(-7.5, -1.5),
        Vec2(4.5, -1.5),
        Vec2(4.5, 7.5),
        Vec2(-7.5, 7.5),
      ]),
      azimuthEdgeIndex: 0,
    );
  });
  return project.id;
}

String _verifyText(WidgetTester tester) =>
    tester.widget<Text>(find.byKey(const Key('verify-value'))).data!;

void main() {
  testWidgets('ACEPTACIÓN: techo conocido de 12 × 9 m medido dentro de ±5 %', (
    tester,
  ) async {
    final env = TestEnv();
    final (_, project) = await seedClientWithProject(tester, env);
    await seedMonterrey(tester, env, project.id);
    await seedRoofImage(tester, env, project.id);
    await tester.pumpPanelsolar(
      env: env,
      extraOverrides: RoofFakes().overrides,
    );
    await _openEditor(tester, 'roof-calibrate');

    // Calibración: barra de 10 m = 400 px (toques con 1–2 px de error).
    await tapCanvasPx(tester, 101, 700);
    await tapCanvasPx(tester, 499, 701);
    await answerNumber(tester, const Key('line-length'), '10');
    expect(find.byKey(const Key('scale-value')), findsOneWidget);

    // Trazo del techo: 480 × 360 px = 12 × 9 m, con toques imprecisos.
    await tester.tapKey('tool-draw');
    await tester.pumpAndSettle();
    await tapCanvasPx(tester, 201, 99);
    await tapCanvasPx(tester, 682, 102);
    await tapCanvasPx(tester, 679, 461);
    await tapCanvasPx(tester, 199, 458);
    expect(find.textContaining('Lados:'), findsOneWidget);
    await tester.tap(find.byKey(const Key('draw-close')));
    await tester.pumpAndSettle();

    final planes = await tester.runAsync(
      () => RoofPlaneRepository(env.db).listByProject(project.id),
    );
    final poly = RoofCodec.decodePolygon(planes!.single.polygon);
    final area = PolygonMetrics.area(poly);
    final sides = PolygonMetrics.sideLengths(poly);
    expect((area - 108).abs() / 108, lessThan(0.05), reason: 'área $area');
    expect((sides[0] - 12).abs() / 12, lessThan(0.05));
    expect((sides[1] - 9).abs() / 9, lessThan(0.05));
    // El imán dejó las esquinas a 90°.
    expect(PolygonMetrics.interiorAngles(poly), everyElement(closeTo(90, 1.5)));
    expect(planes.single.azimuthDeg, closeTo(180, 1));
  });

  testWidgets('verificación de escala muestra la diferencia y avisa > 5 %', (
    tester,
  ) async {
    final env = TestEnv();
    await _seedCalibratedRoof(tester, env);
    await tester.pumpPanelsolar(
      env: env,
      extraOverrides: RoofFakes().overrides,
    );
    await _openEditor(tester, 'roof-calibrate');
    await tester.tapKey('tool-verify');
    await tester.pumpAndSettle();
    await tapCanvasPx(tester, 750, 200);
    await tapCanvasPx(tester, 750, 600); // 400 px = 10 m con la escala
    await answerNumber(tester, const Key('line-length'), '9.6');
    expect(_verifyText(tester), matches(RegExp(r'\+4[.,]2 %')));
    expect(find.textContaining('Diferencia mayor a 5 %'), findsNothing);

    await tapCanvasPx(tester, 750, 200);
    await tapCanvasPx(tester, 750, 600);
    await answerNumber(tester, const Key('line-length'), '9');
    expect(_verifyText(tester), matches(RegExp(r'\+11[.,]1 %')));
    expect(find.textContaining('Diferencia mayor a 5 %'), findsOneWidget);
  });

  testWidgets('norte confirmado con brújula corregida por declinación', (
    tester,
  ) async {
    final env = TestEnv();
    final id = await _seedCalibratedRoof(tester, env);
    final fakes = RoofFakes();
    // Teléfono acostado con la punta al norte magnético.
    fakes.sensors
      ..accel = (x: 0, y: 0, z: 9.81)
      ..mag = (x: 0, y: 25, z: -35);
    await tester.pumpPanelsolar(env: env, extraOverrides: fakes.overrides);
    await _openEditor(tester, 'roof-north');

    // Orilla de abajo del plano, de izquierda a derecha (rumbo 90° en la
    // imagen).
    await tapCanvasPx(tester, 200, 460);
    await tapCanvasPx(tester, 680, 460);
    await tester.tap(find.byKey(const Key('north-compass')));
    await tester.pumpAndSettle();
    expect(find.textContaining('Rumbo:'), findsOneWidget);
    await tester.tap(find.byKey(const Key('sensor-use')));
    await tester.pumpAndSettle();

    final decl = WorldMagneticModel.declination(
      latitude: 25.6866,
      longitude: -100.3161,
      altitudeM: 540,
      year: WorldMagneticModel.decimalYear(DateTime.now()),
    );
    final r = await tester.runAsync(
      () => RoofImageRepository(env.db).getForProject(id),
    );
    expect(r!.northSource, NorthSource.compass);
    expect(r.northAngleDeg, closeTo(90 - decl, 0.01));
    expect(r.magneticDeclinationDeg, closeTo(decl, 1e-9));
    // El plano se giró con la imagen, sin cambiar de tamaño.
    final plane = (await tester.runAsync(
      () => RoofPlaneRepository(env.db).listByProject(id),
    ))!.single;
    final poly = RoofCodec.decodePolygon(plane.polygon);
    expect(PolygonMetrics.area(poly), closeTo(108, 0.05));
    // El alero (abajo en la imagen) mira a 180° − ángulo del norte.
    expect(plane.azimuthDeg, closeTo(90 + decl, 0.05));
  });

  testWidgets('tinaco de 2500 L con altura del catálogo', (tester) async {
    final env = TestEnv();
    final id = await _seedCalibratedRoof(tester, env);
    await tester.pumpPanelsolar(
      env: env,
      extraOverrides: RoofFakes().overrides,
    );
    await _openEditor(tester, 'roof-edit');
    await tester.tapKey('tool-obstacle');
    await tester.pumpAndSettle();
    await tapCanvasPx(tester, 400, 300);
    await tester.tap(find.byKey(const Key('tank-2500')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('obstacle-save')));
    await tester.pumpAndSettle();
    final o = (await tester.runAsync(
      () => ObstacleRepository(env.db).listByProject(id),
    ))!.single;
    expect(o.kind, ObstacleKind.waterTank);
    expect(o.tankLiters, 2500);
    expect(o.widthM, 1.55);
    expect(o.heightM, closeTo(2.0, 1e-9));
    expect(o.heightSource, HeightSource.typical);
    // Centro en metros locales: (400 − 500, 400 − 300) px × 0.025.
    expect(o.centerX, closeTo(-2.5, 0.05));
    expect(o.centerY, closeTo(2.5, 0.05));
  });

  testWidgets('antena con altura medida con el teléfono', (tester) async {
    final env = TestEnv();
    final id = await _seedCalibratedRoof(tester, env);
    await tester.pumpPanelsolar(
      env: env,
      extraOverrides: RoofFakes().overrides,
    );
    await _openEditor(tester, 'roof-edit');
    await tester.tapKey('tool-obstacle');
    await tester.pumpAndSettle();
    await tester.tapKey('obstacle-type-antenna');
    await tester.pumpAndSettle();
    await tapCanvasPx(tester, 300, 200);
    await tester.tap(find.text('Teléfono'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('height-distance')), '10');
    await tester.enterText(find.byKey(const Key('height-angle')), '30');
    await tester.pump();
    expect(
      tester.widget<Text>(find.byKey(const Key('height-result'))).data,
      matches(RegExp('Altura: 7[.,]27 m')),
    );
    await tester.tap(find.byKey(const Key('height-use')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('obstacle-save')));
    await tester.pumpAndSettle();
    final o = (await tester.runAsync(
      () => ObstacleRepository(env.db).listByProject(id),
    ))!.single;
    expect(o.kind, ObstacleKind.antenna);
    expect(o.heightM, closeTo(7.27, 0.01));
    expect(o.heightSource, HeightSource.phone);
  });

  testWidgets('inclinación del plano con el inclinómetro', (tester) async {
    final env = TestEnv();
    final id = await _seedCalibratedRoof(tester, env);
    final fakes = RoofFakes();
    const t = 20 * math.pi / 180;
    fakes.sensors.accel = (x: 0, y: 9.81 * math.sin(t), z: 9.81 * math.cos(t));
    await tester.pumpPanelsolar(env: env, extraOverrides: fakes.overrides);
    await _openEditor(tester, 'roof-edit');
    await tester.tapKey('tool-select');
    await tester.pumpAndSettle();
    await tapCanvasPx(tester, 300, 300);
    expect(find.byKey(const Key('plane-summary')), findsOneWidget);
    await tester.tap(find.byKey(const Key('plane-edit')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('plane-inclinometer')));
    await tester.pumpAndSettle();
    expect(find.text('Inclinación: 20°'), findsOneWidget);
    await tester.tap(find.byKey(const Key('sensor-use')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('plane-save')));
    await tester.pumpAndSettle();
    final p = (await tester.runAsync(
      () => RoofPlaneRepository(env.db).listByProject(id),
    ))!.single;
    expect(p.tiltDeg, closeTo(20, 0.01));
    expect(p.tiltSource, TiltSource.inclinometer);
  });
}
