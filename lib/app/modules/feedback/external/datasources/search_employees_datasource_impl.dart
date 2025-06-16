import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/search_employees_datasource.dart';
import '../../infra/models/employee_model.dart';
import '../mappers/employee_model_mapper.dart';

class SearchEmployeesDatasourceImpl implements SearchEmployeesDatasource {
  final RestService _restService;
  final EmployeeModelMapper _employeeModelMapper;

  const SearchEmployeesDatasourceImpl({
    required RestService restService,
    required EmployeeModelMapper employeeModelMapper,
  })  : _restService = restService,
        _employeeModelMapper = employeeModelMapper;

  @override
  Future<List<EmployeeModel>> call({
    required String search,
  }) async {
    final searchEmployeesResult = await _restService.legacyManagementPanelService().get(
      '/employee/search-sumary',
      queryParameters: {
        'q': search,
      },
    );

    return _employeeModelMapper.fromJsonList(
      employeesSearchJson: searchEmployeesResult.data ?? '{}',
    );
  }
}
