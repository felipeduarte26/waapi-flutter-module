part of 'vacation_request_bloc.dart';

abstract class VacationRequestEvent extends Equatable {}

class SendVacationRequestEvent extends VacationRequestEvent {
  final SendVacationRequestInputModel sendVacationRequestInputModel;
  final List<String>? restrictions;

  SendVacationRequestEvent({
    required this.sendVacationRequestInputModel,
    this.restrictions,
  });

  @override
  List<Object?> get props {
    return [
      sendVacationRequestInputModel,
      restrictions,
    ];
  }
}

class SendVacationRequestUpdateEvent extends VacationRequestEvent {
  final SendVacationRequestUpdateInputModel sendVacationRequestUpdateInputModel;
  final List<String>? restrictions;

  SendVacationRequestUpdateEvent({
    required this.sendVacationRequestUpdateInputModel,
    this.restrictions,
  });

  @override
  List<Object?> get props {
    return [
      sendVacationRequestUpdateInputModel,
      restrictions,
    ];
  }
}

class CancelVacationRequestEvent extends VacationRequestEvent {
  final String idVacation;
  final List<String>? restrictions;
  final bool isApproved;
  final String employeeId;

  CancelVacationRequestEvent({
    required this.idVacation,
    this.restrictions,
    required this.isApproved,
    required this.employeeId,
  });

  @override
  List<Object?> get props {
    return [
      idVacation,
      restrictions,
      isApproved,
      employeeId,
    ];
  }
}
