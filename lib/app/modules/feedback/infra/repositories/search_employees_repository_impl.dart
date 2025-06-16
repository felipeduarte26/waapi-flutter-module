import '../../../../core/types/either.dart';
import '../../domain/failures/feedback_failure.dart';
import '../../domain/repositories/search_employees_repository.dart';
import '../../domain/types/feedback_domain_types.dart';
import '../adapters/employee_entity_adapter.dart';
import '../datasources/search_employees_datasource.dart';

class SearchEmployeesRepositoryImpl implements SearchEmployeesRepository {
  final SearchEmployeesDatasource _searchEmployeesDatasource;
  final EmployeeEntityAdapter _employeeEntityAdapter;

  const SearchEmployeesRepositoryImpl({
    required SearchEmployeesDatasource searchEmployeesDatasource,
    required EmployeeEntityAdapter employeeEntityAdapter,
  })  : _searchEmployeesDatasource = searchEmployeesDatasource,
        _employeeEntityAdapter = employeeEntityAdapter;

  @override
  SearchEmployeesUsecaseCallback call({
    required String search,
  }) async {
    try {
      final searchEmployeeModelList = await _searchEmployeesDatasource.call(
        search: search,
      );

      final searchEmployeeEntityList = searchEmployeeModelList.map(
        (searchEmployeeModel) {
          return _employeeEntityAdapter.fromModel(
            model: searchEmployeeModel,
          );
        },
      ).toList();

      return right(searchEmployeeEntityList);
    } catch (error) {
      return left(const FeedbackDatasourceFailure());
    }
  }
}
