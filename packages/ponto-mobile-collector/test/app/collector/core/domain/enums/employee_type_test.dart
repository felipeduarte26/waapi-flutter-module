import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/employee_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/exception/service_exception.dart';

void main() {
  group('EmployeeType', () {
    test('should return correct enum for valid value', () {
      expect(EmployeeType.build('COMPANY_EMPLOYEE'), EmployeeType.companyEmployee);
      expect(EmployeeType.build('THIRD_PARTY_EMPLOYEE'), EmployeeType.thirdPartyEmployee);
      expect(EmployeeType.build('PARTNER_EMPLOYEE'), EmployeeType.partnerEmployee);
    });

    test('should throw ServiceException for invalid value', () {
      expect(
        () => EmployeeType.build('INVALID_EMPLOYEE'),
        throwsA(isA<ServiceException>()),
      );
    });

    test('should have correct JsonValue annotations', () {
      expect(EmployeeType.companyEmployee.value, 'COMPANY_EMPLOYEE');
      expect(EmployeeType.thirdPartyEmployee.value, 'THIRD_PARTY_EMPLOYEE');
      expect(EmployeeType.partnerEmployee.value, 'PARTNER_EMPLOYEE');
    });
  });
}