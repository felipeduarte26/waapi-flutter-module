import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart' as auth;
import '../../../../../core/domain/entities/clocking_event.dart';

abstract class RegisterClockingState {
  final String title;
  final String content;

  RegisterClockingState({
    this.title = '',
    this.content = '',
  });
}

class RegisterClockingInProgressState extends RegisterClockingState {}

class RegistrationCanceledState extends RegisterClockingState {}

class SuccessRegisterState extends RegisterClockingState {
  final ClockingEvent clockingEvent;

  SuccessRegisterState({required this.clockingEvent});
}

class RegisterClockingEventState extends RegisterClockingState {
  final auth.ImportClockingEventDto? data;

  RegisterClockingEventState({
    this.data,
  });
}

final initialRegisterClockingEventState = RegisterClockingEventState(
  data: null,
);

class ShowSnackbarMessageState extends RegisterClockingState {
  ClockingEvent clockingEvent;

  ShowSnackbarMessageState({
    required this.clockingEvent,
    super.title,
    super.content,
  });
}
