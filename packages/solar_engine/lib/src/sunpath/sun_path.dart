import 'package:solar_engine/src/position/spa.dart';
import 'package:solar_engine/src/simulation/site.dart';

/// Punto de la trayectoria solar.
typedef SunPathPoint = ({double localHour, double azimuth, double elevation});

/// Días característicos para la carta solar.
enum SunPathDay {
  /// Solsticio de junio (~21 de junio).
  juneSolstice(6, 21),

  /// Equinoccio de marzo (~20 de marzo).
  marchEquinox(3, 20),

  /// Equinoccio de septiembre (~22 de septiembre).
  septemberEquinox(9, 22),

  /// Solsticio de diciembre (~21 de diciembre).
  decemberSolstice(12, 21);

  new(this.month, this.day);

  /// Mes.
  final int month;

  /// Día del mes.
  final int day;
}

/// Trayectoria del Sol (azimut y elevación aparente) a lo largo de un día,
/// para la gráfica de carta solar. Usa el NREL SPA.
abstract final class SunPath {
  /// Puntos del día [month]/[day] de [year] con el Sol sobre el horizonte,
  /// cada [stepMinutes] minutos de hora estándar local.
  static List<SunPathPoint> forDate(
    Site site,
    int year,
    int month,
    int day, {
    int stepMinutes = 10,
  }) {
    final offsetMinutes = (site.utcOffsetHours * 60).round();
    final midnightUtc = DateTime.utc(
      year,
      month,
      day,
    ).subtract(Duration(minutes: offsetMinutes));
    final points = <SunPathPoint>[];
    for (var m = 0; m <= 24 * 60; m += stepMinutes) {
      final pos = Spa.compute(
        timeUtc: midnightUtc.add(Duration(minutes: m)),
        latitude: site.latitude,
        longitude: site.longitude,
        elevation: site.elevation,
        pressureHpa: site.pressureHpa,
        temperatureC: site.meanTemperatureC,
      );
      if (pos.apparentElevation > 0) {
        points.add((
          localHour: m / 60,
          azimuth: pos.azimuth,
          elevation: pos.apparentElevation,
        ));
      }
    }
    return points;
  }

  /// Trayectorias de los cuatro días característicos de [year].
  static Map<SunPathDay, List<SunPathPoint>> characteristicDays(
    Site site,
    int year, {
    int stepMinutes = 10,
  }) => {
    for (final d in SunPathDay.values)
      d: forDate(site, year, d.month, d.day, stepMinutes: stepMinutes),
  };
}
