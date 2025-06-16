import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_next_15_days_birthdays_company_datasource.dart';
import '../../infra/models/employees_by_year_hire_model.dart';
import '../mappers/employees_by_year_hire_model_mapper.dart';

class GetNext15DaysBirthdaysCompanyDatasourceImpl implements GetNext15DaysBirthdaysCompanyDatasource {
  final RestService _restService;
  final EmployeesByYearHireModelMapper _employeesByYearHireModelMapper;

  const GetNext15DaysBirthdaysCompanyDatasourceImpl({
    required RestService restService,
    required EmployeesByYearHireModelMapper employeesByYearHireModelMapper,
  })  : _restService = restService,
        _employeesByYearHireModelMapper = employeesByYearHireModelMapper;

  @override
  Future<List<EmployeesByYearHireModel>> call({
    required PaginationRequirements paginationRequirements,
    required DateTime currentDate,
    required String employeeId,
  }) async {
    final startDate = DateTimeHelper.formatToIso8601Date(
      dateTime: currentDate,
    );

    final endDate = DateTimeHelper.formatToIso8601Date(
      dateTime: currentDate.add(
        const Duration(
          days: 15,
        ),
      ),
    );

    final employeesByYearHireModelJson = await _restService.legacyManagementPanelService().get(
      '/birthday/company-paged',
      queryParameters: {
        'start': startDate,
        'end': endDate,
        'offset': paginationRequirements.offset,
        'limit': paginationRequirements.limit,
        'activeEmployeeId': employeeId,
      },
    );

    return _employeesByYearHireModelMapper.fromJson(
      employeesByYearHireJson: employeesByYearHireModelJson.data,
    );
  }
}
