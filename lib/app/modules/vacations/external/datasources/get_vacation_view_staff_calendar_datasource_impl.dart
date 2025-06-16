import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/input_models/vacation_calendar_staff_view_input_model.dart';
import '../../infra/datasources/get_vacation_calendar_staff_view_datasource.dart';
import '../../infra/models/vacation_calendar_staff_view_model.dart';
import '../mappers/get_vacation_calendar_staff_view_model_mapper.dart';
import '../mappers/vacation_employee_calendar_view_input_model_mapper.dart';

class GetVacationViewStaffCalendarDatasourceImpl implements GetVacationCalendarStaffViewDatasource {
  final RestService _restService;
  final VacationEmployeeCalendarViewInputModelMapper _vacationEmployeeCalendarViewInputModelMapper;
  final GetVacationCalendarStaffViewModelMapper _getVacationCalendarMapper;

  const GetVacationViewStaffCalendarDatasourceImpl({
    required RestService restService,
    required VacationEmployeeCalendarViewInputModelMapper vacationEmployeeCalendarViewInputModelMapper,
    required GetVacationCalendarStaffViewModelMapper getVacationCalendarStaffViewMapper,
  })  : _restService = restService,
        _vacationEmployeeCalendarViewInputModelMapper = vacationEmployeeCalendarViewInputModelMapper,
        _getVacationCalendarMapper = getVacationCalendarStaffViewMapper;

  @override
  Future<VacationCalendarStaffViewModel> call({
    required VacationCalendarStaffViewInputModel vacationEmployeeCalendarViewInputModel,
  }) async {
    final bodyVacationEmployeeCalendarViewInputModel = _vacationEmployeeCalendarViewInputModelMapper.toMap(
      vacationEmployeeCalendarViewInputModel: vacationEmployeeCalendarViewInputModel,
    );
    final response = await _restService.legacyManagementPanelService().post(
          '/vacation/team/${vacationEmployeeCalendarViewInputModel.filter.employeeId}/calendar/employee-view',
          body: bodyVacationEmployeeCalendarViewInputModel,
        );

    final vacationEmployeeCalendarViewDecode = jsonDecode(response.data!);

    return _getVacationCalendarMapper.fromMap(
      map: vacationEmployeeCalendarViewDecode,
    );
  }
}
