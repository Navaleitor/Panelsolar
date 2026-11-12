import 'dart:typed_data';

import 'package:persistence/persistence.dart';

/// Tipo de archivo aceptado como documento.
class DocumentType {
  const new(this.kind, this.mimeType, this.extension);

  final DocumentKind kind;
  final String mimeType;

  /// Extensión sin punto (`pdf`, `jpg`...).
  final String extension;
}

/// Extensiones que ofrece el selector de archivos.
const List<String> acceptedDocumentExtensions = [
  'pdf',
  'jpg',
  'jpeg',
  'png',
  'webp',
];

/// Detecta si [bytes] es un PDF o una imagen soportada, primero por su
/// firma (primeros bytes) y si no por la extensión de [fileName].
/// Devuelve `null` si no es un tipo aceptado.
DocumentType? detectDocumentType(String fileName, Uint8List bytes) {
  bool starts(List<int> sig, [int offset = 0]) {
    if (bytes.length < offset + sig.length) return false;
    for (var i = 0; i < sig.length; i++) {
      if (bytes[offset + i] != sig[i]) return false;
    }
    return true;
  }

  if (starts('%PDF'.codeUnits)) {
    return const DocumentType(DocumentKind.pdf, 'application/pdf', 'pdf');
  }
  if (starts([0xFF, 0xD8, 0xFF])) {
    return const DocumentType(DocumentKind.image, 'image/jpeg', 'jpg');
  }
  if (starts([0x89, 0x50, 0x4E, 0x47])) {
    return const DocumentType(DocumentKind.image, 'image/png', 'png');
  }
  if (starts('RIFF'.codeUnits) && starts('WEBP'.codeUnits, 8)) {
    return const DocumentType(DocumentKind.image, 'image/webp', 'webp');
  }
  // Sin firma reconocida: no se confía solo en la extensión, salvo que
  // el archivo esté vacío de cabecera (muy corto) y diga ser PDF.
  final ext = fileName.split('.').last.toLowerCase();
  if (bytes.length < 4 && ext == 'pdf') {
    return const DocumentType(DocumentKind.pdf, 'application/pdf', 'pdf');
  }
  return null;
}

/// Título por defecto: el nombre del archivo sin extensión.
String defaultDocumentTitle(String fileName) {
  final base = fileName.split(RegExp(r'[/\\]')).last;
  final dot = base.lastIndexOf('.');
  final title = (dot > 0 ? base.substring(0, dot) : base).trim();
  return title.isEmpty ? 'Documento' : title;
}
