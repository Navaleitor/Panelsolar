/// Geocodificación (dirección → coordenadas) detrás de la interfaz
/// intercambiable `Geocoder` (ADR-004). Biblioteca separada del resto de
/// `data_sources` para que F1 y F2 no se pisen.
library;

export 'src/geocoding/cached_geocoder.dart';
export 'src/geocoding/geocode_cache.dart';
export 'src/geocoding/geocoder.dart';
export 'src/geocoding/http_transport.dart';
export 'src/geocoding/nominatim_geocoder.dart';
export 'src/geocoding/rate_limiter.dart';
