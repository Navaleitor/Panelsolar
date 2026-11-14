import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:persistence/persistence.dart';

/// Ubicación guardada del proyecto (lectura única).
Future<Site?> siteFor(WidgetRef ref, String projectId) =>
    ref.read(siteRepositoryProvider).watchForProject(projectId).first;

/// Declinación magnética (WMM2025) en el sitio del proyecto, hoy. Sin
/// ubicación guardada devuelve 0 (la brújula marca el norte magnético).
Future<double> declinationFor(WidgetRef ref, String projectId) async {
  final site = await siteFor(ref, projectId);
  if (site == null) return 0;
  return WorldMagneticModel.declination(
    latitude: site.latitude,
    longitude: site.longitude,
    altitudeM: site.altitudeM ?? 0,
    year: WorldMagneticModel.decimalYear(DateTime.now()),
  );
}
