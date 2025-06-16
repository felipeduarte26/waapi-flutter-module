import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/entities/pagination_employee_item_entity.dart';

import '../../../../../mocks/pagination_employee_item_entity_mock.dart';

void main() {
  group('PaginationEmployeeItemEntity', () {
    test('props test', () async {
      PaginationEmployeeItemEntity paginationEmployeeItemEntity =
          PaginationEmployeeItemEntity(
        employees: paginationEmployeeItemEntityMock.employees,
        pageNumber: paginationEmployeeItemEntityMock.pageNumber,
        pageSize: paginationEmployeeItemEntityMock.pageSize,
        totalPage: paginationEmployeeItemEntityMock.totalPage,
      );

      expect(paginationEmployeeItemEntity, paginationEmployeeItemEntityMock);
    });
  });
}
