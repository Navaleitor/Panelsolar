import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/seed.dart';

void main() {
  testWidgets('fotos por etapa, ver detalle, descripción y borrar', (
    tester,
  ) async {
    final env = TestEnv();
    final (_, project) = await seedClientWithProject(tester, env);
    await tester.runAsync(() async {
      final repo = PhotoRepository(env.db);
      await repo.add(
        projectId: project.id,
        stage: PhotoStage.survey,
        filePath: 'projects/x/photos/a.jpg',
        sha256: 'a',
        widthPx: 1600,
        heightPx: 1200,
        latitude: 25.5,
        longitude: -100.25,
      );
      await repo.add(
        projectId: project.id,
        stage: PhotoStage.installation,
        filePath: 'projects/x/photos/b.jpg',
        sha256: 'b',
        widthPx: 1200,
        heightPx: 1600,
      );
    });
    await tester.pumpPanelsolar(env: env);
    await openProject(tester);

    // Resumen en la ficha: 1 de levantamiento, 1 de instalación, 0 de mant.
    await tester.tapKey('project-open-photos');
    expect(find.text('Levantamiento'), findsOneWidget);
    expect(find.byType(InkWell), findsWidgets);

    await tester.tap(find.byType(GridView).first);
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(GridView).first,
        matching: find.byType(InkWell),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('1600×1200 px'), findsOneWidget);
    expect(find.text('25.500000, -100.250000'), findsOneWidget);

    await tester.tap(find.byTooltip('Descripción'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('photo-caption')), 'Fachada');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(find.text('Fachada'), findsOneWidget);

    await tester.tap(find.byTooltip('Borrar'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Borrar'));
    await tester.pumpAndSettle();
    expect(find.text('Sin fotos en esta etapa'), findsOneWidget);

    // Pestaña Instalación: la otra foto sigue ahí.
    await tester.tap(find.text('Instalación'));
    await tester.pumpAndSettle();
    expect(find.text('Sin fotos en esta etapa'), findsNothing);
  });

  testWidgets('el botón de agregar ofrece cámara y galería', (tester) async {
    final env = TestEnv();
    await seedClientWithProject(tester, env);
    await tester.pumpPanelsolar(env: env);
    await openProject(tester);
    await tester.tapKey('project-open-photos');
    await tester.tapKey('photos-add');
    expect(find.text('Tomar con la cámara'), findsOneWidget);
    expect(find.text('Elegir de la galería'), findsOneWidget);
  });
}
