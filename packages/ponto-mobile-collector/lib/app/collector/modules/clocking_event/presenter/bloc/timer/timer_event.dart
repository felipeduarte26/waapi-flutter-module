abstract class TimerEvent {}

class TimerUpdateEvent extends TimerEvent {}

class TimerNewDateEvent extends TimerEvent {
  final DateTime dateTime;
  TimerNewDateEvent({required this.dateTime});
}
