import 'dart:io';

import 'package:data_sources/data_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/catalog/data/catalog_providers.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/pump_app.dart';

CecCatalog sampleCatalog() {
  String f(String n) =>
      File('../packages/data_sources/test/fixtures/$n').readAsStringSync();
  return (
    modules: CecParser.modules(f('cec_modules_sample.csv')),
    inverters: CecParser.inverters(f('cec_inverters_sample.csv')),
  );
}

Future<void> openCatalog(WidgetTester tester) async {
  await tester.tap(find.text('Catálogo'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('captura un panel con su hoja de datos', (tester) async {
    final env = await tester.pumpPanelsolar();
    await openCatalog(tester);
    await tester.tapKey('catalog-add');
    expect(find.text('Panel nuevo'), findsOneWidget);

    // Sin datos no guarda.
    await tester.tapKey('spec-save');
    expect(find.text('Obligatorio *'.replaceAll(' *', '')), findsWidgets);

    const values = {
      'manufacturer': 'Solar MX',
      'model': 'SM-550',
      'pmaxW': '550',
      'vocV': '49,6',
      'iscA': '14',
      'vmpV': '41.7',
      'impA': '13.2',
      'lengthM': '2.278',
      'widthM': '1.134',
    };
    for (final e in values.entries) {
      await tester.enterKey('spec-${e.key}', e.value);
    }
    await tester.tapKey('spec-save');
    expect(find.text('Solar MX SM-550'), findsOneWidget);
    expect(find.text('550 W · Voc 49.6 V · Isc 14.0 A'), findsOneWidget);

    final saved = await tester.runAsync(
      () => PanelModelRepository(env.db).watchAll().first,
    );
    expect(saved!.single.vocV, 49.6);
    expect(saved.single.gammaPmaxPct, -0.35);

    // Editar.
    await tester.tap(find.text('Solar MX SM-550'));
    await tester.pumpAndSettle();
    expect(find.text('Editar equipo'), findsOneWidget);
    await tester.enterKey('spec-model', 'SM-555');
    await tester.tapKey('spec-save');
    expect(find.text('Solar MX SM-555'), findsOneWidget);
  });

  testWidgets('Vmp ≥ Voc muestra el error', (tester) async {
    await tester.pumpPanelsolar();
    await openCatalog(tester);
    await tester.tapKey('catalog-add');
    const values = {
      'manufacturer': 'X',
      'model': 'Y',
      'pmaxW': '400',
      'vocV': '40',
      'iscA': '10',
      'vmpV': '45',
      'impA': '9',
      'lengthM': '2',
      'widthM': '1',
    };
    for (final e in values.entries) {
      await tester.enterKey('spec-${e.key}', e.value);
    }
    await tester.tapKey('spec-save');
    expect(find.textContaining('Vmp debe ser menor'), findsOneWidget);
  });

  testWidgets('captura un inversor y borra', (tester) async {
    await tester.pumpPanelsolar();
    await openCatalog(tester);
    await tester.tap(find.byKey(const Key('catalog-tab-inverter')));
    await tester.pumpAndSettle();
    await tester.tapKey('catalog-add');
    const values = {
      'manufacturer': 'Inv',
      'model': '5K',
      'pacW': '5000',
      'vdcMaxV': '600',
      'mpptMinV': '90',
      'mpptMaxV': '520',
      'imaxPerMpptA': '16',
    };
    for (final e in values.entries) {
      await tester.enterKey('spec-${e.key}', e.value);
    }
    await tester.tapKey('spec-save');
    expect(find.text('5.0 kW · 2 MPPT · De string'), findsOneWidget);
    await tester.tap(find.byTooltip('Borrar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Borrar').last);
    await tester.pumpAndSettle();
    expect(find.text('Inv 5K'), findsNothing);
  });

  testWidgets('busca e importa solo el equipo elegido de CEC', (tester) async {
    final catalog = sampleCatalog();
    final env = await tester.pumpPanelsolar(
      extraOverrides: [
        cecCatalogLoaderProvider.overrideWithValue(() async => catalog),
      ],
    );
    await openCatalog(tester);
    await tester.tapKey('catalog-cec');
    expect(find.text('Escribe al menos 2 letras.'), findsOneWidget);
    await tester.enterKey('cec-search', 'ablytek');
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Importar'));
    await tester.pumpAndSettle();
    expect(find.text('Importado al catálogo'), findsOneWidget);
    final panels = await tester.runAsync(
      () => PanelModelRepository(env.db).watchAll().first,
    );
    expect(panels!.single.source, EquipmentSource.cec);
    expect(panels.single.pmaxW, 270);
  });
}
