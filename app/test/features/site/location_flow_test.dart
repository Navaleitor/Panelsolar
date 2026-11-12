import 'package:data_sources/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/site/domain/location_service.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/seed.dart';

Future<Site?> savedSite(WidgetTester tester, TestEnv env, String projectId) =>
    tester
        .runAsync(() => SiteRepository(env.db).watchForProject(projectId).first)
        .then((s) => s);

void main() {
  late TestEnv env;
  late Project project;

  Future<void> openLocation(WidgetTester tester) async {
    env = TestEnv();
    (_, project) = await seedClientWithProject(tester, env);
    await tester.pumpPanelsolar(env: env);
    await openProject(tester);
    expect(find.text('Sin ubicación'), findsOneWidget);
    await tester.tapKey('project-set-location');
  }

  testWidgets('coordenadas a mano → confirmar → se guardan', (tester) async {
    await openLocation(tester);
    await tester.tapKey('location-manual');
    await tester.enterKey('manual-coordinates', 'hola');
    await tester.tapKey('manual-coordinates-ok');
    expect(find.text('No se reconocen las coordenadas.'), findsOneWidget);

    await tester.enterKey('manual-coordinates', '25.6866, -100.3161');
    await tester.tapKey('manual-coordinates-ok');

    expect(find.text('¿Es correcta esta ubicación?'), findsOneWidget);
    expect(find.text('25.686600, -100.316100'), findsOneWidget);
    expect(find.text('Escritas a mano'), findsOneWidget);
    // Zona horaria del teléfono por defecto.
    expect(find.text('America/Monterrey'), findsOneWidget);

    await tester.tapKey('confirm-location');
    expect(find.widgetWithText(AppBar, 'Casa Cumbres'), findsOneWidget);
    expect(find.text('25.686600, -100.316100'), findsOneWidget);

    final site = await savedSite(tester, env, project.id);
    expect(site!.source, LocationSource.manual);
    expect(site.timeZone, 'America/Monterrey');
    expect(site.sourceText, '25.6866, -100.3161');
  });

  testWidgets('GPS trae altitud y precisión', (tester) async {
    await openLocation(tester);
    await tester.tapKey('location-gps');

    expect(find.text('25.686614, -100.316113'), findsOneWidget);
    expect(find.text('Precisión: ±6 m'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, '540'), findsOneWidget);
    await tester.tapKey('confirm-location');

    final site = await savedSite(tester, env, project.id);
    expect(site!.source, LocationSource.gps);
    expect(site.altitudeM, 540);
    expect(site.accuracyM, 6);
  });

  testWidgets('GPS con permiso bloqueado muestra cómo resolverlo', (
    tester,
  ) async {
    await openLocation(tester);
    env.location.failure = LocationFailure.permissionDeniedForever;
    await tester.tapKey('location-gps');
    expect(find.textContaining('Ajustes del teléfono'), findsOneWidget);
  });

  testWidgets('enlace corto de Google Maps se expande', (tester) async {
    await openLocation(tester);
    env.redirects['https://maps.app.goo.gl/AbC'] =
        'https://www.google.com/maps/@19.4326,-99.1332,17z';
    await tester.tapKey('location-link');
    await tester.enterKey('map-link', 'Mi casa https://maps.app.goo.gl/AbC');
    await tester.tapKey('map-link-ok');

    expect(find.text('19.432600, -99.133200'), findsOneWidget);
    expect(find.text('Enlace de mapa'), findsOneWidget);
    await tester.tapKey('confirm-location');
    final site = await savedSite(tester, env, project.id);
    expect(site!.sourceText, contains('maps.app.goo.gl'));
  });

  testWidgets('enlace no reconocido avisa', (tester) async {
    await openLocation(tester);
    await tester.tapKey('location-link');
    await tester.enterKey('map-link', 'https://example.com/x');
    await tester.tapKey('map-link-ok');
    expect(
      find.text('No se encontraron coordenadas en ese texto.'),
      findsOneWidget,
    );
  });

  testWidgets('búsqueda por dirección con atribución OSM', (tester) async {
    await openLocation(tester);
    env.geocoder.results = const [
      GeocodeResult(
        latitude: 25.6694,
        longitude: -100.3097,
        displayName: 'Macroplaza, Monterrey, Nuevo León',
      ),
    ];
    await tester.tapKey('location-address');
    expect(find.textContaining('OpenStreetMap'), findsOneWidget);
    await tester.enterKey('address-query', 'Macroplaza Monterrey');
    await tester.tapKey('address-search');
    expect(env.geocoder.queries, ['Macroplaza Monterrey']);

    await tester.tap(find.text('Macroplaza, Monterrey, Nuevo León'));
    await tester.pumpAndSettle();
    expect(find.text('25.669400, -100.309700'), findsOneWidget);
    await tester.tapKey('confirm-location');
    final site = await savedSite(tester, env, project.id);
    expect(site!.source, LocationSource.address);
  });

  testWidgets('enlace con solo el lugar abre la búsqueda por dirección', (
    tester,
  ) async {
    await openLocation(tester);
    env.geocoder.results = const [];
    await tester.tapKey('location-link');
    await tester.enterKey(
      'map-link',
      'https://www.google.com/maps/place/Parque+Fundidora',
    );
    await tester.tapKey('map-link-ok');
    expect(env.geocoder.queries, ['Parque Fundidora']);
    expect(find.textContaining('Sin resultados'), findsOneWidget);
  });

  testWidgets('sin red al buscar dirección avisa', (tester) async {
    await openLocation(tester);
    env.geocoder.error = const GeocodingException(GeocodingFailure.network);
    await tester.tapKey('location-address');
    await tester.enterKey('address-query', 'x');
    await tester.tapKey('address-search');
    expect(find.textContaining('Sin conexión'), findsOneWidget);
  });

  testWidgets('zona horaria desconocida no se guarda', (tester) async {
    await openLocation(tester);
    await tester.tapKey('location-manual');
    await tester.enterKey('manual-coordinates', '20, -100');
    await tester.tapKey('manual-coordinates-ok');
    await tester.enterKey('confirm-timezone', 'Marte/Olympus');
    await tester.tapKey('confirm-location');
    expect(find.textContaining('Zona horaria desconocida'), findsOneWidget);
    expect(await savedSite(tester, env, project.id), isNull);
  });
}
