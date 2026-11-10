/// Metadatos del paquete `regional_packs`.
///
/// Marcador de la Fase F0: confirma que el paquete compila y se prueba.
/// La funcionalidad real llega en la fase F5.
abstract final class RegionalPacksInfo {
  /// Nombre del paquete.
  static const String name = 'regional_packs';

  /// Fase del plan maestro en la que se implementa su contenido.
  static const String plannedPhase = 'F5';
}
