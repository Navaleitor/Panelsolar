import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/documents/data/document_providers.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/seed.dart';

/// Menú (⋮) de la fila del documento (no el de la barra superior).
Finder docMenu() => find.descendant(
  of: find.byType(ListTile),
  matching: find.byType(PopupMenuButton<void>),
);

void main() {
  testWidgets('agregar un PDF, abrirlo, renombrarlo y borrarlo', (
    tester,
  ) async {
    final env = TestEnv();
    final (_, project) = await seedClientWithProject(tester, env);
    final opened = <String>[];
    await tester.pumpPanelsolar(
      env: env,
      extraOverrides: [
        documentPickerProvider.overrideWithValue(
          () async => (
            name: 'Contrato.pdf',
            bytes: Uint8List.fromList('%PDF-1.7 x'.codeUnits),
          ),
        ),
        fileOpenerProvider.overrideWithValue((path, mime) async {
          opened.add('$mime $path');
          return true;
        }),
      ],
    );
    await openProject(tester);
    expect(find.text('Sin documentos (PDF o imagen)'), findsOneWidget);

    // Copiar el archivo es E/S real: se deja correr fuera del reloj falso.
    await tester.ensureVisible(find.byKey(const Key('document-add')));
    await tester.runAsync(() async {
      await tester.tap(find.byKey(const Key('document-add')));
      await Future<void>.delayed(const Duration(milliseconds: 300));
    });
    await tester.pumpAndSettle();
    expect(find.text('Contrato'), findsOneWidget);

    await tester.tap(find.text('Contrato'));
    await tester.pumpAndSettle();
    expect(opened.single, startsWith('application/pdf '));
    expect(opened.single, contains(project.id));

    await tester.tap(docMenu());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Renombrar'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('document-title')),
      'Contrato firmado',
    );
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();
    expect(find.text('Contrato firmado'), findsOneWidget);

    await tester.tap(docMenu());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Borrar').last);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Borrar'));
    await tester.pumpAndSettle();
    expect(find.text('Sin documentos (PDF o imagen)'), findsOneWidget);
  });
}
