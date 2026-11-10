import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/features/documents/data/document_importer.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/pump_app.dart';

void main() {
  late AppDatabase db;
  late Directory dir;
  late Project project;
  late DocumentImporter importer;

  setUp(() async {
    db = newTestDatabase();
    dir = Directory.systemTemp.createTempSync('docs');
    final client = await ClientRepository(db).create(name: 'Ana');
    project = await ProjectRepository(db).create(
      clientId: client.id,
      name: 'Casa',
      projectDate: DateTime.utc(2026),
    );
    importer = DocumentImporter(
      storage: AppStorage(dir),
      repository: DocumentRepository(db),
    );
  });

  tearDown(() async {
    await db.close();
    dir.deleteSync(recursive: true);
  });

  test('copia el PDF y lo registra con título, tamaño y hash', () async {
    final bytes = Uint8List.fromList('%PDF-1.7 contenido'.codeUnits);
    final doc = await importer.import(
      projectId: project.id,
      fileName: 'Contrato CFE.pdf',
      bytes: bytes,
    );
    expect(doc!.title, 'Contrato CFE');
    expect(doc.kind, DocumentKind.pdf);
    expect(doc.sizeBytes, bytes.length);
    expect(doc.filePath, endsWith('${doc.sha256}.pdf'));
    expect(File('${dir.path}/${doc.filePath}').readAsBytesSync(), bytes);
  });

  test('rechaza tipos no soportados', () async {
    final doc = await importer.import(
      projectId: project.id,
      fileName: 'nota.txt',
      bytes: Uint8List.fromList('hola mundo'.codeUnits),
    );
    expect(doc, isNull);
    expect(
      await DocumentRepository(db).watchByProject(project.id).first,
      isEmpty,
    );
  });
}
