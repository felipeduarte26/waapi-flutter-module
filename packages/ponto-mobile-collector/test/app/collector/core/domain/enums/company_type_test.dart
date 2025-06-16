import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/company_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/exception/clocking_event_exception.dart';

void main() {
  group('CompanyType', () {
    test('should return CompanyType.cpf when value is "CPF"', () {
      const value = 'CPF';
      final result = CompanyType.build(value);

      expect(result, CompanyType.cpf);
    });

    test('should throw ClockingEventException when value is invalid', () {
      const value = 'INVALID';

      expect(() => CompanyType.build(value), throwsA(isA<ClockingEventException>()));
    });
  });
}