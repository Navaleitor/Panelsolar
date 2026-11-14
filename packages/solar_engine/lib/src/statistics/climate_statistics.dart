import 'dart:math' as math;

import 'package:solar_engine/src/simulation/monthly_aggregator.dart';
import 'package:solar_engine/src/simulation/site.dart';
import 'package:solar_engine/src/simulation/weather_series.dart';

/// Estación del año (meteorológica, trimestres completos).
enum Season {
  /// Invierno: DEF en el hemisferio norte, JJA en el sur.
  winter,

  /// Primavera: MAM en el norte, SON en el sur.
  spring,

  /// Verano: JJA en el norte, DEF en el sur.
  summer,

  /// Otoño: SON en el norte, MAM en el sur.
  autumn,
}

/// Estadísticas de un periodo (mes o estación).
typedef PeriodStats = ({
  double irradiation,
  double dailyIrradiation,
  double tempMean,
  double tempMin,
  double tempMax,
});

/// Temperaturas de diseño del sitio para el dimensionamiento de strings (F4).
typedef DesignTemperatures = ({
  double recordMin,
  double recordMax,
  double meanAnnualMin,
  double meanAnnualMax,
});

/// Estadísticas climáticas mensuales y por estación de una serie.
/// Ficha: docs/formulas/13-estadisticas-climaticas.md
///
/// - Irradiación: kWh/m² (suma del mes típico) y kWh/m²·día.
/// - Temperaturas: °C. Mín./máx. son los extremos horarios de toda la serie.
class ClimateStatistics {
  new _(this.monthly, this.seasonal, this.design, this.annual);

  /// Calcula las estadísticas de [weather] en el [site].
  factory compute(Site site, WeatherSeries weather) {
    final offset = site.utcOffsetHours;
    final ghi = MonthlyAggregator(stepHours: weather.stepHours);
    final temp = MonthlyAggregator(stepHours: weather.stepHours);
    final yearMin = <int, double>{};
    final yearMax = <int, double>{};
    for (var i = 0; i < weather.length; i++) {
      final local = weather.localStart(i, offset);
      final g = weather.ghi[i];
      ghi.add(
        local,
        g.isNaN ? double.nan : math.max(0, g) * weather.stepHours / 1000,
      );
      final t = weather.tempAir[i];
      temp.add(local, t);
      if (!t.isNaN) {
        yearMin[local.year] = math.min(yearMin[local.year] ?? t, t);
        yearMax[local.year] = math.max(yearMax[local.year] ?? t, t);
      }
    }
    final irr = ghi.typicalMonthlySums();
    final tMean = temp.typicalMonthlyMeans();
    final tMin = List<double>.filled(12, double.nan);
    final tMax = List<double>.filled(12, double.nan);
    for (final key in temp.completeMonthKeys) {
      final m = key % 100 - 1;
      tMin[m] = _nanMin(tMin[m], temp.minOf(key)!);
      tMax[m] = _nanMax(tMax[m], temp.maxOf(key)!);
    }
    final monthly = [
      for (var m = 0; m < 12; m++)
        (
          irradiation: irr[m],
          dailyIrradiation: irr[m] / _daysInMonth[m],
          tempMean: tMean[m],
          tempMin: tMin[m],
          tempMax: tMax[m],
        ),
    ];
    final seasonal = {
      for (final s in Season.values)
        s: _combine(
          [
            for (final m in _seasonMonths(s, site.isSouthernHemisphere))
              monthly[m],
          ],
          [for (final m in _seasonMonths(s, site.isSouthernHemisphere)) m],
        ),
    };
    final annual = _combine(monthly, List.generate(12, (m) => m));
    double mean(Iterable<double> v) =>
        v.isEmpty ? double.nan : v.reduce((a, b) => a + b) / v.length;
    final design = (
      recordMin: yearMin.values.fold(double.nan, _nanMin),
      recordMax: yearMax.values.fold(double.nan, _nanMax),
      meanAnnualMin: mean(yearMin.values),
      meanAnnualMax: mean(yearMax.values),
    );
    return ClimateStatistics._(monthly, seasonal, design, annual);
  }

  /// 12 meses (índice 0 = enero).
  final List<PeriodStats> monthly;

  /// Por estación, según el hemisferio del sitio.
  final Map<Season, PeriodStats> seasonal;

  /// Temperaturas de diseño (para strings en F4).
  final DesignTemperatures design;

  /// Año típico completo.
  final PeriodStats annual;

  static const List<int> _daysInMonth = [
    31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, //
  ];

  static List<int> _seasonMonths(Season s, bool south) {
    const north = {
      Season.winter: [11, 0, 1],
      Season.spring: [2, 3, 4],
      Season.summer: [5, 6, 7],
      Season.autumn: [8, 9, 10],
    };
    const opposite = {
      Season.winter: Season.summer,
      Season.spring: Season.autumn,
      Season.summer: Season.winter,
      Season.autumn: Season.spring,
    };
    return north[south ? opposite[s]! : s]!;
  }

  static PeriodStats _combine(List<PeriodStats> months, List<int> idx) {
    var irr = 0.0;
    var days = 0;
    var tWeighted = 0.0;
    var tMin = double.nan;
    var tMax = double.nan;
    for (var k = 0; k < months.length; k++) {
      final d = _daysInMonth[idx[k]];
      irr += months[k].irradiation;
      days += d;
      tWeighted += months[k].tempMean * d;
      tMin = _nanMin(tMin, months[k].tempMin);
      tMax = _nanMax(tMax, months[k].tempMax);
    }
    return (
      irradiation: irr,
      dailyIrradiation: irr / days,
      tempMean: tWeighted / days,
      tempMin: tMin,
      tempMax: tMax,
    );
  }

  static double _nanMin(double a, double b) =>
      a.isNaN ? b : (b.isNaN ? a : math.min(a, b));

  static double _nanMax(double a, double b) =>
      a.isNaN ? b : (b.isNaN ? a : math.max(a, b));
}
