import 'dart:async';

/// Asegura un mínimo de tiempo entre el **inicio** de dos tareas y las
/// ejecuta en orden (una a la vez). Nominatim pide máximo 1 petición/s.
class RateLimiter {
  /// Crea el limitador. [now] y [sleep] se inyectan en pruebas.
  new(
    this.minInterval, {
    DateTime Function()? now,
    Future<void> Function(Duration)? sleep,
  }) : _now = now ?? DateTime.now,
       _sleep = sleep ?? Future<void>.delayed;

  /// Separación mínima entre tareas.
  final Duration minInterval;
  final DateTime Function() _now;
  final Future<void> Function(Duration) _sleep;

  DateTime? _lastStart;
  Future<void> _tail = Future<void>.value();

  /// Ejecuta [task] cuando le toque y devuelve su resultado.
  Future<T> run<T>(Future<T> Function() task) {
    final completer = Completer<T>();
    _tail = _tail.then((_) async {
      final last = _lastStart;
      if (last != null) {
        final wait = minInterval - _now().difference(last);
        if (wait > Duration.zero) await _sleep(wait);
      }
      _lastStart = _now();
      try {
        completer.complete(await task());
      } on Object catch (error, stack) {
        completer.completeError(error, stack);
      }
    });
    return completer.future;
  }
}
