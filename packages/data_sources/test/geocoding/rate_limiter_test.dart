import 'package:data_sources/geocoding.dart';
import 'package:test/test.dart';

void main() {
  test('espera lo necesario para respetar 1 petición por segundo', () async {
    var clock = DateTime.utc(2026);
    final sleeps = <Duration>[];
    final limiter = RateLimiter(
      const Duration(seconds: 1),
      now: () => clock,
      sleep: (d) async {
        sleeps.add(d);
        clock = clock.add(d);
      },
    );
    final starts = <DateTime>[];

    await Future.wait([
      for (var i = 0; i < 3; i++)
        limiter.run(() async {
          starts.add(clock);
          clock = clock.add(const Duration(milliseconds: 200));
          return i;
        }),
    ]);

    expect(sleeps, [
      const Duration(milliseconds: 800),
      const Duration(milliseconds: 800),
    ]);
    expect(starts[1].difference(starts[0]), const Duration(seconds: 1));
    expect(starts[2].difference(starts[1]), const Duration(seconds: 1));
  });

  test('ejecuta en orden y propaga errores sin bloquear la cola', () async {
    final limiter = RateLimiter(Duration.zero);
    final order = <int>[];
    final failing = limiter.run<int>(() async => throw StateError('x'));
    final ok = limiter.run(() async {
      order.add(2);
      return 2;
    });
    await expectLater(failing, throwsStateError);
    expect(await ok, 2);
    expect(order, [2]);
  });
}
