import '../../domain/input_models/vacation_calendar_staff_view_input_model.dart';
import '../models/vacation_calendar_staff_view_model.dart';

abstract class GetVacationCalendarStaffViewDatasource {
  Future<VacationCalendarStaffViewModel> call({
    required VacationCalendarStaffViewInputModel vacationEmployeeCalendarViewInputModel,
  });
}
