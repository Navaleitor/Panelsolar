/// Motor de cálculo solar en Dart puro (posición solar, irradiancia, potencia,
/// sombras, strings, eléctrico, viento, economía).
///
/// Cada fórmula tiene su ficha en `docs/formulas/`.
library;

export 'src/core/angles.dart' show cosd, degToRad, radToDeg, sind;
export 'src/irradiance/atmosphere.dart';
export 'src/irradiance/erbs.dart';
export 'src/irradiance/incidence.dart';
export 'src/irradiance/poa.dart';
export 'src/irradiance/sky_diffuse.dart';
export 'src/optics/iam.dart';
export 'src/optimization/orientation_optimizer.dart';
export 'src/package_info.dart';
export 'src/position/delta_t.dart';
export 'src/position/solar_position.dart';
export 'src/position/spa.dart';
export 'src/power/losses.dart';
export 'src/power/pvwatts_dc.dart';
export 'src/power/pvwatts_inverter.dart';
export 'src/simulation/horizon_profile.dart';
export 'src/simulation/monthly_aggregator.dart';
export 'src/simulation/pv_system.dart';
export 'src/simulation/simulation_inputs.dart';
export 'src/simulation/simulation_result.dart';
export 'src/simulation/simulator.dart';
export 'src/simulation/site.dart';
export 'src/simulation/weather_series.dart';
export 'src/statistics/climate_statistics.dart';
export 'src/statistics/design_temperatures.dart';
export 'src/sunpath/sun_path.dart';
export 'src/thermal/cell_temperature.dart';
