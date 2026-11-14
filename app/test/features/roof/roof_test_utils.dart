import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:persistence/persistence.dart';

import '../../helpers/pump_app.dart';

/// Toca el lienzo del editor en el píxel ([x], [y]) de la imagen,
/// considerando el zoom y el desplazamiento actuales.
Future<void> tapCanvasPx(WidgetTester tester, double x, double y) async {
  final finder = find.byKey(const Key('roof-canvas-content'));
  final rect = tester.getRect(finder);
  final size = tester.getSize(finder);
  final scale = rect.width / size.width;
  await tester.tapAt(rect.topLeft + Offset(x * scale, y * scale));
  await tester.pumpAndSettle();
}

/// Guarda una imagen PNG de [w] × [h] como imagen del techo del proyecto.
Future<void> seedRoofImage(
  WidgetTester tester,
  TestEnv env,
  String projectId, {
  int w = 1000,
  int h = 800,
}) async {
  await tester.runAsync(() async {
    final png = img.encodePng(img.Image(width: w, height: h));
    final rel = p.join('projects', projectId, 'roof', 'test.png');
    final f = File(p.join(env.storageDir.path, rel));
    await f.parent.create(recursive: true);
    await f.writeAsBytes(png);
    await RoofImageRepository(env.db).saveImage(
      projectId: projectId,
      filePath: rel,
      sha256: 'test',
      widthPx: w,
      heightPx: h,
    );
  });
}

/// Ubicación de Monterrey para el proyecto.
Future<void> seedMonterrey(WidgetTester tester, TestEnv env, String id) =>
    tester.runAsync(
      () => SiteRepository(env.db).save(
        projectId: id,
        latitude: 25.6866,
        longitude: -100.3161,
        altitudeM: 540,
        timeZone: 'America/Monterrey',
        source: LocationSource.manual,
      ),
    );

/// Escribe en el diálogo numérico y confirma.
Future<void> answerNumber(WidgetTester tester, Key field, String value) async {
  await tester.enterText(find.byKey(field), value);
  await tester.tap(find.byKey(const Key('number-ok')));
  await tester.pumpAndSettle();
}
