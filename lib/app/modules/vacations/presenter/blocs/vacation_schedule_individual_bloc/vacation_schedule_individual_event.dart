part of 'vacation_schedule_individual_bloc.dart';

abstract class VacationScheduleIndividualEvent extends Equatable {}

class GetVacationScheduleIndividualEvent extends VacationScheduleIndividualEvent {
  final String idVacation;
  final String employeeId;

  GetVacationScheduleIndividualEvent({
    required this.idVacation,
    required this.employeeId,
  });

  @override
  List<Object?> get props {
    return [
      idVacation,
      employeeId,
    ];
  }
}
