part of 'vacation_schedule_individual_bloc.dart';

abstract class VacationScheduleIndividualState extends Equatable {
  const VacationScheduleIndividualState();

  @override
  List<Object?> get props => [];
}

class InitialVacationScheduleIndividualState extends VacationScheduleIndividualState {}

class LoadedVacationScheduleIndividualState extends VacationScheduleIndividualState {
  final bool isVacationScheduleUpdating;

  const LoadedVacationScheduleIndividualState({
    required this.isVacationScheduleUpdating,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      isVacationScheduleUpdating,
    ];
  }
}

class LoadingVacationScheduleIndividualState extends VacationScheduleIndividualState {}

class UpdatingVacationScheduleIndividualState extends VacationScheduleIndividualState {}

class ErrorVacationScheduleIndividualState extends VacationScheduleIndividualState {
  final List<String>? vacationScheduleIndividualResult;

  const ErrorVacationScheduleIndividualState({
    required this.vacationScheduleIndividualResult,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      vacationScheduleIndividualResult,
    ];
  }
}
