import 'package:equatable/equatable.dart';

class VacationCalendarStaffViewFilterInputModel extends Equatable {
  final String? date;
  final String employeeId;
  final List<String>? employeeIds;

  const VacationCalendarStaffViewFilterInputModel({
    this.date,
    required this.employeeId,
    this.employeeIds,
  });

  @override
  List<Object?> get props => [
        date,
        employeeId,
        employeeIds,
      ];
}
