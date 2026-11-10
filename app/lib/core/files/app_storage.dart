import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

/// Carpeta de archivos de la app (fotos, documentos, cachés).
///
/// En la base se guardan rutas **relativas** a [root] para que sigan
/// valiendo tras restaurar un respaldo en otro teléfono.
class AppStorage {
  /// Usa [root] como raíz.
  const new(this.root);

  /// Carpeta raíz (documentos de la app en el teléfono, temporal en pruebas).
  final Directory root;

  /// Archivo absoluto de una ruta relativa.
  File file(String relativePath) => File(p.join(root.path, relativePath));

  /// Escribe [bytes] en [relativePath] (crea carpetas) y devuelve el archivo.
  Future<File> writeBytes(String relativePath, Uint8List bytes) async {
    final target = file(relativePath);
    await target.parent.create(recursive: true);
    return await target.writeAsBytes(bytes, flush: true);
  }

  /// Carpeta relativa de las fotos de un proyecto.
  static String photosDir(String projectId) =>
      p.join('projects', projectId, 'photos');

  /// Carpeta relativa de los documentos de un proyecto.
  static String documentsDir(String projectId) =>
      p.join('projects', projectId, 'documents');
}

/// Raíz de archivos. Se sustituye en `main.dart` (documentos de la app) y
/// en las pruebas (carpeta temporal).
final appStorageProvider = Provider<AppStorage>(
  (ref) => throw UnimplementedError('appStorageProvider sin configurar'),
);
