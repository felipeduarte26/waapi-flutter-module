import '../../domain/input_models/vacation_calendar_staff_view_input_model.dart';
import 'vacation_employee_calendar_view_filter_input_model_mapper.dart';

class VacationEmployeeCalendarViewInputModelMapper {
  Map<String, dynamic> toMap({
    required VacationCalendarStaffViewInputModel vacationEmployeeCalendarViewInputModel,
  }) {
    return {
      'startDate': vacationEmployeeCalendarViewInputModel.startDate,
      'endDate': vacationEmployeeCalendarViewInputModel.endDate,
      'filter': VacationEmployeeCalendarViewFilterInputModelMapper().toMap(
        vacationEmployeeCalendarViewFilterInputModel: vacationEmployeeCalendarViewInputModel.filter,
      ),
    };
  }
}
