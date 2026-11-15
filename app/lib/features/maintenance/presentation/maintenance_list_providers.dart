import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:persistence/persistence.dart';

/// Servicios de la plantilla.
final StreamProvider<List<MaintenanceTemplateItem>> templateProvider =
    StreamProvider.autoDispose<List<MaintenanceTemplateItem>>(
      (ref) => ref.watch(maintenanceRepositoryProvider).watchTemplate(),
    );

/// Calendario de todos los proyectos.
final StreamProvider<List<UpcomingService>> upcomingProvider =
    StreamProvider.autoDispose<List<UpcomingService>>(
      (ref) => ref.watch(maintenanceRepositoryProvider).watchUpcoming(),
    );

/// Plan del proyecto.
final StreamProviderFamily<List<MaintenancePlanItem>, String> planProvider =
    StreamProvider.autoDispose.family<List<MaintenancePlanItem>, String>(
      (ref, projectId) =>
          ref.watch(maintenanceRepositoryProvider).watchPlan(projectId),
    );

/// Bitácora del proyecto.
final StreamProviderFamily<List<MaintenanceVisit>, String> visitsProvider =
    StreamProvider.autoDispose.family<List<MaintenanceVisit>, String>(
      (ref, projectId) =>
          ref.watch(maintenanceVisitRepositoryProvider).watchVisits(projectId),
    );
