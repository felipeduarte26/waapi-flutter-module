import 'package:equatable/equatable.dart';

import '../../../domain/input_models/vacation_calendar_staff_view_filter_input_model.dart';

abstract class VacationCalendarStaffViewEvent extends Equatable {}

class GetVacationCalendarStaffViewEvent extends VacationCalendarStaffViewEvent {
  final String startDate;
  final String endDate;
  final VacationCalendarStaffViewFilterInputModel filter;

  GetVacationCalendarStaffViewEvent({
    required this.startDate,
    required this.endDate,
    required this.filter,
  });

  @override
  List<Object?> get props {
    return [
      startDate,
      endDate,
      filter,
    ];
  }
}
