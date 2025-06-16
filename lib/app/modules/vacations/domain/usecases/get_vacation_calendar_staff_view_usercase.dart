import '../repositories/get_vacation_calendar_staff_view_repository.dart';
import '../types/vacations_domain_types.dart';

abstract class GetVacationCalendarStaffViewUsercase {
  GetVacationCalendarStaffViewUsecaseCallback call({
    required String employeeId,
    required String startDate,
    required String endDate,
  });
}

class GetVacationCalendarStaffViewUsercaseImpl implements GetVacationCalendarStaffViewUsercase {
  final GetVacationCalendarStaffViewRepository _getVacationCalendarStaffViewRepository;

  const GetVacationCalendarStaffViewUsercaseImpl({
    required GetVacationCalendarStaffViewRepository getVacationEmployeeCalendarViewRepository,
  }) : _getVacationCalendarStaffViewRepository = getVacationEmployeeCalendarViewRepository;

  @override
  GetVacationCalendarStaffViewUsecaseCallback call({
    required String employeeId,
    required String startDate,
    required String endDate,
  }) {
    return _getVacationCalendarStaffViewRepository.call(
      employeeId: employeeId,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
