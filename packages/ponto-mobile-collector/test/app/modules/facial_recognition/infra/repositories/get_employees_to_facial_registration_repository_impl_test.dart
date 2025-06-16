import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/entities/pagination_employee_item_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/repositories/get_employees_to_facial_registration_repository.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/infra/adapters/employee_item_entity_adapter.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/infra/datasources/get_employees_to_facial_registration_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/infra/repositories/get_employees_to_facial_registration_repository_impl.dart';

import '../../../../../mocks/employee_item_entity_mock.dart';
import '../../../../../mocks/employee_item_model_mock.dart';
import '../../../../../mocks/pagination_employee_item_entity_mock.dart';
import '../../../../../mocks/pagination_employee_item_model_mock.dart';

class MockGetEmployeesToFacialRegistrationDatasource extends Mock
    implements GetEmployeesToFacialRegistrationDatasource {}

class MockEmployeeItemEntityAdapter extends Mock
    implements EmployeeItemEntityAdapter {}

void main() {
  int tPageSize = 1;
  int tPageNumber = 1;
  String tName = 'name';
  late GetEmployeesToFacialRegistrationDatasource
      getEmployeesToFacialRegistrationDatasource;
  late EmployeeItemEntityAdapter employeeItemEntityAdapter;
  late GetEmployeesToFacialRegistrationRepository
      getEmployeesToFacialRegistrationRepository;

  setUp(() {
    registerFallbackValue(employeeItemModelMock);

    getEmployeesToFacialRegistrationDatasource =
        MockGetEmployeesToFacialRegistrationDatasource();
    employeeItemEntityAdapter = MockEmployeeItemEntityAdapter();

    when(
      () => getEmployeesToFacialRegistrationDatasource.call(
        pageNumber: tPageNumber,
        pageSize: tPageSize,
        name: tName, token: '',
      ),
    ).thenAnswer((_) async => paginationEmployeeItemModelMock);

    when(
      () => employeeItemEntityAdapter.fromModel(
        employeeItemModel: any(named: 'employeeItemModel'),
      ),
    ).thenReturn(employeeItemEntityMock);

    getEmployeesToFacialRegistrationRepository =
        GetEmployeesToFacialRegistrationRepositoryImpl(
      getEmployeesToFacialRegistrationDatasource:
          getEmployeesToFacialRegistrationDatasource,
      employeeItemEntityAdapter: employeeItemEntityAdapter,
    );
  });

  group('EmployeeItemEntityAdapter', () {
    test('fromModel test', () async {
      PaginationEmployeeItemEntity paginationEmployeeItemEntity =
          await getEmployeesToFacialRegistrationRepository.call(
        pageNumber: tPageNumber,
        pageSize: tPageSize,
        name: tName, token: '',
      );

      expect(paginationEmployeeItemEntity, paginationEmployeeItemEntityMock);
    });
  });
}
