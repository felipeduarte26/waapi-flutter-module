import '../../domain/input_models/vacation_calendar_staff_view_filter_input_model.dart';

class VacationEmployeeCalendarViewFilterInputModelMapper {
  Map<String, dynamic> toMap({
    required VacationCalendarStaffViewFilterInputModel vacationEmployeeCalendarViewFilterInputModel,
  }) {
    return {
      'employeeId': vacationEmployeeCalendarViewFilterInputModel.employeeId,
      'date': '',
      'employeeIds': [],
    };
  }
}
