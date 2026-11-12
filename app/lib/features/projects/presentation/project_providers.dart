import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:persistence/persistence.dart';

/// Filtro de la lista de proyectos: estado (opcional) y texto.
typedef ProjectFilter = ({ProjectStatus? status, String query});

/// Proyectos activos con su cliente, filtrados.
final StreamProviderFamily<List<ProjectWithClient>, ProjectFilter>
projectListProvider = StreamProvider.autoDispose
    .family<List<ProjectWithClient>, ProjectFilter>(
      (ref, filter) => ref
          .watch(projectRepositoryProvider)
          .watchActive(status: filter.status, query: filter.query),
    );

/// Proyectos activos de un cliente.
final StreamProviderFamily<List<Project>, String> projectsByClientProvider =
    StreamProvider.autoDispose.family<List<Project>, String>(
      (ref, clientId) =>
          ref.watch(projectRepositoryProvider).watchByClient(clientId),
    );

/// Un proyecto por `id`.
final StreamProviderFamily<Project?, String> projectProvider = StreamProvider
    .autoDispose
    .family<Project?, String>(
      (ref, id) => ref.watch(projectRepositoryProvider).watchById(id),
    );
