import '../../domain/entities/vacation_employee_calendar_view_entity.dart';
import '../models/vacation_employee_calendar_view_model.dart';

class VacationEmployeeCalendarViewEntityAdapter {
  VacationEmployeeCalendarViewEntity fromModel({
    required VacationEmployeeCalendarViewModel vacationEmployeeCalendarViewModel,
  }) {
    return VacationEmployeeCalendarViewEntity(
      title: vacationEmployeeCalendarViewModel.title,
      start: vacationEmployeeCalendarViewModel.start,
      end: vacationEmployeeCalendarViewModel.end,
      type: vacationEmployeeCalendarViewModel.type!,
    );
  }
}
