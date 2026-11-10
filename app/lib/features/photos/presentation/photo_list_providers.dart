import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:persistence/persistence.dart';

/// Fotos activas del proyecto en una etapa (o todas si `stage` es nulo).
final StreamProviderFamily<List<Photo>, ({String projectId, PhotoStage? stage})>
photosProvider = StreamProvider.autoDispose
    .family<List<Photo>, ({String projectId, PhotoStage? stage})>(
      (ref, arg) => ref
          .watch(photoRepositoryProvider)
          .watchByProject(arg.projectId, stage: arg.stage),
    );
