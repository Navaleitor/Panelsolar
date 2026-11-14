/// Geometría: polígonos, calibración de imágenes del techo, imán, croquis,
/// declinación magnética, sensores del teléfono, zonas horarias y parseo de
/// enlaces de mapas.
library;

export 'src/geometry/polygon_metrics.dart';
export 'src/geometry/polygon_ops.dart';
export 'src/geometry/vec2.dart';
export 'src/lat_lng.dart';
export 'src/magnetic/world_magnetic_model.dart';
export 'src/map_links/coordinate_text.dart';
export 'src/map_links/map_link_parser.dart';
export 'src/map_links/map_link_resolver.dart';
export 'src/map_links/map_link_result.dart';
export 'src/package_info.dart';
export 'src/roof/image_frame.dart';
export 'src/roof/obstacle_catalog.dart';
export 'src/roof/obstacle_footprint.dart';
export 'src/roof/plane_orientation.dart';
export 'src/roof/scale_calibration.dart';
export 'src/roof/snapping.dart';
export 'src/roof/tape_sketch.dart';
export 'src/sensors/phone_orientation.dart';
export 'src/time_zones/time_zone_locator.dart';
