import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/manager_employee.dart';

import '../../../../../mocks/employee_entity_mock.dart';
import '../../../../../mocks/platform_user_entity_mock.dart';

void main() {
  group('ManagerEmployee', () {
    test('should correctly initialize with given values', () {
      var managerEmployee = ManagerEmployee(
        id: '123',
        mail: 'test@mail.com',
        platformUsers: [platformUserMock],
        platformUserName: 'Manager1',
        employees: [employeeEntityMock],
      );

      expect(managerEmployee.id, '123');
      expect(managerEmployee.mail, 'test@mail.com');
      expect(managerEmployee.platformUsers?.length, 1);
      expect(managerEmployee.platformUsers?.first.platformUserName, 'username');
      expect(managerEmployee.platformUserName, 'Manager1');
      expect(managerEmployee.employees?.length, 1);
      expect(managerEmployee.employees?.first.name, 'name');
    });

    test('props should include all fields', () {
      var managerEmployee = ManagerEmployee(
        id: '123',
        mail: 'test@mail.com',
        platformUsers:[platformUserMock],
        platformUserName: 'Manager1',
        employees: [employeeEntityMock],
      );

      expect(managerEmployee.props, [
        '123',
        'test@mail.com',
        [platformUserMock],
        'Manager1',
        [employeeEntityMock],
      ]);
    });

    test('should allow null values for optional fields', () {
      const managerEmployee = ManagerEmployee();

      expect(managerEmployee.id, isNull);
      expect(managerEmployee.mail, isNull);
      expect(managerEmployee.platformUsers, isNull);
      expect(managerEmployee.platformUserName, isNull);
      expect(managerEmployee.employees, isNull);
    });
  });
}
