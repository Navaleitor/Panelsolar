import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart' show TableInfo;
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:persistence/persistence.dart';

/// Llena una base con datos de todas las tablas de F1 y F6.
Future<void> seedEverything(AppDatabase db, AppStorage storage) async {
  final client = await ClientRepository(db)
      .create(name: 'Ana López', phone: '8112345678');
  final project = await ProjectRepository(db).create(
    clientId: client.id,
    name: 'Casa Cumbres',
    projectDate: DateTime.utc(2026, 11, 10),
  );
  await SiteRepository(db).save(
    projectId: project.id,
    latitude: 25.68,
    longitude: -100.31,
    source: LocationSource.gps,
  );
  final bytes = Uint8List.fromList(List<int>.generate(3000, (i) => i % 251));
  final hash = sha256.convert(bytes).toString();
  final path = 'projects/${project.id}/photos/$hash.jpg';
  await storage.writeBytes(path, bytes);
  await PhotoRepository(db).add(
    projectId: project.id,
    stage: PhotoStage.installation,
    filePath: path,
    sha256: hash,
    widthPx: 10,
    heightPx: 10,
  );
  await InstalledEquipmentRepository(db).create(project.id, (
    kind: EquipmentKind.inverter,
    brand: 'Fronius',
    model: 'Primo',
    serialNumber: 'SN-9',
    installedAt: null,
    warrantyUntil: DateTime.utc(2036),
    notes: null,
  ));
  await MaintenanceRepository(db).addPlanItem(project.id, (
    kind: MaintenanceServiceKind.cleaning,
    title: null,
    intervalMonths: 6,
  ), nextDueAt: DateTime.utc(2027, 5, 10));
  await ProductionRepository(db).saveReading(
    projectId: project.id,
    month: DateTime.utc(2026, 10),
    actualKwh: 610,
    expectedKwh: 700,
  );
  await AppSettingsRepository(db).set('device.only', 'yes');
}

/// Contenido de todas las tablas que se respaldan (para comparar).
Future<Map<String, List<Map<String, Object?>>>> dump(AppDatabase db) async {
  final result = <String, List<Map<String, Object?>>>{};
  for (final TableInfo<dynamic, dynamic> t in db.allTables) {
    final name = t.actualTableName;
    if (name == 'backup_logs' || name == 'app_settings') continue;
    final rows = await db
        .customSelect('SELECT * FROM "$name" ORDER BY id')
        .get();
    result[name] = [for (final r in rows) r.data];
  }
  return result;
}
