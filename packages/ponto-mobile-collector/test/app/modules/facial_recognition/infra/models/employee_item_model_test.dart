import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/infra/models/employee_item_model.dart';

void main() {
  String tName = 'Name';
  String tId = 'id';
  String tIdentifier = 'identifier';
  
  group('EmployeeItemEntity', () {
    test('props test', () async {
      EmployeeItemModel paginationEntity = EmployeeItemModel(
        id: tId,
        name: tName,
        identifier: tIdentifier,
      );

      expect(paginationEntity.props[0], tId);
      expect(paginationEntity.props[1], tName);
      expect(paginationEntity.props[2], tIdentifier);
    });
  });
}
