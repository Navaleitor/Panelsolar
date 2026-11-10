import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:persistence/persistence.dart';

/// Documentos activos del proyecto.
final StreamProviderFamily<List<Document>, String> documentsProvider =
    StreamProvider.autoDispose.family<List<Document>, String>(
      (ref, projectId) =>
          ref.watch(documentRepositoryProvider).watchByProject(projectId),
    );
