import 'package:regional_packs/src/tariffs/tariff_catalog.dart';

/// Tarifas de CFE (México) que se capturan en los recibos de luz (F1).
///
/// Fuente: esquema tarifario de CFE para uso doméstico (tarifas 1 a 1F,
/// asignadas por temperatura media mínima de verano, y DAC por alto
/// consumo) y PDBT (pequeña demanda en baja tensión, hasta 25 kW).
/// Los límites de alto consumo son el promedio mensual de los últimos 12
/// meses. Precios y escalones: F5.
const String cfeTariffsJson = '''
{
  "tariffs": [
    {"code": "MX-CFE-1", "shortName": "1", "country": "MX", "utility": "CFE",
     "sector": "residential", "billingPeriod": "bimonthly",
     "nameEs": "Doméstica 1", "nameEn": "Residential 1",
     "minSummerAvgTempC": null, "highConsumptionLimitKwhPerMonth": 250},
    {"code": "MX-CFE-1A", "shortName": "1A", "country": "MX", "utility": "CFE",
     "sector": "residential", "billingPeriod": "bimonthly",
     "nameEs": "Doméstica 1A (verano ≥ 25 °C)", "nameEn": "Residential 1A (summer ≥ 25 °C)",
     "minSummerAvgTempC": 25, "highConsumptionLimitKwhPerMonth": 300},
    {"code": "MX-CFE-1B", "shortName": "1B", "country": "MX", "utility": "CFE",
     "sector": "residential", "billingPeriod": "bimonthly",
     "nameEs": "Doméstica 1B (verano ≥ 28 °C)", "nameEn": "Residential 1B (summer ≥ 28 °C)",
     "minSummerAvgTempC": 28, "highConsumptionLimitKwhPerMonth": 400},
    {"code": "MX-CFE-1C", "shortName": "1C", "country": "MX", "utility": "CFE",
     "sector": "residential", "billingPeriod": "bimonthly",
     "nameEs": "Doméstica 1C (verano ≥ 30 °C)", "nameEn": "Residential 1C (summer ≥ 30 °C)",
     "minSummerAvgTempC": 30, "highConsumptionLimitKwhPerMonth": 850},
    {"code": "MX-CFE-1D", "shortName": "1D", "country": "MX", "utility": "CFE",
     "sector": "residential", "billingPeriod": "bimonthly",
     "nameEs": "Doméstica 1D (verano ≥ 31 °C)", "nameEn": "Residential 1D (summer ≥ 31 °C)",
     "minSummerAvgTempC": 31, "highConsumptionLimitKwhPerMonth": 1000},
    {"code": "MX-CFE-1E", "shortName": "1E", "country": "MX", "utility": "CFE",
     "sector": "residential", "billingPeriod": "bimonthly",
     "nameEs": "Doméstica 1E (verano ≥ 32 °C)", "nameEn": "Residential 1E (summer ≥ 32 °C)",
     "minSummerAvgTempC": 32, "highConsumptionLimitKwhPerMonth": 2000},
    {"code": "MX-CFE-1F", "shortName": "1F", "country": "MX", "utility": "CFE",
     "sector": "residential", "billingPeriod": "bimonthly",
     "nameEs": "Doméstica 1F (verano ≥ 33 °C)", "nameEn": "Residential 1F (summer ≥ 33 °C)",
     "minSummerAvgTempC": 33, "highConsumptionLimitKwhPerMonth": 2500},
    {"code": "MX-CFE-DAC", "shortName": "DAC", "country": "MX", "utility": "CFE",
     "sector": "residential", "billingPeriod": "bimonthly",
     "nameEs": "Doméstica de alto consumo (DAC)", "nameEn": "High-consumption residential (DAC)",
     "minSummerAvgTempC": null, "highConsumptionLimitKwhPerMonth": null},
    {"code": "MX-CFE-PDBT", "shortName": "PDBT", "country": "MX", "utility": "CFE",
     "sector": "commercial", "billingPeriod": "monthly",
     "nameEs": "Pequeña demanda en baja tensión (PDBT, hasta 25 kW)",
     "nameEn": "Small demand, low voltage (PDBT, up to 25 kW)",
     "minSummerAvgTempC": null, "highConsumptionLimitKwhPerMonth": null}
  ]
}
''';

/// Catálogo de tarifas de México, listo para usar.
final TariffCatalog mexicoTariffs = TariffCatalog.fromJsonString(
  cfeTariffsJson,
);
