import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:persistence/persistence.dart';

/// Clientes activos que coinciden con el texto de búsqueda (vacío = todos).
final StreamProviderFamily<List<Client>, String> clientListProvider =
    StreamProvider.autoDispose.family<List<Client>, String>(
      (ref, query) =>
          ref.watch(clientRepositoryProvider).watchActive(query: query),
    );

/// Un cliente por `id` (`null` si no existe).
final StreamProviderFamily<Client?, String> clientProvider = StreamProvider
    .autoDispose
    .family<Client?, String>(
      (ref, id) => ref.watch(clientRepositoryProvider).watchById(id),
    );
