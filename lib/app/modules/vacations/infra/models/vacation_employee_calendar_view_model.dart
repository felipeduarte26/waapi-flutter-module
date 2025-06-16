import 'package:equatable/equatable.dart';

import '../../enums/enum_status_vacation_staff_calendar.dart';

class VacationEmployeeCalendarViewModel extends Equatable {
  final String title;
  final String start;
  final String end;
  final EnumStatusVacationStaffCalendar? type;

  const VacationEmployeeCalendarViewModel({
    required this.title,
    required this.start,
    required this.end,
    this.type,
  });

  @override
  List<Object?> get props => [
        title,
        start,
        end,
        type,
      ];
}
