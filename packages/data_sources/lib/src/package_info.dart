/// Metadatos del paquete `data_sources`.
///
/// Marcador de la Fase F0: confirma que el paquete compila y se prueba.
/// La funcionalidad real llega en la fase F2.
abstract final class DataSourcesInfo {
  /// Nombre del paquete.
  static const String name = 'data_sources';

  /// Fase del plan maestro en la que se implementa su contenido.
  static const String plannedPhase = 'F2';
}
