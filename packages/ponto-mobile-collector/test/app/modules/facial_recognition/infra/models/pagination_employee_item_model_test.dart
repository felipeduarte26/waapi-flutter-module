import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/infra/models/pagination_employee_item_model.dart';

import '../../../../../mocks/pagination_employee_item_model_mock.dart';

void main() {
  group('PaginationEmployeeItemModel', () {
    test('props test', () async {
      PaginationEmployeeItemModel paginationEmployeeItemModel =
          PaginationEmployeeItemModel(
        pageNumber: paginationEmployeeItemModelMock.pageNumber,
        pageSize: paginationEmployeeItemModelMock.pageSize,
        totalPage: paginationEmployeeItemModelMock.totalPage,
        employees: paginationEmployeeItemModelMock.employees,
      );

      expect(paginationEmployeeItemModel, paginationEmployeeItemModelMock);
    });
  });
}
