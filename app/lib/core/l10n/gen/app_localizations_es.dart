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
}
