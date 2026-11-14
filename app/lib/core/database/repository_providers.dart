import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/database/database_providers.dart';
import 'package:persistence/persistence.dart';

/// Repositorios de `packages/persistence`, uno por tabla.
final clientRepositoryProvider = Provider<ClientRepository>(
  (ref) => ClientRepository(ref.watch(appDatabaseProvider)),
);

final projectRepositoryProvider = Provider<ProjectRepository>(
  (ref) => ProjectRepository(ref.watch(appDatabaseProvider)),
);

final siteRepositoryProvider = Provider<SiteRepository>(
  (ref) => SiteRepository(ref.watch(appDatabaseProvider)),
);

final utilityBillRepositoryProvider = Provider<UtilityBillRepository>(
  (ref) => UtilityBillRepository(ref.watch(appDatabaseProvider)),
);

final photoRepositoryProvider = Provider<PhotoRepository>(
  (ref) => PhotoRepository(ref.watch(appDatabaseProvider)),
);

final documentRepositoryProvider = Provider<DocumentRepository>(
  (ref) => DocumentRepository(ref.watch(appDatabaseProvider)),
);

final roofImageRepositoryProvider = Provider<RoofImageRepository>(
  (ref) => RoofImageRepository(ref.watch(appDatabaseProvider)),
);

final roofPlaneRepositoryProvider = Provider<RoofPlaneRepository>(
  (ref) => RoofPlaneRepository(ref.watch(appDatabaseProvider)),
);

final obstacleRepositoryProvider = Provider<ObstacleRepository>(
  (ref) => ObstacleRepository(ref.watch(appDatabaseProvider)),
);

final horizonProfileRepositoryProvider = Provider<HorizonProfileRepository>(
  (ref) => HorizonProfileRepository(ref.watch(appDatabaseProvider)),
);
