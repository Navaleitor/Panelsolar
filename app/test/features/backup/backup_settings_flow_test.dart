import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/seed.dart';

Future<void> openSettings(WidgetTester tester) async {
  await tester.tap(find.text('Ajustes'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('exportar .zip con contraseña, borrar y restaurar con vista '
      'previa', (tester) async {
    final env = TestEnv();
    await seedClientWithProject(tester, env);
    await tester.pumpPanelsolar(env: env);
    await openSettings(tester);

    await tester.tapKey('backup-export');
    await tester.enterKey('password-new', 'secreta1');
    await tester.enterKey('password-confirm', 'secreta1');
    await tester.tap(find.byKey(const Key('password-ok')));
    // VACUUM INTO, cifrado y archivos: E/S real fuera del reloj falso.
    await tester.runAsync(() async {
      for (var i = 0; i < 100 && env.savedFiles.isEmpty; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 50));
      }
    });
    await tester.pumpAndSettle();
    expect(env.savedFiles, hasLength(1));
    expect(find.text('Respaldo guardado'), findsOneWidget);

    // Se "pierden" los datos.
    await tester.runAsync(() async {
      await env.db.customStatement('DELETE FROM projects');
      await env.db.customStatement('DELETE FROM clients');
    });
    final zip = File('${env.storageDir.path}/elegido.zip');
    await tester.runAsync(() => zip.writeAsBytes(env.savedFiles.values.single));
    env.fileToPick = zip;

    await tester.tapKey('backup-import');
    expect(find.text('Cifrado: pide contraseña'), findsOneWidget);
    expect(
      tester.widget<Text>(find.byKey(const Key('preview-clients'))).data,
      '1',
    );

    await tester.enterKey('restore-password', 'mala');
    await tester.tapKey('restore-start');
    await tester.tap(find.text('Restaurar').last);
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 800)),
    );
    await tester.pumpAndSettle();
    expect(find.text('Contraseña incorrecta'), findsOneWidget);

    await tester.enterKey('restore-password', 'secreta1');
    await tester.tapKey('restore-start');
    await tester.tap(find.text('Restaurar').last);
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 800)),
    );
    await tester.pumpAndSettle();
    // Vuelve a Clientes con los datos restaurados.
    expect(find.text('Ana'), findsOneWidget);
    final logs = await tester.runAsync(
      () => BackupLogRepository(env.db).watchRecent().first,
    );
    expect(logs!.map((l) => l.trigger), contains(BackupTrigger.restore));
  });

  testWidgets('Drive sin configurar muestra el aviso; configurado se conecta', (
    tester,
  ) async {
    final env = TestEnv()..driveAuth.configured = false;
    await tester.pumpPanelsolar(env: env);
    await openSettings(tester);
    expect(find.byKey(const Key('drive-not-configured')), findsOneWidget);
  });

  testWidgets('conectar Drive programa el respaldo diario', (tester) async {
    final env = TestEnv();
    await tester.pumpPanelsolar(env: env);
    await openSettings(tester);
    await tester.tapKey('drive-connect');
    expect(find.text('instalador@example.com'), findsOneWidget);
    expect(env.schedule.applied?.name, 'daily');
    expect(find.byKey(const Key('drive-backup-now')), findsOneWidget);
  });
}
