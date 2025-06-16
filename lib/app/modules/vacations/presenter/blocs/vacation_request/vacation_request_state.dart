part of 'vacation_request_bloc.dart';

abstract class VacationRequestState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class LoadedVacationRequestState extends VacationRequestState {}

class CanceledVacationRequestState extends VacationRequestState {}

class ErrorVacationRequestState extends VacationRequestState {
  final List<String>? vacationRequestResult;

  ErrorVacationRequestState({
    required this.vacationRequestResult,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      vacationRequestResult,
    ];
  }
}

class LoadingVacationRequestState extends VacationRequestState {}

class InitialVacationRequestState extends VacationRequestState {}
