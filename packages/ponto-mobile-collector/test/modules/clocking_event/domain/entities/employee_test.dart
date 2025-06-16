import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/employee_entity_mock.dart';

void main() {
  group('Employee', () {
    test(
        'copywith without any arguments should not modify any propertie of entity test',
        () async {
      final employee = employeeEntityMock.copyWith();
      expect(employee, employeeEntityMock);
    });

    test('copywith should work for all properties of entity', () async {
      Employee initEmployee = Employee(
        id: 'id',
        employeeType: 'employeeType',
        cpf: 'cpf',
        arpId: 'arpId',
        enable: true,
        mail: 'mail',
        name: 'name',
        nfcCode: 'nfcCode',
        registrationNumber: 'registrationNumber',
        company: companyEntityMock,
      );

      final employee = employeeEntityMock.copyWith(
        arpId: initEmployee.arpId,
        cpf: initEmployee.cpf,
        employeeType: initEmployee.employeeType,
        enable: initEmployee.enable,
        id: initEmployee.id,
        mail: initEmployee.mail,
        name: initEmployee.name,
        nfcCode: initEmployee.nfcCode,
        registrationNumber: initEmployee.registrationNumber,
      );

      expect(employee.arpId, initEmployee.arpId);
      expect(employee.cpf, initEmployee.cpf);
      expect(employee.employeeType, initEmployee.employeeType);
      expect(employee.enable, initEmployee.enable);
      expect(employee.id, initEmployee.id);
      expect(employee.mail, initEmployee.mail);
      expect(employee.name, initEmployee.name);
      expect(employee.nfcCode, initEmployee.nfcCode);
      expect(employee.registrationNumber, initEmployee.registrationNumber);
    });
  });
}
