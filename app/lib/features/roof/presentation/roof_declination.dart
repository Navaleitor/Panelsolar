import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/site/presentation/site_providers.dart';
import 'package:persistence/persistence.dart';

/// Ubicación guardada del proyecto, ya cargada. La pantalla que la usa
/// debe observar `siteProvider(projectId)` en su `build`.
Site? siteFor(WidgetRef ref, String projectId) =>
    ref.read(siteProvider(projectId)).value;

/// Declinación magnética (WMM2025) en el sitio del proyecto, hoy. Sin
/// ubicación guardada devuelve 0 (la brújula marca el norte magnético).
double declinationFor(WidgetRef ref, String projectId) {
  final site = siteFor(ref, projectId);
  if (site == null) return 0;
  return WorldMagneticModel.declination(
    latitude: site.latitude,
    longitude: site.longitude,
    altitudeM: site.altitudeM ?? 0,
    year: WorldMagneticModel.decimalYear(DateTime.now()),
  );
}
