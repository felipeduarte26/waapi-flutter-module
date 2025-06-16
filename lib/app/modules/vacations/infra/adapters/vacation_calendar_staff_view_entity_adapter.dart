import '../../domain/entities/vacation_calendar_staff_view_entity.dart';
import '../models/vacation_calendar_staff_view_model.dart';
import 'vacation_employee_calendar_view_entity_adapter.dart';

class VacationCalendarStaffViewEntityAdapter {
  VacationCalendarStaffViewEntity fromModel({
    required VacationCalendarStaffViewModel vacationCalendarModel,
  }) {
    return VacationCalendarStaffViewEntity(
      employeesCount: vacationCalendarModel.employeesCount,
      employeesInVacationCount: vacationCalendarModel.employeesInVacationCount,
      vacationEmployeeCalendarViewEntity: vacationCalendarModel.vacationEmployeeCalendarViewModel
          .map(
            (e) => VacationEmployeeCalendarViewEntityAdapter().fromModel(
              vacationEmployeeCalendarViewModel: e,
            ),
          )
          .toList(),
    );
  }
}
