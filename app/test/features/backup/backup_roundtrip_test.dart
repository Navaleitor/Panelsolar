import 'dart:io';

import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/features/backup/data/backup_archive.dart';
import 'package:panelsolar/features/backup/data/backup_crypto.dart';
import 'package:persistence/persistence.dart';

import '../../helpers/backup_seed.dart';

AppDatabase newTestDatabase() => AppDatabase(
  DatabaseConnection(NativeDatabase.memory(), closeStreamsSynchronously: true),
);

void main() {
  late Directory tmp;
  setUp(() => tmp = Directory.systemTemp.createTempSync('backup_test'));
  tearDown(() => tmp.deleteSync(recursive: true));

  for (final password in [null, 'clave secreta']) {
    test('respaldar → borrar → restaurar = mismos datos '
        '(${password == null ? 'sin' : 'con'} contraseña)', () async {
      final storageA = AppStorage(Directory('${tmp.path}/a')..createSync());
      final dbA = newTestDatabase();
      await seedEverything(dbA, storageA);
      final before = await dump(dbA);

      final archive = BackupArchive(
        db: dbA,
        storage: storageA,
        appVersion: 'test',
        workDir: Directory('${tmp.path}/work'),
      );
      final zip = File('${tmp.path}/respaldo.zip');
      BackupEncryption? enc;
      if (password != null) {
        final salt = BackupCipher.newSalt();
        enc = (
          cipher: await BackupCipher.derive(password, salt, iterations: 1000),
          salt: salt,
          iterations: 1000,
        );
      }
      final manifest = await archive.write(zip, encryption: enc);
      expect(manifest.counts['clients'], 1);
      expect(manifest.files, hasLength(1));
      await dbA.close();

      // "Teléfono nuevo": base vacía (con un ajuste propio) y sin archivos.
      final storageB = AppStorage(Directory('${tmp.path}/b')..createSync());
      final dbB = newTestDatabase();
      await AppSettingsRepository(dbB).set('device.only', 'B');
      final preview = BackupArchive.readManifest(zip);
      expect(preview.encrypted, password != null);
      expect(preview.counts['projects'], 1);

      final restorer = BackupArchive(
        db: dbB,
        storage: storageB,
        appVersion: 'test',
        workDir: Directory('${tmp.path}/work'),
      );
      if (password != null) {
        await expectLater(
          restorer.restore(zip, password: 'otra'),
          throwsA(isA<WrongPasswordException>()),
        );
      }
      final result = await restorer.restore(zip, password: password);
      expect(result.filesRestored, 1);
      expect(result.filesMissing, 0);
      expect(await dump(dbB), before);
      expect(await AppSettingsRepository(dbB).get('device.only'), 'B');
      final photo = (await dbB.select(dbB.photos).get()).single;
      expect(storageB.file(photo.filePath).existsSync(), isTrue);
      await dbB.close();
    });
  }

  test('rechaza un .zip que no es respaldo', () async {
    final f = File('${tmp.path}/x.zip')..writeAsStringSync('hola');
    expect(() => BackupArchive.readManifest(f), throwsFormatException);
  });
}
