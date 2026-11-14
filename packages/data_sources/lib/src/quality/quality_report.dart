/// Resultado del control de calidad de una serie meteorológica.
class QualityReport {
  /// Crea el informe.
  const new({
    required this.records,
    required this.missingRecords,
    required this.missingValues,
    required this.negativeValues,
    required this.ghiAboveExtraterrestrial,
    this.componentsClosed = 0,
  });

  /// Registros finales (después de rellenar huecos de tiempo).
  final int records;

  /// Horas que faltaban en la secuencia de tiempo (se agregaron).
  final int missingRecords;

  /// Valores faltantes rellenados, por variable (ghi, dni, dhi, tempAir,
  /// windSpeed). Incluye los de las horas agregadas.
  final Map<String, int> missingValues;

  /// Valores de irradiancia o viento negativos (se pusieron en 0).
  final int negativeValues;

  /// Horas con GHI mayor que la extraterrestre horizontal (se recortaron).
  final int ghiAboveExtraterrestrial;

  /// Horas en que se recalculó la DNI para cumplir GHI = DNI·cos θz + DHI.
  final int componentsClosed;

  /// Total de valores rellenados.
  int get totalMissingValues => missingValues.values.fold(0, (a, b) => a + b);

  /// Fracción de valores faltantes respecto al total (0–1).
  double get missingFraction =>
      records == 0 ? 1 : totalMissingValues / (records * 5);

  /// La serie es usable si faltaba menos del 5 % de los valores.
  bool get isUsable => missingFraction < 0.05;

  /// Advertencias en español para mostrar al usuario.
  List<String> get warnings {
    final pct = (missingFraction * 100).toStringAsFixed(2);
    const tooManyGaps =
        'La serie tiene demasiados huecos; el resultado puede no ser '
        'confiable.';
    final negatives =
        '$negativeValues valores negativos de irradiancia o viento se '
        'pusieron en 0.';
    final aboveExtra =
        '$ghiAboveExtraterrestrial horas con GHI mayor que la extraterrestre '
        'se recortaron.';
    final closure =
        'Se ajustó la irradiancia directa en $componentsClosed horas para que '
        'cuadre con la global (GHI = DNI·cos θz + DHI).';
    return [
      if (missingRecords > 0)
        'Faltaban $missingRecords horas en la serie; se rellenaron.',
      if (totalMissingValues > 0)
        'Se rellenaron $totalMissingValues valores faltantes ($pct %).',
      if (negativeValues > 0) negatives,
      if (ghiAboveExtraterrestrial > 0) aboveExtra,
      if (componentsClosed > 0) closure,
      if (!isUsable) tooManyGaps,
    ];
  }
}

/// Comparación anual entre dos fuentes (p. ej. NASA POWER vs. PVGIS).
class CrossSourceCheck {
  /// Crea la comparación.
  const new({
    required this.primaryAnnualGhi,
    required this.referenceAnnualGhi,
    this.primaryMeanTemp = double.nan,
    this.referenceMeanTemp = double.nan,
    this.threshold = 10,
    this.temperatureThreshold = 3,
  });

  /// Irradiación global horizontal anual de la fuente principal (kWh/m²).
  final double primaryAnnualGhi;

  /// Irradiación anual de la fuente de referencia (kWh/m²).
  final double referenceAnnualGhi;

  /// Temperatura media anual de la fuente principal (°C).
  final double primaryMeanTemp;

  /// Temperatura media anual de la fuente de referencia (°C).
  final double referenceMeanTemp;

  /// Umbral de advertencia de irradiación (%).
  final double threshold;

  /// Umbral de advertencia de temperatura media (°C).
  final double temperatureThreshold;

  /// Diferencia relativa (%) = (principal − referencia)/referencia·100.
  double get differencePercent =>
      (primaryAnnualGhi - referenceAnnualGhi) / referenceAnnualGhi * 100;

  /// Diferencia de temperatura media (°C) = principal − referencia.
  double get temperatureDifference => primaryMeanTemp - referenceMeanTemp;

  /// Verdadero si la diferencia de irradiación supera el umbral.
  bool get exceedsThreshold => differencePercent.abs() > threshold;

  /// Verdadero si la diferencia de temperatura supera su umbral.
  bool get temperatureExceedsThreshold =>
      temperatureDifference.abs() > temperatureThreshold;

  /// Advertencias en español (vacía si todo cuadra).
  List<String> get warnings {
    final pct = differencePercent.toStringAsFixed(1);
    final dt = temperatureDifference.toStringAsFixed(1);
    final thr = threshold.toStringAsFixed(0);
    final irradiation =
        'NASA POWER y PVGIS difieren $pct % en la irradiación anual (umbral '
        '±$thr %). Revise el sitio o use mediciones locales.';
    final temperature =
        'La temperatura media de NASA POWER difiere $dt °C de la de PVGIS '
        '(la celda de NASA puede tener otra altitud). Revise las '
        'temperaturas de diseño.';
    return [
      if (exceedsThreshold) irradiation,
      if (temperatureExceedsThreshold) temperature,
    ];
  }
}
