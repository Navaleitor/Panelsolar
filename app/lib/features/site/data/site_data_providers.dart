import 'package:data_sources/geocoding.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/core/app_info.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/features/site/data/device_time_zone_service.dart';
import 'package:panelsolar/features/site/data/geolocator_location_service.dart';
import 'package:panelsolar/features/site/data/http_redirect_fetcher.dart';
import 'package:panelsolar/features/site/domain/location_service.dart';
import 'package:panelsolar/features/site/domain/time_zone_service.dart';

/// GPS del teléfono.
final locationServiceProvider = Provider<LocationService>(
  (ref) => const GeolocatorLocationService(),
);

/// Geocodificador: Nominatim con caché persistente (ADR-004). Una sola
/// instancia en la app para respetar 1 petición/s.
final geocoderProvider = Provider<Geocoder>((ref) {
  final storage = ref.watch(appStorageProvider);
  return CachedGeocoder(
    NominatimGeocoder(userAgent: AppInfo.userAgent),
    JsonFileGeocodeCache(storage.file('cache/geocoding.json')),
  );
});

/// Lector de enlaces de mapas que expande enlaces cortos por HTTP.
final mapLinkResolverProvider = Provider<MapLinkResolver>(
  (ref) => const MapLinkResolver(fetchRedirect),
);

/// Zonas horarias.
final timeZoneServiceProvider = Provider<TimeZoneService>(
  (ref) => DeviceTimeZoneService(),
);
