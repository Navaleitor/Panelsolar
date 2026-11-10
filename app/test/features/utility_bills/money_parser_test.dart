import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/utility_bills/domain/money_parser.dart';

void main() {
  test('acepta punto o coma decimal y separadores de miles', () {
    expect(parseDecimal('1540.50'), 1540.5);
    expect(parseDecimal('1,540.50'), 1540.5);
    expect(parseDecimal('1.540,50'), 1540.5);
    expect(parseDecimal('1540,5'), 1540.5);
    expect(parseDecimal('1,540'), 1540);
    expect(parseDecimal(r'$ 1 540'), 1540);
    expect(parseDecimal('620'), 620);
  });

  test('vacío o basura → null', () {
    expect(parseDecimal(''), isNull);
    expect(parseDecimal('abc'), isNull);
    expect(parseMoneyToCents(''), isNull);
  });

  test('centavos redondeados', () {
    expect(parseMoneyToCents('1,540.50'), 154050);
    expect(parseMoneyToCents('0.105'), 11);
  });
}
