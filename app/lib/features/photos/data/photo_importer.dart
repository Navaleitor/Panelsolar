import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/features/photos/data/photo_processor.dart';
import 'package:panelsolar/features/photos/domain/processed_photo.dart';
import 'package:panelsolar/features/site/domain/location_service.dart';
import 'package:path/path.dart' as p;
import 'package:persistence/persistence.dart';

/// Resultado de importar una foto.
enum PhotoImportOutcome {
  /// Guardada.
  saved,

  /// Ya existía una idéntica en el proyecto (mismo hash): no se duplicó.
  duplicate,

  /// El archivo no era una imagen válida.
  invalid,
}

/// Convierte bytes de cámara/galería en una foto del proyecto:
/// comprime, calcula SHA-256, guarda el archivo y lo registra.
class PhotoImporter {
  const new({
    required this.storage,
    required this.repository,
    required this.locationService,
    this.process = _processInBackground,
  });

  final AppStorage storage;
  final PhotoRepository repository;
  final LocationService locationService;

  /// Compresión (inyectable en pruebas).
  final Future<ProcessedPhoto> Function(Uint8List bytes) process;

  /// Importa [bytes] en la etapa [stage] de [projectId]. Si la foto no
  /// trae GPS y [fromCamera] es `true`, usa la última posición del
  /// teléfono (la foto se acaba de tomar ahí).
  Future<PhotoImportOutcome> import({
    required String projectId,
    required PhotoStage stage,
    required Uint8List bytes,
    required bool fromCamera,
  }) async {
    final ProcessedPhoto photo;
    try {
      photo = await process(bytes);
    } on FormatException {
      return PhotoImportOutcome.invalid;
    }
    final hash = sha256.convert(photo.jpegBytes).toString();
    if (await repository.existsHash(projectId, hash)) {
      return PhotoImportOutcome.duplicate;
    }
    var latitude = photo.latitude;
    var longitude = photo.longitude;
    if (latitude == null && fromCamera) {
      final last = await locationService.lastKnownPosition();
      latitude = last?.latitude;
      longitude = last?.longitude;
    }
    final relative = p.join(AppStorage.photosDir(projectId), '$hash.jpg');
    await storage.writeBytes(relative, photo.jpegBytes);
    await repository.add(
      projectId: projectId,
      stage: stage,
      filePath: relative,
      sha256: hash,
      widthPx: photo.widthPx,
      heightPx: photo.heightPx,
      latitude: latitude,
      longitude: longitude,
      takenAt: photo.takenAt ?? (fromCamera ? DateTime.now().toUtc() : null),
    );
    return PhotoImportOutcome.saved;
  }
}

Future<ProcessedPhoto> _processInBackground(Uint8List bytes) =>
    compute(_process, bytes);

ProcessedPhoto _process(Uint8List bytes) => processPhoto(bytes);
