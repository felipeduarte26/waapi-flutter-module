import 'package:equatable/equatable.dart';

import '../../enums/enum_status_vacation_staff_calendar.dart';

class VacationEmployeeCalendarViewEntity extends Equatable {
  final String title;
  final String start;
  final String end;
  final EnumStatusVacationStaffCalendar type;

  const VacationEmployeeCalendarViewEntity({
    required this.title,
    required this.start,
    required this.end,
    required this.type,
  });

  @override
  List<Object?> get props => [
        title,
        start,
        end,
        type,
      ];
}
