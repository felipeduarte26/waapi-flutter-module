import '../../domain/entities/employee_item_entity.dart';
import '../../domain/entities/pagination_employee_item_entity.dart';
import '../../domain/repositories/get_employees_to_facial_registration_repository.dart';
import '../adapters/employee_item_entity_adapter.dart';
import '../datasources/get_employees_to_facial_registration_datasource.dart';
import '../models/employee_item_model.dart';
import '../models/pagination_employee_item_model.dart';

class GetEmployeesToFacialRegistrationRepositoryImpl
    implements GetEmployeesToFacialRegistrationRepository {
  final GetEmployeesToFacialRegistrationDatasource
      getEmployeesToFacialRegistrationDatasource;
  final EmployeeItemEntityAdapter employeeItemEntityAdapter;

  const GetEmployeesToFacialRegistrationRepositoryImpl({
    required this.getEmployeesToFacialRegistrationDatasource,
    required this.employeeItemEntityAdapter,
  });

  @override
  Future<PaginationEmployeeItemEntity> call({
    String? name,
    required int pageNumber,
    required int pageSize,
    required String token,
  }) async {
    List<EmployeeItemEntity> employeeList = [];

    PaginationEmployeeItemModel paginationEmployeeItemModel =
        await getEmployeesToFacialRegistrationDatasource.call(
      name: name,
      pageNumber: pageNumber,
      pageSize: pageSize,
      token: token,
    );

    for (EmployeeItemModel element in paginationEmployeeItemModel.employees) {
      employeeList
          .add(employeeItemEntityAdapter.fromModel(employeeItemModel: element));
    }

    return PaginationEmployeeItemEntity(
      pageNumber: paginationEmployeeItemModel.pageNumber,
      pageSize: paginationEmployeeItemModel.pageSize,
      totalPage: paginationEmployeeItemModel.totalPage,
      employees: employeeList,
    );
  }
}
