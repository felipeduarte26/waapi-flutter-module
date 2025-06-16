import 'package:equatable/equatable.dart';

abstract class HasClockingEvent extends Equatable {}

class SetActiveHasClockingEvent extends HasClockingEvent {
  @override
  List<Object?> get props {
    return [];
  }
}

class SetInactiveHasClockingEvent extends HasClockingEvent {
  @override
  List<Object?> get props {
    return [];
  }
}

class GetHasClockingEvent extends HasClockingEvent {
  @override
  List<Object?> get props {
    return [];
  }
}
