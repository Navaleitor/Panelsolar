import 'dart:typed_data';

/// Serie meteorológica de paso fijo (normalmente horaria), en unidades SI.
///
/// Cada registro `i` representa el promedio del intervalo que empieza en
/// [startEpochSeconds]`[i]` (UTC) y dura [stepMinutes]. La posición solar se
/// evalúa en el centro del intervalo ([sampleOffsetMinutes]).
///
/// Valores faltantes: `double.nan`. Si faltan DNI o DHI el simulador usa
/// la descomposición de Erbs a partir de GHI.
class WeatherSeries {
  /// Crea una serie; todas las listas deben tener la misma longitud.
  new({
    required this.startEpochSeconds,
    required this.ghi,
    required this.dni,
    required this.dhi,
    required this.tempAir,
    required this.windSpeed,
    this.albedo,
    this.stepMinutes = 60,
    int? sampleOffsetMinutes,
  }) : sampleOffsetMinutes = sampleOffsetMinutes ?? stepMinutes ~/ 2 {
    final n = startEpochSeconds.length;
    final lists = [ghi, dni, dhi, tempAir, windSpeed, ?albedo];
    if (lists.any((l) => l.length != n)) {
      throw ArgumentError('Todas las columnas deben tener $n valores.');
    }
  }

  /// Inicio de cada intervalo, segundos desde 1970-01-01 UTC.
  final List<int> startEpochSeconds;

  /// Irradiancia global horizontal (W/m²).
  final Float64List ghi;

  /// Irradiancia directa normal (W/m²).
  final Float64List dni;

  /// Irradiancia difusa horizontal (W/m²).
  final Float64List dhi;

  /// Temperatura del aire a 2 m (°C).
  final Float64List tempAir;

  /// Velocidad del viento (m/s). PVGIS y NASA dan viento a 10 m.
  final Float64List windSpeed;

  /// Albedo del suelo (0–1), opcional.
  final Float64List? albedo;

  /// Duración de cada intervalo (min).
  final int stepMinutes;

  /// Minutos desde el inicio del intervalo en que se evalúa el Sol.
  final int sampleOffsetMinutes;

  /// Número de registros.
  int get length => startEpochSeconds.length;

  /// Duración del intervalo en horas.
  double get stepHours => stepMinutes / 60;

  /// Instante (UTC) en que se evalúa la posición solar del registro [i].
  DateTime sampleTimeUtc(int i) => DateTime.fromMillisecondsSinceEpoch(
    (startEpochSeconds[i] + sampleOffsetMinutes * 60) * 1000,
    isUtc: true,
  );

  /// Inicio del intervalo [i] en hora estándar local con desfase
  /// [utcOffsetHours] (se devuelve como `DateTime` UTC "desplazado").
  DateTime localStart(int i, double utcOffsetHours) =>
      DateTime.fromMillisecondsSinceEpoch(
        (startEpochSeconds[i] + (utcOffsetHours * 3600).round()) * 1000,
        isUtc: true,
      );
}
