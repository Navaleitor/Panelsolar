import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/features/photos/data/photo_importer.dart';
import 'package:panelsolar/features/site/data/site_data_providers.dart';

/// Importador de fotos (compresión + hash + archivo + registro).
final photoImporterProvider = Provider<PhotoImporter>(
  (ref) => PhotoImporter(
    storage: ref.watch(appStorageProvider),
    repository: ref.watch(photoRepositoryProvider),
    locationService: ref.watch(locationServiceProvider),
  ),
);

/// Selector de cámara/galería del sistema.
final imagePickerProvider = Provider<ImagePicker>((ref) => ImagePicker());
