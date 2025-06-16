import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/entities/employee_item_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/infra/adapters/employee_item_entity_adapter.dart';

import '../../../../../mocks/employee_item_model_mock.dart';

void main() {
  late EmployeeItemEntityAdapter employeeItemEntityAdapter;

  setUp(() {
    employeeItemEntityAdapter = EmployeeItemEntityAdapter();
  });

  group('EmployeeItemEntityAdapter', () {
    test('fromModel test', () async {
      EmployeeItemEntity employeeItemEntity =
          employeeItemEntityAdapter.fromModel(
        employeeItemModel: employeeItemModelMock,
      );

      expect(employeeItemEntity.id, employeeItemModelMock.id);
      expect(employeeItemEntity.name, employeeItemModelMock.name);
      expect(employeeItemEntity.identifier, employeeItemModelMock.identifier);
    });
  });
}
