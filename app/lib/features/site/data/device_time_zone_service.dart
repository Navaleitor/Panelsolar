import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:panelsolar/features/site/domain/time_zone_service.dart';
import 'package:timezone/data/latest_10y.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// [TimeZoneService] con la zona del teléfono (`flutter_timezone`) y la
/// base IANA del paquete `timezone` (sin red).
class DeviceTimeZoneService implements TimeZoneService {
  new();

  List<String>? _all;

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
  List<String> allTimeZones() {
    final cached = _all;
    if (cached != null) return cached;
    tz_data.initializeTimeZones();
    return _all = tz.timeZoneDatabase.locations.keys.toList()..sort();
  }

  @override
  bool isValid(String name) => allTimeZones().contains(name);
}
