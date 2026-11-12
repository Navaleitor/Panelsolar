import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/seed.dart';

Future<void> openClient(WidgetTester tester) async {
  await tester.tap(find.text('Ana'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('capturar un recibo con tarifa, kWh e importe', (tester) async {
    final env = TestEnv();
    final (client, _) = await seedClientWithProject(tester, env);
    await tester.pumpPanelsolar(env: env);
    await openClient(tester);
    expect(find.textContaining('Sin recibos'), findsOneWidget);

    await tester.tapKey('bill-add');
    expect(find.text('Nuevo recibo'), findsOneWidget);
    await tester.tap(find.byKey(const Key('bill-tariff')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Doméstica 1C (verano ≥ 30 °C)').last);
    await tester.pumpAndSettle();
    await tester.enterKey('bill-kwh', '600');
    await tester.enterKey('bill-amount', '1,540.50');
    await tester.tapKey('bill-save');

    expect(find.widgetWithText(AppBar, 'Ana'), findsOneWidget);
    expect(find.byKey(const Key('consumption-annual')), findsOneWidget);
    expect(find.byType(BarChart), findsOneWidget);

    final bill = (await tester.runAsync(
      () => UtilityBillRepository(env.db).watchByClient(client.id).first,
    ))!.single;
    expect(bill.energyKwh, 600);
    expect(bill.amountCents, 154050);
    expect(bill.tariffCode, 'MX-CFE-1C');
    expect(bill.billingPeriod, BillingPeriod.bimonthly);
    expect(bill.periodEnd.isAfter(bill.periodStart), isTrue);
  });

  testWidgets('un año de recibos: anual, gráfica y aviso DAC', (tester) async {
    final env = TestEnv();
    final (client, _) = await seedClientWithProject(tester, env);
    await tester.runAsync(() async {
      final repo = UtilityBillRepository(env.db);
      for (var i = 0; i < 6; i++) {
        await repo.create(
          clientId: client.id,
          periodStart: DateTime.utc(2025, 1 + 2 * i),
          periodEnd: DateTime.utc(
            2025,
            3 + 2 * i,
          ).subtract(const Duration(days: 1)),
          billingPeriod: BillingPeriod.bimonthly,
          energyKwh: 600,
          tariffCode: 'MX-CFE-1',
        );
      }
    });
    await tester.pumpPanelsolar(env: env);
    await openClient(tester);

    // 6 × 600 kWh en 365 días = 3 600 kWh/año = 300 kWh/mes > 250 (tarifa 1).
    final annual = Formatters.number(3600, 'es');
    expect(find.text('$annual kWh'), findsOneWidget);
    expect(find.textContaining('Promedio mensual: 300 kWh'), findsOneWidget);
    expect(find.textContaining('riesgo de pasar a DAC'), findsOneWidget);
    expect(find.textContaining('estimación'), findsNothing);
    expect(find.byType(BarChart), findsOneWidget);
  });

  testWidgets('editar y borrar un recibo', (tester) async {
    final env = TestEnv();
    final (client, _) = await seedClientWithProject(tester, env);
    await tester.runAsync(
      () => UtilityBillRepository(env.db).create(
        clientId: client.id,
        periodStart: DateTime.utc(2026),
        periodEnd: DateTime.utc(2026, 1, 31),
        billingPeriod: BillingPeriod.monthly,
        energyKwh: 310,
      ),
    );
    await tester.pumpPanelsolar(env: env);
    await openClient(tester);

    await tester.tap(find.text('310 kWh'));
    await tester.pumpAndSettle();
    expect(find.text('Editar recibo'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, '310'), findsOneWidget);
    await tester.enterKey('bill-kwh', '320.5');
    await tester.tapKey('bill-save');
    // La lista muestra kWh enteros con el formato del idioma.
    final edited = '${Formatters.number(320.5, 'es')} kWh';
    expect(find.text(edited), findsOneWidget);
    final stored = (await tester.runAsync(
      () => UtilityBillRepository(env.db).watchByClient(client.id).first,
    ))!.single;
    expect(stored.energyKwh, 320.5);

    await tester.tap(find.text(edited));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Borrar'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Borrar'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Sin recibos'), findsOneWidget);
  });

  testWidgets('el siguiente recibo sugiere fechas y tarifa del anterior', (
    tester,
  ) async {
    final env = TestEnv();
    final (client, _) = await seedClientWithProject(tester, env);
    await tester.runAsync(
      () => UtilityBillRepository(env.db).create(
        clientId: client.id,
        periodStart: DateTime.utc(2026),
        periodEnd: DateTime.utc(2026, 1, 31),
        billingPeriod: BillingPeriod.monthly,
        energyKwh: 310,
        tariffCode: 'MX-CFE-PDBT',
      ),
    );
    await tester.pumpPanelsolar(env: env);
    await openClient(tester);
    await tester.tapKey('bill-add');
    await tester.enterKey('bill-kwh', '290');
    await tester.tapKey('bill-save');

    final bills = (await tester.runAsync(
      () => UtilityBillRepository(env.db).watchByClient(client.id).first,
    ))!;
    expect(bills.last.periodStart, DateTime.utc(2026, 2));
    expect(bills.last.periodEnd, DateTime.utc(2026, 2, 28));
    expect(bills.last.tariffCode, 'MX-CFE-PDBT');
    expect(bills.last.billingPeriod, BillingPeriod.monthly);
  });
}
