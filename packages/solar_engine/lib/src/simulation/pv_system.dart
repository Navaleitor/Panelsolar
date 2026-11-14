import 'package:solar_engine/src/irradiance/poa.dart';
import 'package:solar_engine/src/optics/iam.dart';
import 'package:solar_engine/src/power/losses.dart';
import 'package:solar_engine/src/power/pvwatts_inverter.dart';
import 'package:solar_engine/src/thermal/cell_temperature.dart';

/// Configuración de un sistema fotovoltaico fijo (un plano, un inversor
/// equivalente). Unidades SI.
class PvSystem {
  /// Crea el sistema.
  const new({
    required this.tilt,
    required this.azimuth,
    required this.pdc0,
    required this.inverter,
    this.gammaPdc = -0.0035,
    this.losses = const SystemLosses(),
    this.iamB0 = ashraeDefaultB0,
    this.temperatureModel = const FaimanModel(),
    this.transposition = TranspositionModel.perez,
  });

  /// Sistema de 1 kWp con relación DC/AC 1.2, útil como referencia.
  factory reference({required double tilt, required double azimuth}) =>
      PvSystem(
        tilt: tilt,
        azimuth: azimuth,
        pdc0: 1000,
        inverter: const PvwattsInverter(pacMax: 1000 / 1.2),
      );

  /// Inclinación β (grados, 0 = horizontal).
  final double tilt;

  /// Azimut γ (grados desde el norte; 180 = sur).
  final double azimuth;

  /// Potencia DC nominal del arreglo en STC (W).
  final double pdc0;

  /// Coeficiente de temperatura de potencia γP (1/°C).
  final double gammaPdc;

  /// Inversor (curva PVWatts + recorte).
  final PvwattsInverter inverter;

  /// Pérdidas del sistema.
  final SystemLosses losses;

  /// Coeficiente b0 del IAM ASHRAE; nulo = sin pérdidas ópticas.
  final double? iamB0;

  /// Modelo térmico.
  final CellTemperatureModel temperatureModel;

  /// Modelo de transposición.
  final TranspositionModel transposition;

  /// Relación DC/AC = Pdc0/Pac,max.
  double get dcAcRatio => pdc0 / inverter.pacMax;

  /// Copia con otra orientación.
  PvSystem withOrientation({double? tilt, double? azimuth}) => PvSystem(
    tilt: tilt ?? this.tilt,
    azimuth: azimuth ?? this.azimuth,
    pdc0: pdc0,
    inverter: inverter,
    gammaPdc: gammaPdc,
    losses: losses,
    iamB0: iamB0,
    temperatureModel: temperatureModel,
    transposition: transposition,
  );
}
