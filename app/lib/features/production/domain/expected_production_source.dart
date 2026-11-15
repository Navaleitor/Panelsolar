/// De dónde sale la producción esperada de un mes.
///
/// Hoy el valor se captura a mano en cada lectura ([ManualExpectedSource]).
/// Cuando F2 (motor solar) esté integrado se agrega una implementación que
/// calcule la energía mensual del diseño y la irradiación en el plano
/// (para el PR) y se elige en `production_providers.dart`, sin tocar las
/// pantallas.
abstract interface class ExpectedProductionSource {
  /// Energía esperada (kWh) y la irradiación POA (kWh/m²) del [month]
  /// para el proyecto, o `null` si esta fuente no la conoce.
  Future<({double expectedKwh, double? poaKwhM2})?> expectedFor(
    String projectId,
    DateTime month,
  );
}

/// Fuente manual: no propone nada; el usuario escribe el valor.
class ManualExpectedSource implements ExpectedProductionSource {
  const new();

  @override
  Future<({double expectedKwh, double? poaKwhM2})?> expectedFor(
    String projectId,
    DateTime month,
  ) async => null;
}
