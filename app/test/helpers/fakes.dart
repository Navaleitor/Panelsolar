import 'dart:io';
import 'dart:typed_data';

import 'package:data_sources/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:panelsolar/features/backup/data/backup_schedule.dart';
import 'package:panelsolar/features/backup/data/backup_settings.dart';
import 'package:panelsolar/features/backup/data/drive/drive_auth.dart';
import 'package:panelsolar/features/backup/data/drive/remote_store.dart';
import 'package:panelsolar/features/backup/data/secret_store.dart';
import 'package:panelsolar/features/maintenance/data/reminder_scheduler.dart';
import 'package:panelsolar/features/maintenance/domain/reminder.dart';
import 'package:panelsolar/features/site/domain/location_candidate.dart';
import 'package:panelsolar/features/site/domain/location_service.dart';
import 'package:panelsolar/features/site/domain/time_zone_service.dart';
import 'package:persistence/persistence.dart';

/// GPS falso: devuelve [candidate] o lanza [failure].
class FakeLocationService implements LocationService {
  new({this.candidate, this.failure, this.lastKnown});

  LocationCandidate? candidate;
  LocationFailure? failure;
  LocationCandidate? lastKnown;

  static const monterrey = LocationCandidate(
    latitude: 25.686614,
    longitude: -100.316113,
    source: LocationSource.gps,
    altitudeM: 540,
    accuracyM: 6,
  );

  @override
  Future<LocationCandidate> currentPosition() async {
    if (failure case final f?) throw LocationException(f);
    return candidate ?? monterrey;
  }

  @override
  Future<LocationCandidate?> lastKnownPosition() async => lastKnown;
}

/// Geocodificador falso: siempre responde [results] y cuenta búsquedas.
class FakeGeocoder implements Geocoder {
  new({this.results = const [], this.error});

  List<GeocodeResult> results;
  GeocodingException? error;
  final queries = <String>[];

  @override
  String get attribution => '© OpenStreetMap contributors (ODbL)';

  @override
  Future<List<GeocodeResult>> search(
    String query, {
    String? languageCode,
    int limit = 5,
  }) async {
    queries.add(query);
    if (error case final e?) throw e;
    return results;
  }
}

/// Zonas horarias falsas (sin canal nativo).
class FakeTimeZoneService implements TimeZoneService {
  static const zones = [
    'America/Hermosillo',
    'America/Mexico_City',
    'America/Monterrey',
  ];

  @override
  Future<String?> deviceTimeZone() async => 'America/Monterrey';

  @override
  List<String> allTimeZones() => zones;

  @override
  bool isValid(String name) => zones.contains(name);
}

/// Notificaciones falsas: guarda lo último programado.
class FakeReminderScheduler implements ReminderScheduler {
  List<Reminder> scheduled = const [];
  int permissionRequests = 0;

  @override
  Future<bool> requestPermission() async {
    permissionRequests++;
    return true;
  }

  @override
  Future<void> replaceAll(List<Reminder> reminders) async {
    scheduled = reminders;
  }
}

/// Google falso: inicia sesión al instante con [email].
class FakeDriveAuth implements DriveAuth {
  new({this.configured = true, this.email = 'instalador@example.com'});

  bool configured;
  String email;
  bool signedIn = false;

  @override
  bool get isConfigured => configured;

  @override
  Future<String> signIn() async {
    signedIn = true;
    return email;
  }

  @override
  Future<http.Client?> silentClient() async => signedIn ? _NoHttp() : null;

  @override
  Future<http.Client> interactiveClient() async {
    signedIn = true;
    return _NoHttp();
  }

  @override
  Future<void> signOut() async => signedIn = false;
}

class _NoHttp extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      throw UnsupportedError('sin red en pruebas');
}

/// Contraseña de Drive en memoria.
class FakeSecretStore implements SecretStore {
  String? password;

  @override
  Future<String?> drivePassword() async => password;

  @override
  Future<void> setDrivePassword(String? value) async => password = value;
}

/// Programación falsa: recuerda la última frecuencia.
class FakeBackupSchedule implements BackupSchedule {
  BackupFrequency? applied;

  @override
  Future<void> apply(BackupFrequency frequency) async => applied = frequency;
}

/// "Google Drive" en memoria.
class MemoryRemoteStore implements RemoteStore {
  final files =
      <String, ({String name, DateTime createdAt, Uint8List bytes})>{};
  var _next = 0;
  DateTime Function() clock = DateTime.now;

  @override
  Future<List<RemoteFile>> list() async => [
    for (final e in files.entries)
      (
        id: e.key,
        name: e.value.name,
        createdAt: e.value.createdAt,
        size: e.value.bytes.length,
      ),
  ];

  @override
  Future<void> upload(String name, File file) async =>
      await uploadBytes(name, await file.readAsBytes());

  @override
  Future<void> uploadBytes(String name, Uint8List bytes) async {
    files['id${_next++}'] = (
      name: name,
      createdAt: clock().toUtc(),
      bytes: bytes,
    );
  }

  @override
  Future<Uint8List> download(String id) async => files[id]!.bytes;

  @override
  Future<void> delete(String id) async => files.remove(id);
}
