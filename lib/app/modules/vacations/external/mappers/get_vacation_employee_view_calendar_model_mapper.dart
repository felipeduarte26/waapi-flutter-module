import '../../../../core/helper/enum_helper.dart';
import '../../enums/enum_status_vacation_staff_calendar.dart';
import '../../infra/models/vacation_employee_calendar_view_model.dart';

class GetVacationEmployeeViewCalendarModelMapper {
  List<VacationEmployeeCalendarViewModel> fromMap({
    required Map<String, dynamic> map,
  }) {
    final List<VacationEmployeeCalendarViewModel> listVacationEmployeeCalendarViewModel = [];
    map.forEach((key, value) {
      for (var element in value) {
        listVacationEmployeeCalendarViewModel.add(
          VacationEmployeeCalendarViewModel(
            title: element['title'],
            end: element['end'],
            start: element['start'],
            type: EnumHelper<EnumStatusVacationStaffCalendar>().stringToEnum(
              stringToParse: element['type'],
              values: EnumStatusVacationStaffCalendar.values,
            ),
          ),
        );
      }
    });
    return listVacationEmployeeCalendarViewModel;
  }
}
