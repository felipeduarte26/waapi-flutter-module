import 'package:equatable/equatable.dart';

import '../../../domain/entities/vacation_calendar_staff_view_entity.dart';

abstract class VacationCalendarStaffViewState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialVacationCalendarState extends VacationCalendarStaffViewState {}

class LoadingVacationCalendarState extends VacationCalendarStaffViewState {}

class EmptyVacationCalendarState extends VacationCalendarStaffViewState {}

class LoadedVacationCalendarStaffViewState extends VacationCalendarStaffViewState {
  final VacationCalendarStaffViewEntity vacationCalendarStaffViewEntity;

  LoadedVacationCalendarStaffViewState({
    required this.vacationCalendarStaffViewEntity,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      vacationCalendarStaffViewEntity,
    ];
  }
}

class ErrorVacationsCalendarState extends VacationCalendarStaffViewState {
  final String employeeId;

  ErrorVacationsCalendarState({
    required this.employeeId,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      employeeId,
    ];
  }
}
