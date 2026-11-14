import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/features/roof/data/roof_mappers.dart';
import 'package:panelsolar/features/roof/domain/roof_codec.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:panelsolar/features/roof/domain/roof_space.dart';
import 'package:persistence/persistence.dart';

/// El techo completo de un proyecto, ya convertido a modelos del dominio.
typedef RoofLayout = ({
  RoofImage? record,
  RoofSpace space,
  List<RoofPlaneModel> planes,
  List<ObstacleModel> obstacles,
  List<HorizonPoint> terrain,
  List<FarObstacle> far,
});

/// Base del techo (imagen/croquis) del proyecto.
final StreamProviderFamily<RoofImage?, String> roofImageProvider =
    StreamProvider.autoDispose.family<RoofImage?, String>(
      (ref, id) => ref.watch(roofImageRepositoryProvider).watchForProject(id),
    );

/// Planos del proyecto.
final StreamProviderFamily<List<RoofPlaneModel>, String> roofPlanesProvider =
    StreamProvider.autoDispose.family<List<RoofPlaneModel>, String>(
      (ref, id) => ref
          .watch(roofPlaneRepositoryProvider)
          .watchByProject(id)
          .map((rows) => rows.map(RoofMappers.plane).toList()),
    );

/// Obstáculos del proyecto.
final StreamProviderFamily<List<ObstacleModel>, String> obstaclesProvider =
    StreamProvider.autoDispose.family<List<ObstacleModel>, String>(
      (ref, id) => ref
          .watch(obstacleRepositoryProvider)
          .watchByProject(id)
          .map((rows) => rows.map(RoofMappers.obstacle).toList()),
    );

/// Perfiles de horizonte del proyecto (terreno y obstáculos lejanos).
final StreamProviderFamily<List<HorizonProfileRecord>, String>
horizonRecordsProvider = StreamProvider.autoDispose
    .family<List<HorizonProfileRecord>, String>(
      (ref, id) =>
          ref.watch(horizonProfileRepositoryProvider).watchByProject(id),
    );

/// El techo completo. Carga mientras alguna parte carga.
final ProviderFamily<AsyncValue<RoofLayout>, String> roofLayoutProvider =
    Provider.autoDispose.family<AsyncValue<RoofLayout>, String>((ref, id) {
      final image = ref.watch(roofImageProvider(id));
      final planes = ref.watch(roofPlanesProvider(id));
      final obstacles = ref.watch(obstaclesProvider(id));
      final horizon = ref.watch(horizonRecordsProvider(id));
      for (final v in [image, planes, obstacles, horizon]) {
        if (v.hasError) return AsyncError(v.error!, v.stackTrace!);
      }
      if (!image.hasValue ||
          !planes.hasValue ||
          !obstacles.hasValue ||
          !horizon.hasValue) {
        return const AsyncLoading();
      }
      final records = horizon.requireValue;
      final terrain = records
          .where((r) => r.source == HorizonSource.terrain)
          .map((r) => RoofCodec.decodeHorizon(r.points))
          .firstOrNull;
      return AsyncData((
        record: image.requireValue,
        space: RoofSpace.fromRecord(image.requireValue),
        planes: planes.requireValue,
        obstacles: obstacles.requireValue,
        terrain: terrain ?? const [],
        far: [
          for (final r in records)
            if (r.source == HorizonSource.manual) RoofMappers.far(r),
        ],
      ));
    });
