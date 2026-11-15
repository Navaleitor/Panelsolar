import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:persistence/persistence.dart';

/// Equipos instalados del proyecto.
final StreamProviderFamily<List<InstalledEquipmentItem>, String>
equipmentProvider = StreamProvider.autoDispose
    .family<List<InstalledEquipmentItem>, String>(
      (ref, projectId) => ref
          .watch(installedEquipmentRepositoryProvider)
          .watchByProject(projectId),
    );

/// Checklist de puesta en marcha del proyecto (o `null`).
final StreamProviderFamily<CommissioningRecord?, String> commissioningProvider =
    StreamProvider.autoDispose.family<CommissioningRecord?, String>(
      (ref, projectId) =>
          ref.watch(commissioningRepositoryProvider).watchRecord(projectId),
    );

/// Strings medidos del proyecto.
final StreamProviderFamily<List<StringTest>, String> stringTestsProvider =
    StreamProvider.autoDispose.family<List<StringTest>, String>(
      (ref, projectId) =>
          ref.watch(commissioningRepositoryProvider).watchStrings(projectId),
    );
