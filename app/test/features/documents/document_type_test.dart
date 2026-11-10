import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/documents/domain/document_type.dart';
import 'package:persistence/persistence.dart';

Uint8List bytes(List<int> b) => Uint8List.fromList([...b, 0, 0, 0, 0, 0, 0]);

void main() {
  test('reconoce PDF e imágenes por su firma', () {
    final pdf = detectDocumentType('x.bin', bytes('%PDF-1.7'.codeUnits))!;
    expect(pdf.kind, DocumentKind.pdf);
    expect(pdf.mimeType, 'application/pdf');

    expect(
      detectDocumentType('a.jpeg', bytes([0xFF, 0xD8, 0xFF, 0xE0]))!.extension,
      'jpg',
    );
    expect(
      detectDocumentType('a', bytes([0x89, 0x50, 0x4E, 0x47]))!.mimeType,
      'image/png',
    );
    final webp = bytes([...'RIFF'.codeUnits, 0, 0, 0, 0, ...'WEBP'.codeUnits]);
    expect(detectDocumentType('a.webp', webp)!.kind, DocumentKind.image);
  });

  test('rechaza otros tipos aunque digan .pdf', () {
    expect(detectDocumentType('virus.pdf', bytes('MZ..'.codeUnits)), isNull);
    expect(detectDocumentType('nota.txt', bytes('hola'.codeUnits)), isNull);
  });

  test('título por defecto sin extensión ni carpeta', () {
    expect(defaultDocumentTitle('Contrato firmado.pdf'), 'Contrato firmado');
    expect(defaultDocumentTitle('/tmp/x/recibo.jpg'), 'recibo');
    expect(defaultDocumentTitle('.pdf'), '.pdf');
    expect(defaultDocumentTitle(''), 'Documento');
  });
}
