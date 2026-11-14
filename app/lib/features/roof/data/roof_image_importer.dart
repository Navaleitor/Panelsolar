import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/features/photos/data/photo_processor.dart';
import 'package:panelsolar/features/photos/domain/processed_photo.dart';
import 'package:path/path.dart' as p;
import 'package:persistence/persistence.dart';

/// Lado mayor de la imagen del techo guardada (px). Más que en las fotos
/// (1600 px) para trazar con precisión.
const int roofImageMaxSidePx = 2400;

/// Guarda la imagen del techo que importa el usuario (ADR-005): la
/// endereza, la reduce a [roofImageMaxSidePx], la guarda con el proyecto y
/// la registra. Una imagen nueva reemplaza a la anterior.
class RoofImageImporter {
  /// Crea el importador.
  const new({
    required this.storage,
    required this.repository,
    this.process = _processInBackground,
  });

  /// Archivos de la app.
  final AppStorage storage;

  /// Repositorio de la base del techo.
  final RoofImageRepository repository;

  /// Compresión (inyectable en pruebas).
  final Future<ProcessedPhoto> Function(Uint8List bytes) process;

  /// Importa [bytes]. Devuelve `false` si no es una imagen válida.
  Future<bool> import({
    required String projectId,
    required Uint8List bytes,
  }) async {
    final ProcessedPhoto image;
    try {
      image = await process(bytes);
    } on FormatException {
      return false;
    }
    final hash = sha256.convert(image.jpegBytes).toString();
    final relative = p.join(AppStorage.roofDir(projectId), '$hash.jpg');
    await storage.writeBytes(relative, image.jpegBytes);
    await repository.saveImage(
      projectId: projectId,
      filePath: relative,
      sha256: hash,
      widthPx: image.widthPx,
      heightPx: image.heightPx,
    );
    return true;
  }
}

Future<ProcessedPhoto> _processInBackground(Uint8List bytes) =>
    compute(_process, bytes);

ProcessedPhoto _process(Uint8List bytes) =>
    processPhoto(bytes, maxSide: roofImageMaxSidePx, quality: 90);
