import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Guarda [bytes] como [fileName] donde el usuario elija (Descargas,
/// Drive, USB...). `false` si cancela.
typedef BackupFileSaver = Future<bool> Function(
  String fileName,
  Uint8List bytes,
);

/// Pide al usuario un .zip de respaldo. `null` si cancela.
typedef BackupFilePicker = Future<File?> Function();

final backupFileSaverProvider = Provider<BackupFileSaver>(
  (ref) =>
      (name, bytes) async =>
          await FilePicker.saveFile(
            fileName: name,
            bytes: bytes,
            mimeType: 'application/zip',
          ) !=
          null,
);

final backupFilePickerProvider = Provider<BackupFilePicker>(
  (ref) => () async {
    final picked = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['zip'],
    );
    final path = picked?.path;
    return path == null ? null : File(path);
  },
);
