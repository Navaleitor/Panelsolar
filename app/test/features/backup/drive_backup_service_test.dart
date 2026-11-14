import 'dart:io';

import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/features/backup/data/backup_archive.dart';
import 'package:panelsolar/features/backup/data/backup_service.dart';
import 'package:panelsolar/features/backup/data/backup_settings.dart';
import 'package:panelsolar/features/backup/data/drive/drive_backup_service.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/backup_seed.dart';
import '../../helpers/fakes.dart';

AppDatabase memoryDb() => AppDatabase(
  DatabaseConnection(NativeDatabase.memory(), closeStreamsSynchronously: true),
);

void main() {
  late Directory tmp;
  setUp(() => tmp = Directory.systemTemp.createTempSync('drive_test'));
  tearDown(() => tmp.deleteSync(recursive: true));

  BackupService serviceFor(
    AppDatabase db,
    AppStorage storage,
    MemoryRemoteStore remote, {
    FakeSecretStore? secrets,
    FakeBackupSchedule? schedule,
  }) => BackupService(
    archive: BackupArchive(
      db: db,
      storage: storage,
      appVersion: 'test',
      workDir: Directory('${tmp.path}/work-${storage.root.path.hashCode}'),
    ),
    logs: BackupLogRepository(db),
    settings: AppSettingsRepository(db),
    auth: FakeDriveAuth(),
    secrets: secrets ?? FakeSecretStore(),
    schedule: schedule ?? FakeBackupSchedule(),
    remoteStore: (_) => remote,
    iterations: 1000,
  );

  for (final password in [null, 'clave-drive']) {
    test('Drive: incremental por hash y restaurar en otro teléfono '
        '(${password == null ? 'sin' : 'con'} cifrado)', () async {
      final remote = MemoryRemoteStore();
      final dbA = memoryDb();
      final storageA = AppStorage(Directory('${tmp.path}/a')..createSync());
      await seedEverything(dbA, storageA);
      final schedule = FakeBackupSchedule();
      final a = serviceFor(dbA, storageA, remote, schedule: schedule);

      // Apagado: no respalda.
      expect(await a.backupToDrive(trigger: BackupTrigger.manual), isNull);
      await a.connectDrive();
      expect(schedule.applied, BackupFrequency.daily);
      if (password != null) await a.setDrivePassword(password);

      final first = await a.backupToDrive(trigger: BackupTrigger.manual);
      expect(first!.uploadedFiles, 1);
      final second = await a.backupToDrive(trigger: BackupTrigger.daily);
      expect(second!.uploadedFiles, 0, reason: 'la foto ya estaba subida');
      final names = (await remote.list()).map((f) => f.name).toList();
      expect(names.where((n) => n.startsWith('blob-')), hasLength(1));
      expect(
        names.where((n) => n.startsWith('snapshot-')),
        hasLength(1),
        reason: 'mismo día: la retención deja solo el más nuevo',
      );
      final before = await dump(dbA);
      await dbA.close();

      // Teléfono nuevo: sin datos, inicia sesión y restaura.
      final dbB = memoryDb();
      final storageB = AppStorage(Directory('${tmp.path}/b')..createSync());
      final b = serviceFor(dbB, storageB, remote);
      final snapshots = await b.driveSnapshots();
      final zip = await b.downloadDriveSnapshot(snapshots.first);
      final manifest = BackupArchive.readManifest(zip);
      expect(manifest.filesIncluded, isFalse);
      expect(manifest.encrypted, password != null);
      final result = await b.restoreDrive(zip, password: password);
      expect(result.filesRestored, 1);
      expect(await dump(dbB), before);
      final logs = await BackupLogRepository(dbB).watchRecent().first;
      expect(logs.first.trigger, BackupTrigger.restore);
      await dbB.close();
    });
  }

  test('nombres de blobs: cambia con la sal (contraseña nueva)', () {
    expect(DriveBackupService.blobName('abc'), 'blob-abc');
    expect(
      DriveBackupService.blobName('abc', salt: 'Zm9vYmFyYmF6'),
      'blob-abc-Zm9vYmFy.enc',
    );
  });
}
