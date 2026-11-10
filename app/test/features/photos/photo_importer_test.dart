import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/features/photos/data/photo_importer.dart';
import 'package:panelsolar/features/photos/data/photo_processor.dart';
import 'package:panelsolar/features/site/domain/location_candidate.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';
import 'photo_processor_test.dart' show makeJpeg;

void main() {
  late AppDatabase db;
  late Directory dir;
  late Project project;
  late FakeLocationService location;
  late PhotoImporter importer;

  setUp(() async {
    db = newTestDatabase();
    dir = Directory.systemTemp.createTempSync('photos');
    final client = await ClientRepository(db).create(name: 'Ana');
    project = await ProjectRepository(db).create(
      clientId: client.id,
      name: 'Casa',
      projectDate: DateTime.utc(2026),
    );
    location = FakeLocationService();
    importer = PhotoImporter(
      storage: AppStorage(dir),
      repository: PhotoRepository(db),
      locationService: location,
      process: (bytes) async => processPhoto(bytes),
    );
  });

  tearDown(() async {
    await db.close();
    dir.deleteSync(recursive: true);
  });

  test('guarda archivo comprimido con hash y registra la foto', () async {
    final outcome = await importer.import(
      projectId: project.id,
      stage: PhotoStage.survey,
      bytes: makeJpeg(3200, 2400, gps: (25.5, -100.25)),
      fromCamera: false,
    );
    expect(outcome, PhotoImportOutcome.saved);

    final photo = (await PhotoRepository(
      db,
    ).watchByProject(project.id).first).single;
    expect(photo.sha256, matches(RegExp(r'^[0-9a-f]{64}$')));
    expect(photo.filePath, 'projects/${project.id}/photos/${photo.sha256}.jpg');
    expect(File('${dir.path}/${photo.filePath}').existsSync(), isTrue);
    expect((photo.widthPx, photo.heightPx), (1600, 1200));
    expect(photo.latitude, closeTo(25.5, 1e-6));
    expect(photo.stage, PhotoStage.survey);
  });

  test('la misma foto dos veces no se duplica', () async {
    final bytes = makeJpeg(100, 100);
    await importer.import(
      projectId: project.id,
      stage: PhotoStage.installation,
      bytes: bytes,
      fromCamera: false,
    );
    final second = await importer.import(
      projectId: project.id,
      stage: PhotoStage.installation,
      bytes: bytes,
      fromCamera: false,
    );
    expect(second, PhotoImportOutcome.duplicate);
    expect(
      await PhotoRepository(db).watchByProject(project.id).first,
      hasLength(1),
    );
  });

  test('con cámara y sin GPS en EXIF usa la última posición', () async {
    location.lastKnown = const LocationCandidate(
      latitude: 19.43,
      longitude: -99.13,
      source: LocationSource.gps,
    );
    await importer.import(
      projectId: project.id,
      stage: PhotoStage.maintenance,
      bytes: makeJpeg(100, 100),
      fromCamera: true,
    );
    final photo = (await PhotoRepository(
      db,
    ).watchByProject(project.id).first).single;
    expect(photo.latitude, 19.43);
    expect(photo.takenAt, isNotNull);
  });

  test('desde galería sin GPS queda sin ubicación', () async {
    location.lastKnown = FakeLocationService.monterrey;
    await importer.import(
      projectId: project.id,
      stage: PhotoStage.survey,
      bytes: makeJpeg(100, 100),
      fromCamera: false,
    );
    final photo = (await PhotoRepository(
      db,
    ).watchByProject(project.id).first).single;
    expect(photo.latitude, isNull);
  });

  test('archivo inválido no se guarda', () async {
    final outcome = await importer.import(
      projectId: project.id,
      stage: PhotoStage.survey,
      bytes: File('pubspec.yaml').readAsBytesSync(),
      fromCamera: false,
    );
    expect(outcome, PhotoImportOutcome.invalid);
  });
}
