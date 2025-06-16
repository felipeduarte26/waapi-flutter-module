class TimerState {}

class TimerInitializingState extends TimerState {}

class TimerClockState extends TimerState {
  DateTime dateTime;
  TimerClockState({required this.dateTime});
}

class TimerUpdatingState extends TimerState {}

class TimerUpdatedState extends TimerState {
  DateTime dateTime;
  TimerUpdatedState({required this.dateTime});
}
