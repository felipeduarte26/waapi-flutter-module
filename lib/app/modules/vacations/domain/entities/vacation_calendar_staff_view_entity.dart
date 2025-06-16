import 'package:equatable/equatable.dart';

import 'vacation_employee_calendar_view_entity.dart';

class VacationCalendarStaffViewEntity extends Equatable {
  final List<VacationEmployeeCalendarViewEntity> vacationEmployeeCalendarViewEntity;
  final int employeesCount;
  final int employeesInVacationCount;

  const VacationCalendarStaffViewEntity({
    required this.employeesCount,
    required this.employeesInVacationCount,
    required this.vacationEmployeeCalendarViewEntity,
  });

  @override
  List<Object?> get props => [
        vacationEmployeeCalendarViewEntity,
        employeesCount,
        employeesInVacationCount,
      ];
}
