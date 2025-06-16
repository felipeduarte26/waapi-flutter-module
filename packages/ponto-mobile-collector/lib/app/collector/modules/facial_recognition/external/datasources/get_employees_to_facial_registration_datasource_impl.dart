import 'dart:convert';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/services/http_client/i_http_client.dart';
import '../../../../core/infra/adapters/employee_adapter.dart';
import '../../../../core/infra/utils/constants/constants_path.dart';
import '../../infra/datasources/get_employees_to_facial_registration_datasource.dart';
import '../../infra/models/employee_item_model.dart';
import '../../infra/models/pagination_employee_item_model.dart';
import 'get_employees_to_facial_registration_datasource_exception.dart';

class GetEmployeesToFacialRegistrationDatasourceImpl
    implements GetEmployeesToFacialRegistrationDatasource {
  final IHttpClient _httpClient;
  final IEnvironmentService _environmentService;

  const GetEmployeesToFacialRegistrationDatasourceImpl({
    required IHttpClient httpClient,
    required IEnvironmentService environmentService,
  })  : _environmentService = environmentService,
        _httpClient = httpClient;

  @override
  Future<PaginationEmployeeItemModel> call({
    String? name,
    required int pageNumber,
    required int pageSize,
    required String token,
  }) async {

    List<EmployeeItemModel> employeesResult = [];
    int totalElements = 0;
    
    try {
      final url = Uri.https(
        _environmentService.environment().path,
        ConstantsPath.getSearchEmployeesFacialAuthOn,
      );

      final result = await _httpClient.post(
        url.toString(),
        body: json.encode({
          'name': name,
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (result.statusCode == 200) {
        pageNumber = EmployeeAdapter.getPageNumber(result.body);
        pageSize = EmployeeAdapter.getPageSize(result.body);
        totalElements = EmployeeAdapter.getTotalElements(result.body);
        employeesResult = EmployeeAdapter.fromJSON(
          result.body,
        );

      }
    } on GetEmployeesFacialRegistrationException {
      rethrow;
    } catch (exception) {
      throw GetEmployeesFacialRegistrationException(exception: exception);
    }
    PaginationEmployeeItemModel pagination = PaginationEmployeeItemModel(
      pageNumber: pageNumber,
      pageSize: pageSize,
      totalPage: totalElements,
      employees: employeesResult,
    );
    return pagination;
  }
}
