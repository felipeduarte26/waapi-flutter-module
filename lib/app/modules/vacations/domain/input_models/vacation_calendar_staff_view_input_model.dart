import 'package:equatable/equatable.dart';

import 'vacation_calendar_staff_view_filter_input_model.dart';

class VacationCalendarStaffViewInputModel extends Equatable {
  final String startDate;
  final String endDate;
  final VacationCalendarStaffViewFilterInputModel filter;

  const VacationCalendarStaffViewInputModel({
    required this.startDate,
    required this.endDate,
    required this.filter,
  });

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        filter,
      ];
}
