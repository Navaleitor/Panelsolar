import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/core/formatting/decimal_parser.dart';
import 'package:panelsolar/features/backup/domain/backup_file_name.dart';
import 'package:panelsolar/features/backup/domain/backup_manifest.dart';
import 'package:panelsolar/features/backup/domain/retention.dart';

void main() {
  test('retención: 7 diarias + 4 semanales', () {
    // Un respaldo diario durante 60 días (del 1 de sep. al 30 de oct.).
    final backups = [
      for (var i = 0; i < 60; i++)
        (id: '$i', createdAt: DateTime.utc(2026, 9, 1 + i, 3)),
    ];
    final delete = backupsToDelete(backups);
    final kept = {for (final b in backups) b.id}.difference(delete);
    // Últimos 7 días (53–59) + el domingo de 2 semanas anteriores (la
    // semana del 19 de oct. ya está cubierta por los diarios).
    expect(kept, {'40', '47', '53', '54', '55', '56', '57', '58', '59'});
  });

  test('retención: dos respaldos el mismo día conserva el más nuevo', () {
    final delete = backupsToDelete([
      (id: 'a', createdAt: DateTime.utc(2026, 11, 14, 8)),
      (id: 'b', createdAt: DateTime.utc(2026, 11, 14, 20)),
    ]);
    expect(delete, {'a'});
  });

  test('manifiesto ida y vuelta', () {
    final m = BackupManifest(
      createdAt: DateTime.utc(2026, 11, 14, 12),
      appVersion: '0.1.0',
      schemaVersion: 4,
      encrypted: true,
      filesIncluded: false,
      kdfSalt: 'c2FsdA==',
      kdfIterations: 1000,
      counts: const {'clients': 3},
      files: const [BackupFileEntry(path: 'a/b.jpg', sha256: 'h', size: 9)],
    );
    final back = BackupManifest.decode(m.encode());
    expect(back.toJson(), m.toJson());
    expect(
      () => BackupManifest.decode('{"format": 99}'),
      throwsFormatException,
    );
  });

  test('nombre del archivo y números con coma o punto', () {
    expect(
      backupFileName(DateTime(2026, 1, 5, 9, 7)),
      'panelsolar-respaldo-2026-01-05-0907.zip',
    );
    expect(parseDecimal('12,5'), 12.5);
    expect(parseDecimal(' 1,234.5 '), 1234.5);
    expect(parseDecimal(''), isNull);
    expect(parseDecimal('abc'), isNull);
    expect(decimalText(400), '400');
    expect(decimalText(9.8), '9.8');
  });
}
