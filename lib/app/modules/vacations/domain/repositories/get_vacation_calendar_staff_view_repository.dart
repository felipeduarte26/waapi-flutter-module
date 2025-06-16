import '../types/vacations_domain_types.dart';

abstract class GetVacationCalendarStaffViewRepository {
  GetVacationCalendarStaffViewUsecaseCallback call({
    required String employeeId,
    required String startDate,
    required String endDate,
  });
}
