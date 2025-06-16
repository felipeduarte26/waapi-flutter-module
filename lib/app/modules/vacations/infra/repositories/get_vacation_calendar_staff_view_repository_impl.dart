import '../../../../core/types/either.dart';
import '../../domain/failures/vacations_failure.dart';
import '../../domain/input_models/vacation_calendar_staff_view_filter_input_model.dart';
import '../../domain/input_models/vacation_calendar_staff_view_input_model.dart';
import '../../domain/repositories/get_vacation_calendar_staff_view_repository.dart';
import '../../domain/types/vacations_domain_types.dart';
import '../adapters/vacation_calendar_staff_view_entity_adapter.dart';
import '../datasources/get_vacation_calendar_staff_view_datasource.dart';

class GetVacationCalendarStaffViewRepositoryImpl implements GetVacationCalendarStaffViewRepository {
  final GetVacationCalendarStaffViewDatasource _getVacationEmployeeCalendarViewDatasource;
  final VacationCalendarStaffViewEntityAdapter _vacationCalendarEntityAdapter;

  GetVacationCalendarStaffViewRepositoryImpl({
    required GetVacationCalendarStaffViewDatasource getVacationEmployeeCalendarViewDatasource,
    required VacationCalendarStaffViewEntityAdapter vacationEmployeeCalendarViewEntityAdapter,
  })  : _getVacationEmployeeCalendarViewDatasource = getVacationEmployeeCalendarViewDatasource,
        _vacationCalendarEntityAdapter = vacationEmployeeCalendarViewEntityAdapter;

  @override
  GetVacationCalendarStaffViewUsecaseCallback call({
    required String employeeId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final vacationCalendar = await _getVacationEmployeeCalendarViewDatasource.call(
        vacationEmployeeCalendarViewInputModel: VacationCalendarStaffViewInputModel(
          startDate: startDate,
          endDate: endDate,
          filter: VacationCalendarStaffViewFilterInputModel(
            employeeId: employeeId,
          ),
        ),
      );

      final vacationCalendarViewEntity = _vacationCalendarEntityAdapter.fromModel(
        vacationCalendarModel: vacationCalendar,
      );

      return right(
        vacationCalendarViewEntity,
      );
    } catch (error) {
      return left(
        const VacationsDatasourceFailure(),
      );
    }
  }
}
