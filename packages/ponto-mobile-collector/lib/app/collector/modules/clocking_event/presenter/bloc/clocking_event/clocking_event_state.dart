
import '../../../../../core/domain/input_model/clocking_event_dto.dart';

abstract class ClockingEventBaseState {}

class InitialClockingEventState implements ClockingEventBaseState {}

class LoadingClockingEventState implements ClockingEventBaseState {}

class ReadyContentClockingEventState implements ClockingEventBaseState {
  final List<ClockingEventDto> clockingEventsDto;

  ReadyContentClockingEventState({
    required this.clockingEventsDto,
  });
}

class ChangeTodayClockingEventState implements ClockingEventBaseState {}

class ClockingEventShowReceiptSucessState implements ClockingEventBaseState {}

class ClockingEventLoadingLocationState implements ClockingEventBaseState {}
