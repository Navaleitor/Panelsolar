import 'package:persistence/persistence.dart';

/// Plantilla inicial de servicios de mantenimiento (plan A.2). El usuario
/// la puede editar en Mantenimiento → Plantilla. Frecuencias habituales
/// para sistemas residenciales/comerciales; ajustar según polvo, salinidad
/// o el fabricante.
const List<ServiceInput> defaultMaintenanceTemplate = [
  (kind: MaintenanceServiceKind.cleaning, title: null, intervalMonths: 6),
  (
    kind: MaintenanceServiceKind.visualInspection,
    title: null,
    intervalMonths: 6,
  ),
  (
    kind: MaintenanceServiceKind.connectionTightening,
    title: null,
    intervalMonths: 12,
  ),
  (kind: MaintenanceServiceKind.inverterCheck, title: null, intervalMonths: 12),
  (
    kind: MaintenanceServiceKind.protectionsCheck,
    title: null,
    intervalMonths: 12,
  ),
  (kind: MaintenanceServiceKind.thermography, title: null, intervalMonths: 24),
];

/// Servicios de la plantilla inicial que vienen desactivados (opcionales).
const Set<MaintenanceServiceKind> optionalByDefault = {
  MaintenanceServiceKind.thermography,
};
