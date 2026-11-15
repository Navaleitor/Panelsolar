import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/production/domain/expected_production_source.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/seed.dart';

void main() {
  testWidgets('capturar lecturas, ver alerta y PR', (tester) async {
    final env = TestEnv();
    await seedClientWithProject(tester, env);
    await tester.pumpPanelsolar(env: env);
    await openProject(tester);
    await tester.scrollUntilVisible(
      find.byKey(const Key('production-card')),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tapKey('production-card');

    // Ajustes: 5 kWp y umbral 15 %.
    await tester.tapKey('production-settings');
    await tester.enterKey('production-kwp', '5');
    await tester.tapKey('production-settings-save');

    // Mes normal.
    await tester.tapKey('reading-add');
    await tester.enterKey('reading-actual', '600');
    await tester.enterKey('reading-expected', '650');
    await tester.enterKey('reading-poa', '150');
    await tester.tapKey('reading-save');
    expect(find.textContaining('PR 80 %'), findsOneWidget);
    expect(find.byKey(const Key('production-alert')), findsNothing);

    // Mes bajo: −30 % → alerta (se sugiere el mes siguiente).
    await tester.tapKey('reading-add');
    await tester.enterKey('reading-actual', '455');
    await tester.enterKey('reading-expected', '650');
    await tester.tapKey('reading-save');
    expect(find.byKey(const Key('production-alert')), findsOneWidget);
    expect(find.text('1 mes por debajo de lo esperado'), findsOneWidget);
    expect(find.textContaining('(-30 %)'), findsOneWidget);

    await tester.systemBack();
    expect(find.textContaining('Bajo el umbral'), findsOneWidget);
  });

  testWidgets('el valor esperado se precarga del motor y es editable', (
    tester,
  ) async {
    final env = TestEnv()..expected = const _FixedExpected(640);
    await seedClientWithProject(tester, env);
    await tester.pumpPanelsolar(env: env);
    await openProject(tester);
    await tester.scrollUntilVisible(
      find.byKey(const Key('production-card')),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tapKey('production-card');
    await tester.tapKey('reading-add');
    final field = tester.widget<TextField>(
      find.byKey(const Key('reading-expected')),
    );
    expect(field.controller!.text, '640');
    expect(find.textContaining('Propuesto por el motor'), findsOneWidget);
    await tester.enterKey('reading-expected', '600');
    await tester.enterKey('reading-actual', '590');
    await tester.tapKey('reading-save');
    expect(find.textContaining('Esperado 600 kWh'), findsOneWidget);
  });
}

class _FixedExpected implements ExpectedProductionSource {
  const new(this.kwh);

  final double kwh;

  @override
  Future<({double expectedKwh, double? poaKwhM2})?> expectedFor(
    String projectId,
    DateTime month,
  ) async => (expectedKwh: kwh, poaKwhM2: null);
}
