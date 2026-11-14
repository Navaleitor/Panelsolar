import 'package:data_sources/geocoding.dart';
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

  /// Zonas por coordenadas que devuelve [timeZoneAt] (`"lat,lon"` → zona).
  /// Vacío = no deduce nada y se usa la del teléfono.
  final byCoordinates = <String, String>{};

  @override
  Future<String?> deviceTimeZone() async => 'America/Monterrey';

  @override
  Future<String?> timeZoneAt(double latitude, double longitude) async =>
      byCoordinates['$latitude,$longitude'];

  @override
  double? standardUtcOffsetHours(String name) => switch (name) {
    'America/Hermosillo' => -7,
    'America/Mexico_City' || 'America/Monterrey' => -6,
    _ => null,
  };

  @override
  List<String> allTimeZones() => zones;

  @override
  bool isValid(String name) => zones.contains(name);
}
