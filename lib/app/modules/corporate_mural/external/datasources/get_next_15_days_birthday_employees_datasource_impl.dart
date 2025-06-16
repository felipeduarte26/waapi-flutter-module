import 'dart:convert';

import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_next_15_days_birthday_employees_datasource.dart';
import '../../infra/models/birthday_employees_model.dart';
import '../mappers/birthday_employees_model_mapper.dart';

class GetNext15DaysBirthdayEmployeesDatasourceImpl implements GetNext15DaysBirthdayEmployeesDatasource {
  final RestService _restService;
  final BirthdayEmployeesModelMapper _birthdayEmployeesModelMapper;

  const GetNext15DaysBirthdayEmployeesDatasourceImpl({
    required RestService restService,
    required BirthdayEmployeesModelMapper birthdayEmployeesModelMapper,
  })  : _restService = restService,
        _birthdayEmployeesModelMapper = birthdayEmployeesModelMapper;

  @override
  Future<BirthdayEmployeesModel?> call({
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

    final birthdayEmployeesMap = await _restService.legacyManagementPanelService().get(
      '/birthday',
      queryParameters: {
        'start': startDate,
        'end': endDate,
        'offset': paginationRequirements.offset,
        'limit': paginationRequirements.limit,
        'activeEmployeeId': employeeId,
      },
    );

    final birthdayEmployeesMapDecoded = jsonDecode(birthdayEmployeesMap.data!) as Map<String, dynamic>;

    if (birthdayEmployeesMapDecoded.isEmpty || !birthdayEmployeesMapDecoded.containsKey('employeesByBirthday')) {
      return null;
    }

    return _birthdayEmployeesModelMapper.fromMap(
      map: birthdayEmployeesMapDecoded,
    );
  }
}
