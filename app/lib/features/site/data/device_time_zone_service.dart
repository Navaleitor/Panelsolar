import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/site/domain/time_zone_service.dart';
import 'package:timezone/data/latest_10y.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// [TimeZoneService] con la zona del teléfono (`flutter_timezone`), la base
/// IANA del paquete `timezone` y la zona deducida de las coordenadas con
/// `geo_kit` (límites de zonas empaquetados en la app). Todo sin red.
class DeviceTimeZoneService implements TimeZoneService {
  /// [loadLocator] permite sustituir la carga del índice en pruebas.
  new({Future<TimeZoneLocator> Function()? loadLocator})
    : _loadLocator = loadLocator ?? _loadFromAssets;

  final Future<TimeZoneLocator> Function() _loadLocator;
  Future<TimeZoneLocator>? _locator;
  List<String>? _all;

  static Future<TimeZoneLocator> _loadFromAssets() async {
    final data = await rootBundle.load(TimeZoneLocator.flutterAssetKey);
    return TimeZoneLocator.fromGzip(data.buffer.asUint8List());
  }

  @override
  Future<String?> deviceTimeZone() async {
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      return isValid(info.identifier) ? info.identifier : null;
    } on Object {
      return null;
    }
  }

  @override
  Future<String?> timeZoneAt(double latitude, double longitude) async {
    try {
      final zone = (await (_locator ??= _loadLocator())).zoneAt(
        latitude,
        longitude,
      );
      return isValid(zone) ? zone : null;
    } on Object {
      _locator = null;
      return null;
    }
  }

  @override
  double? standardUtcOffsetHours(String name) {
    if (!isValid(name)) return null;
    return standardOffsetHours(tz.getLocation(name));
  }

  /// Desfase estándar: el de enero o julio que no es horario de verano.
  static double standardOffsetHours(tz.Location location) {
    final year = DateTime.now().year;
    for (final month in [1, 7]) {
      final t = DateTime.utc(year, month, 15).millisecondsSinceEpoch;
      final zone = location.timeZone(t);
      if (!zone.isDst) return zone.offset.inSeconds / 3600;
    }
    final january = DateTime.utc(year).millisecondsSinceEpoch;
    return location.timeZone(january).offset.inSeconds / 3600;
  }

  @override
  List<String> allTimeZones() {
    final cached = _all;
    if (cached != null) return cached;
    tz_data.initializeTimeZones();
    return _all = tz.timeZoneDatabase.locations.keys.toList()..sort();
  }

  @override
  bool isValid(String name) => allTimeZones().contains(name);
}
