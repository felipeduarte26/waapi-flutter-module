import 'package:equatable/equatable.dart';

import 'vacation_employee_calendar_view_model.dart';

class VacationCalendarStaffViewModel extends Equatable {
  final List<VacationEmployeeCalendarViewModel> vacationEmployeeCalendarViewModel;
  final int employeesCount;
  final int employeesInVacationCount;

  const VacationCalendarStaffViewModel({
    required this.vacationEmployeeCalendarViewModel,
    required this.employeesCount,
    required this.employeesInVacationCount,
  });

  @override
  List<Object?> get props => [
        vacationEmployeeCalendarViewModel,
        employeesCount,
        employeesInVacationCount,
      ];
}
