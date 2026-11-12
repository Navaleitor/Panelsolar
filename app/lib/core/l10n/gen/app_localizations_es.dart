// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Panelsolar';

  @override
  String get navClients => 'Clientes';

  @override
  String get navProjects => 'Proyectos';

  @override
  String get navCatalog => 'Catálogo';

  @override
  String get navMaintenance => 'Mantenimiento';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get clientsDescription =>
      'Datos de contacto, recibos de luz y consumo de cada cliente.';

  @override
  String get projectsDescription =>
      'Sitio, techo, clima, diseño y reportes de cada instalación.';

  @override
  String get catalogDescription =>
      'Paneles, inversores, baterías y estructuras.';

  @override
  String get maintenanceDescription =>
      'Plan de servicios, recordatorios y bitácora de visitas.';

  @override
  String get settingsDescription =>
      'Perfil de empresa, idioma, unidades y respaldo.';

  @override
  String comingInPhase(String phase) {
    return 'Disponible en la fase $phase.';
  }

  @override
  String get settingsDatabaseTitle => 'Base de datos';

  @override
  String settingsDatabaseOk(int version) {
    return 'Funcionando · esquema v$version';
  }

  @override
  String get settingsDatabaseError => 'Error al abrir la base de datos';

  @override
  String get weatherTitle => 'Clima y producción';

  @override
  String get weatherEntryTitle => 'Clima y producción (prueba F2)';

  @override
  String get weatherEntrySubtitle =>
      'Descarga el clima de una coordenada y estima la producción.';

  @override
  String get weatherIntro =>
      'Producción estimada de un sistema de 1 kWp con la orientación óptima. Datos: NASA POWER (5 años) y PVGIS.';

  @override
  String get weatherLatitude => 'Latitud (°)';

  @override
  String get weatherLongitude => 'Longitud (°)';

  @override
  String get weatherInvalidCoordinate => 'Escriba un número válido';

  @override
  String get weatherAnalyze => 'Descargar clima y calcular';

  @override
  String get weatherRefresh => 'Volver a descargar';

  @override
  String get weatherLoading => 'Descargando clima y simulando…';

  @override
  String weatherError(String message) {
    return 'No se pudo obtener el clima: $message';
  }

  @override
  String weatherSource(String source) {
    return 'Serie: $source';
  }

  @override
  String get weatherAnnualTitle => 'Producción anual';

  @override
  String weatherAnnualValue(String value) {
    return '$value kWh por kWp al año';
  }

  @override
  String weatherPerformanceRatio(String value) {
    return 'Performance ratio: $value';
  }

  @override
  String get weatherMonthlyTitle => 'Producción mensual (kWh por kWp)';

  @override
  String get weatherOptimalTitle => 'Orientación óptima';

  @override
  String weatherOptimalValue(String tilt, String azimuth) {
    return 'Inclinación $tilt° · azimut $azimuth°';
  }

  @override
  String weatherLatitudeRule(String value, String diff) {
    return 'Con inclinación = latitud: $value kWh/kWp ($diff %)';
  }

  @override
  String get weatherTemperaturesTitle => 'Temperaturas del sitio';

  @override
  String weatherTemperaturesValue(String min, String max) {
    return 'Mínima registrada $min °C · máxima registrada $max °C';
  }

  @override
  String get weatherSunPathTitle => 'Trayectoria solar';

  @override
  String get weatherSunPathAxis => 'Azimut (°) vs. altura solar (°)';

  @override
  String get weatherJuneSolstice => 'Solsticio de junio';

  @override
  String get weatherEquinox => 'Equinoccios';

  @override
  String get weatherDecemberSolstice => 'Solsticio de diciembre';

  @override
  String get weatherWarningsTitle => 'Advertencias';

  @override
  String get weatherAttributionsTitle => 'Fuentes de datos';
}
