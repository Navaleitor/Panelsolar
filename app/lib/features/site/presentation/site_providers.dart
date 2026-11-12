import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:persistence/persistence.dart';

/// Ubicación guardada del proyecto (`null` si aún no tiene).
final StreamProviderFamily<Site?, String> siteProvider = StreamProvider
    .autoDispose
    .family<Site?, String>(
      (ref, projectId) =>
          ref.watch(siteRepositoryProvider).watchForProject(projectId),
    );
