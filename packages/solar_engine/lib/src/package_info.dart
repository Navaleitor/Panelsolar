/// Metadatos del paquete `solar_engine`.
///
/// Marcador de la Fase F0: confirma que el paquete compila y se prueba.
/// La funcionalidad real llega en la fase F2.
abstract final class SolarEngineInfo {
  /// Nombre del paquete.
  static const String name = 'solar_engine';

  /// Fase del plan maestro en la que se implementa su contenido.
  static const String plannedPhase = 'F2';
}
