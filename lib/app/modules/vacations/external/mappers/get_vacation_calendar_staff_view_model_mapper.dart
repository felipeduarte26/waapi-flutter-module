import '../../../../core/helper/enum_helper.dart';
import '../../enums/enum_status_vacation_staff_calendar.dart';
import '../../infra/models/vacation_calendar_staff_view_model.dart';
import '../../infra/models/vacation_employee_calendar_view_model.dart';

class GetVacationCalendarStaffViewModelMapper {
  VacationCalendarStaffViewModel fromMap({
    required Map<String, dynamic> map,
  }) {
    final List<VacationEmployeeCalendarViewModel> listVacationEmployeeCalendarViewModel = [];
    int employeesCount = 0;
    int employeesInVacationCount = 0;
    map.forEach((key, value) {
      if (key == 'vacations') {
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
      }
      if (key == 'employeesCount') {
        employeesCount = value;
      }
      if (key == 'employeesInVacationCount') {
        employeesInVacationCount = value;
      }
    });
    return VacationCalendarStaffViewModel(
      vacationEmployeeCalendarViewModel: listVacationEmployeeCalendarViewModel,
      employeesCount: employeesCount,
      employeesInVacationCount: employeesInVacationCount,
    );
  }
}
