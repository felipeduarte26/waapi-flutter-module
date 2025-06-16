import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/external/mappers/employee_item_model_mapper.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/infra/models/employee_item_model.dart';

import '../../../../../mocks/employee_item_model_mock.dart';

void main() {
  Map<String, dynamic> tMap = {
    'id': employeeItemModelMock.id,
    'identifier': employeeItemModelMock.identifier,
    'name': employeeItemModelMock.name,
  };

  late EmployeeItemModelMapper employeeItemModelMapper;

  setUp(() {
    employeeItemModelMapper = EmployeeItemModelMapper();
  });

  group('EmployeeItemModelMapper', () {
    test('fromModel test', () async {
      EmployeeItemModel employeeItemModel = employeeItemModelMapper.fromMap(
        map: tMap,
      );

      expect(employeeItemModel.id, employeeItemModelMock.id);
      expect(employeeItemModel.name, employeeItemModelMock.name);
      expect(employeeItemModel.identifier, employeeItemModelMock.identifier);
    });
  });
}
