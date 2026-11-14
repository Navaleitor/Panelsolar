import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
