import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/utility_bills/domain/billing_period_math.dart';
import 'package:persistence/persistence.dart';

void main() {
  test('fin sugerido inclusivo', () {
    expect(
      BillingPeriodMath.defaultEnd(
        DateTime.utc(2026, 1, 15),
        BillingPeriod.bimonthly,
      ),
      DateTime.utc(2026, 3, 14),
    );
    expect(
      BillingPeriodMath.defaultEnd(
        DateTime.utc(2026, 12),
        BillingPeriod.monthly,
      ),
      DateTime.utc(2026, 12, 31),
    );
    expect(
      BillingPeriodMath.defaultEnd(
        DateTime.utc(2026, 11, 20),
        BillingPeriod.bimonthly,
      ),
      DateTime.utc(2027, 1, 19),
    );
  });

  test('el siguiente recibo empieza el día después', () {
    expect(
      BillingPeriodMath.nextStart(DateTime.utc(2026, 2, 28)),
      DateTime.utc(2026, 3),
    );
    expect(
      BillingPeriodMath.nextStart(DateTime.utc(2026, 12, 31)),
      DateTime.utc(2027),
    );
  });
}
