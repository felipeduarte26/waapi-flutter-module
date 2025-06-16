import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/manager_employee_dto.dart';

void main() {
  group('ManagerEmployeeDto', () {
    test('should correctly serialize and deserialize platformUsers', () {
  
      final managerEmployeeDto = ManagerEmployeeDto(
        id: '123',
        platformUserName: 'manager',
        employees: [],
      );

      // Act
      final json = managerEmployeeDto.toJson();
      final deserialized =
          ManagerEmployeeDto.fromJson(json);

      // Assert
      expect(deserialized.platformUserName, managerEmployeeDto.platformUserName);
      expect(deserialized.id, managerEmployeeDto.id);
    });
  });
}
