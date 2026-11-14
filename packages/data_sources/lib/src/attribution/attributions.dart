import 'package:data_sources/src/weather/weather_dataset.dart';

/// Textos de atribución obligatorios de las fuentes (ver
/// docs/fuentes-de-datos.md). Se muestran en pantalla y en los reportes.
abstract final class Attributions {
  /// "POWER's Reference" oficial (en inglés, tal cual lo pide NASA).
  static const String nasaPowerReference =
      'The data was obtained from National Aeronautics and Space '
      "Administration (NASA) Langley Research Center's Prediction Of "
      'Worldwide Energy Resources (POWER) project funded through the NASA '
      'Earth Science Division.';

  /// "POWER's Data Reference" con versión y fecha de descarga.
  static String nasaPowerDataReference(String version, DateTime accessedAt) {
    final d = accessedAt.toUtc();
    final date =
        '${d.year}/${d.month.toString().padLeft(2, '0')}/'
        '${d.day.toString().padLeft(2, '0')}';
    return "The data was obtained from the POWER Project's Hourly $version "
        'version on $date.';
  }

  /// Crédito de PVGIS (CC BY 4.0, con indicación de cambios).
  static String pvgis(DateTime accessedAt) =>
      'Datos: PVGIS © Unión Europea, 2001–${accessedAt.toUtc().year} '
      '(CC BY 4.0); procesados por Panelsolar.';

  /// Atribuciones de un conjunto de datos.
  static List<String> forDataset(WeatherDataset d) => switch (d.source) {
    WeatherSource.nasaPower => [
      nasaPowerReference,
      nasaPowerDataReference(d.version, d.accessedAt),
    ],
    WeatherSource.pvgisTmy => [pvgis(d.accessedAt)],
  };
}
