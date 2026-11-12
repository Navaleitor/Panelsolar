import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/clients/domain/contact_validators.dart';

void main() {
  test('nombre obligatorio', () {
    expect(ContactValidators.name(null), ContactFieldError.required);
    expect(ContactValidators.name('   '), ContactFieldError.required);
    expect(ContactValidators.name('Ana'), isNull);
  });

  test('correo opcional con formato', () {
    expect(ContactValidators.email(''), isNull);
    expect(ContactValidators.email('ana@solar.mx'), isNull);
    expect(ContactValidators.email('ana@'), ContactFieldError.invalidEmail);
    expect(
      ContactValidators.email('ana solar'),
      ContactFieldError.invalidEmail,
    );
  });

  test('teléfono opcional con al menos 7 dígitos', () {
    expect(ContactValidators.phone(''), isNull);
    expect(ContactValidators.phone('+52 (81) 1234-5678'), isNull);
    expect(ContactValidators.phone('12345'), ContactFieldError.invalidPhone);
    expect(
      ContactValidators.phone('81abc4567'),
      ContactFieldError.invalidPhone,
    );
  });
}
