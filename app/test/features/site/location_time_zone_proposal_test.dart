import 'package:flutter_test/flutter_test.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/seed.dart';

void main() {
  testWidgets('al confirmar se propone la zona de las coordenadas', (
    tester,
  ) async {
    final env = TestEnv();
    // El teléfono está en Monterrey, pero el sitio está en Hermosillo.
    env.timeZones.byCoordinates['29.0729,-110.9559'] = 'America/Hermosillo';
    final (_, project) = await seedClientWithProject(tester, env);
    await tester.pumpPanelsolar(env: env);
    await openProject(tester);
    await tester.tapKey('project-set-location');
    await tester.tapKey('location-manual');
    await tester.enterKey('manual-coordinates', '29.0729, -110.9559');
    await tester.tapKey('manual-coordinates-ok');

    expect(find.text('America/Hermosillo'), findsOneWidget);
    expect(find.text('America/Monterrey'), findsNothing);
    await tester.tapKey('confirm-location');

    final site = await tester.runAsync(
      () => SiteRepository(env.db).watchForProject(project.id).first,
    );
    expect(site!.timeZone, 'America/Hermosillo');
  });

  testWidgets('si no se deduce, se propone la del teléfono', (tester) async {
    final env = TestEnv();
    await seedClientWithProject(tester, env);
    await tester.pumpPanelsolar(env: env);
    await openProject(tester);
    await tester.tapKey('project-set-location');
    await tester.tapKey('location-manual');
    await tester.enterKey('manual-coordinates', '29.0729, -110.9559');
    await tester.tapKey('manual-coordinates-ok');
    expect(find.text('America/Monterrey'), findsOneWidget);
  });
}
