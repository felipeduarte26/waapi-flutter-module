abstract class TimerAdjustmentEvent {}

class LoadDayTimerAdjustmentEvent extends TimerAdjustmentEvent {
  DateTime selectedDay;

  LoadDayTimerAdjustmentEvent({
    required this.selectedDay,
  });
}

class ShowReceiptTimerAdjustmentEvent extends TimerAdjustmentEvent {
  String clockingEventId;
  String locale;
  ShowReceiptTimerAdjustmentEvent({
    required this.clockingEventId,
    required this.locale,
  });
}

class AddOvernightEvent extends TimerAdjustmentEvent {}

class ChangedSelectedEmployee extends TimerAdjustmentEvent {
  final String employeeId;

  ChangedSelectedEmployee(this.employeeId);
}
