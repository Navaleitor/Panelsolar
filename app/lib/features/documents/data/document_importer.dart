import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/features/documents/domain/document_type.dart';
import 'package:path/path.dart' as p;
import 'package:persistence/persistence.dart';

/// Copia un archivo elegido por el usuario al almacenamiento de la app y
/// lo registra como documento del proyecto. Devuelve el documento o
/// `null` si el tipo no es PDF ni imagen.
class DocumentImporter {
  const new({required this.storage, required this.repository});

  final AppStorage storage;
  final DocumentRepository repository;

  Future<Document?> import({
    required String projectId,
    required String fileName,
    required Uint8List bytes,
  }) async {
    final type = detectDocumentType(fileName, bytes);
    if (type == null) return null;
    final hash = sha256.convert(bytes).toString();
    final relative = p.join(
      AppStorage.documentsDir(projectId),
      '$hash.${type.extension}',
    );
    await storage.writeBytes(relative, bytes);
    return await repository.add(
      projectId: projectId,
      title: defaultDocumentTitle(fileName),
      kind: type.kind,
      filePath: relative,
      mimeType: type.mimeType,
      sizeBytes: bytes.length,
      sha256: hash,
    );
  }
}
