import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/employee_id_dto.dart';

void main() {
  group('EmployeeIdDto', () {
    test('should serialize and deserialize correctly', () {
      // Arrange
      final employee = EmployeeIdDto(
        id: '123',
        arpId: '456',
        pis: '789',
        cpf: '00011122233',
      );

      // Act
      final json = employee.toJson();
      final deserializedEmployee = EmployeeIdDto.fromJson(json);

      // Assert
      expect(deserializedEmployee.id, employee.id);
      expect(deserializedEmployee.arpId, employee.arpId);
      expect(deserializedEmployee.pis, employee.pis);
      expect(deserializedEmployee.cpf, employee.cpf);
    });

    test('should handle null optional fields', () {
      // Arrange
      final employee = EmployeeIdDto(
        id: '123',
        arpId: null,
        pis: null,
        cpf: null,
      );

      // Act
      final json = employee.toJson();
      final deserializedEmployee = EmployeeIdDto.fromJson(json);

      // Assert
      expect(deserializedEmployee.id, employee.id);
      expect(deserializedEmployee.arpId, isNull);
      expect(deserializedEmployee.pis, isNull);
      expect(deserializedEmployee.cpf, isNull);
    });
  });
}
