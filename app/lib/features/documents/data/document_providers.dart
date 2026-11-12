import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/features/documents/data/document_importer.dart';
import 'package:panelsolar/features/documents/domain/document_type.dart';

/// Archivo elegido por el usuario.
typedef PickedFile = ({String name, Uint8List bytes});

/// Abre el selector de archivos del sistema (PDF o imagen). `null` si el
/// usuario cancela.
typedef DocumentPicker = Future<PickedFile?> Function();

/// Abre un archivo local con la app del teléfono (visor de PDF, galería).
/// Devuelve `false` si no hay app para abrirlo.
typedef FileOpener = Future<bool> Function(String absolutePath, String mime);

final documentImporterProvider = Provider<DocumentImporter>(
  (ref) => DocumentImporter(
    storage: ref.watch(appStorageProvider),
    repository: ref.watch(documentRepositoryProvider),
  ),
);

final documentPickerProvider = Provider<DocumentPicker>(
  (ref) => () async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: acceptedDocumentExtensions,
    );
    if (file == null) return null;
    return (name: file.name, bytes: await file.xFile.readAsBytes());
  },
);

final fileOpenerProvider = Provider<FileOpener>(
  (ref) => (path, mime) async {
    final result = await OpenFilex.open(path, type: mime);
    return result.type == ResultType.done;
  },
);
