import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/seed.dart';

void main() {
  testWidgets('agregar un equipo y llenar la puesta en marcha', (tester) async {
    final env = TestEnv();
    final (_, project) = await seedClientWithProject(tester, env);
    await tester.pumpPanelsolar(env: env);
    await openProject(tester);

    await tester.tapKey('installation-card');
    expect(
      find.text(
        'Aún no hay equipos. Agrega paneles, inversor y '
        'protecciones con su número de serie.',
      ),
      findsOneWidget,
    );

    // Equipo nuevo.
    await tester.tapKey('equipment-add');
    await tester.enterKey('equipment-brand', 'Fronius');
    await tester.enterKey('equipment-model', 'Primo 5.0');
    await tester.enterKey('equipment-serial', 'SN-123');
    await tester.tapKey('equipment-save');
    expect(find.text('Fronius Primo 5.0'), findsOneWidget);
    expect(find.textContaining('S/N SN-123'), findsOneWidget);

    // Checklist: un string medido dentro de tolerancia.
    await tester.tapKey('commissioning-open');
    await tester.tapKey('string-add');
    await tester.enterKey('string-exp-voc', '400');
    await tester.enterKey('string-meas-voc', '396,5');
    await tester.enterKey('string-exp-isc', '10');
    await tester.enterKey('string-meas-isc', '9.6');
    await tester.tap(find.text('Bien').last);
    await tester.pumpAndSettle();
    await tester.tapKey('string-save');
    expect(find.textContaining('-0,9 %'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);

    await tester.enterKey('insulation-mohm', '0.5');
    await tester.tapKey('commissioning-save');
    // Sugerencia con lo guardado: aislamiento bajo → observaciones.
    expect(
      find.text('Según lo guardado, la app sugiere: Con observaciones'),
      findsOneWidget,
    );

    final record = await tester.runAsync(
      () => CommissioningRepository(env.db).watchRecord(project.id).first,
    );
    expect(record!.insulationMohm, 0.5);
    expect(record.status, CommissioningStatus.pending);
    // Ya guardado, aparece la sección de fotos de evidencia.
    await tester.scrollUntilVisible(
      find.text('Fotos de evidencia'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
  });
}
