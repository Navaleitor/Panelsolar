/// Sector al que aplica una tarifa.
enum TariffSector {
  /// Uso doméstico.
  residential,

  /// Negocio / comercio.
  commercial,
}

/// Periodo de facturación habitual de la tarifa.
enum TariffBillingPeriod {
  /// Mensual.
  monthly,

  /// Bimestral.
  bimonthly,
}

/// Tarifa eléctrica de un paquete regional (solo datos de identificación
/// en F1; los precios y escalones llegan en F5).
class Tariff {
  /// Crea una tarifa.
  const new({
    required this.code,
    required this.shortName,
    required this.country,
    required this.utility,
    required this.sector,
    required this.billingPeriod,
    required this.nameEs,
    required this.nameEn,
    this.minSummerAvgTempC,
    this.highConsumptionLimitKwhPerMonth,
  });

  /// Lee una tarifa del JSON del paquete. Lanza [FormatException] si falta
  /// un campo obligatorio o tiene un tipo incorrecto.
  factory fromJson(Map<String, Object?> json) {
    T field<T>(String name) {
      final value = json[name];
      if (value is! T) {
        throw FormatException('Tarifa: campo "$name" inválido', json);
      }
      return value;
    }

    return Tariff(
      code: field<String>('code'),
      shortName: field<String>('shortName'),
      country: field<String>('country'),
      utility: field<String>('utility'),
      sector: TariffSector.values.byName(field<String>('sector')),
      billingPeriod: TariffBillingPeriod.values.byName(
        field<String>('billingPeriod'),
      ),
      nameEs: field<String>('nameEs'),
      nameEn: field<String>('nameEn'),
      minSummerAvgTempC: field<num?>('minSummerAvgTempC')?.toDouble(),
      highConsumptionLimitKwhPerMonth: field<num?>(
        'highConsumptionLimitKwhPerMonth',
      )?.toDouble(),
    );
  }

  /// Código único global (p. ej. `MX-CFE-1C`). Es lo que se guarda en los
  /// recibos: no cambiarlo nunca.
  final String code;

  /// Nombre corto que ve el usuario (p. ej. `1C`).
  final String shortName;

  /// País ISO 3166-1 alfa-2.
  final String country;

  /// Suministrador (p. ej. `CFE`).
  final String utility;

  /// Sector.
  final TariffSector sector;

  /// Periodo de facturación habitual (sugerido al capturar un recibo).
  final TariffBillingPeriod billingPeriod;

  /// Nombre descriptivo en español.
  final String nameEs;

  /// Nombre descriptivo en inglés.
  final String nameEn;

  /// Temperatura media mínima de verano de la localidad (°C) que define la
  /// tarifa doméstica, si aplica.
  final double? minSummerAvgTempC;

  /// Límite de alto consumo (kWh/mes, promedio de 12 meses). Si el cliente
  /// lo rebasa, pasa a tarifa DAC.
  final double? highConsumptionLimitKwhPerMonth;

  /// Nombre en el idioma [languageCode] (`es` por defecto).
  String name(String languageCode) => languageCode == 'en' ? nameEn : nameEs;

  /// `true` si un promedio de [avgKwhPerMonth] rebasa el límite de alto
  /// consumo de esta tarifa.
  bool exceedsHighConsumptionLimit(double avgKwhPerMonth) {
    final limit = highConsumptionLimitKwhPerMonth;
    return limit != null && avgKwhPerMonth > limit;
  }
}
