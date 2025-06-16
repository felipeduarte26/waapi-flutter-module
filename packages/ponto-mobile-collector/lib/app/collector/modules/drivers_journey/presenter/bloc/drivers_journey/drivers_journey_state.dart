part of 'drivers_journey_bloc.dart';

abstract class DriversJourneyState {}

class InitialDriversJourneyState extends DriversJourneyState {}

class LoadingDriversJourneyState extends DriversJourneyState {}

class NotStartedDriversJourneyState extends DriversJourneyState {}

class RegisteringClockingEvent extends DriversJourneyState {}

class CallingModalToStartJourneyFromAction extends DriversJourneyState {
  DriversJourneyEvent action;

  CallingModalToStartJourneyFromAction({
    required this.action,
  });
}

class JourneyStartedBeforeAction extends DriversJourneyState {
  final DriversJourneyEvent action;

  JourneyStartedBeforeAction({
    required this.action,
  });
}

class ActionStartedWithoutJourney extends DriversJourneyState {
  final DriversJourneyEvent action;

  ActionStartedWithoutJourney({
    required this.action,
  });
}

class CallingModalToClosePrevious extends DriversJourneyState {
  DriversJourneyEvent? toClose;
  DriversJourneyEvent? actual;

  CallingModalToClosePrevious({
    this.toClose,
    this.actual,
  });
}

class StartNewDriverJourney extends DriversJourneyState {
  DriversJourneyEvent? toExecute;

  StartNewDriverJourney({
    this.toExecute,
  });
}

class CallingModalToCloseActionBeforeEndJourney extends DriversJourneyState {
  DriversJourneyEvent action;

  CallingModalToCloseActionBeforeEndJourney({
    required this.action,
  });
}

class JourneyFinishedAndPreviousActionDoesNot extends DriversJourneyState {
  final DriversJourneyEvent action;

  JourneyFinishedAndPreviousActionDoesNot({
    required this.action,
  });
}

class PreviousActionClosedAndJourneyEnded extends DriversJourneyState {
  final DriversJourneyEvent action;

  PreviousActionClosedAndJourneyEnded({
    required this.action,
  });
}

class CallingOvernight extends DriversJourneyState {
  DriversJourneyEvent? actual;

  CallingOvernight({
    this.actual,
  });
}

class StartedDriversJourneyState extends DriversJourneyState {
  bool isLoading;
  DateTime journeyStartedDateTime;
  DateTime dateTimeOfLastStatusStarted;
  DriversJourneyEvent? driversJourneyEvent;

  StartedDriversJourneyState({
    this.isLoading = false,
    required this.journeyStartedDateTime,
    required this.dateTimeOfLastStatusStarted,
    required this.driversJourneyEvent,
  });

  StartedDriversJourneyState copyWith({
    bool? isLoading,
    DateTime? journeyStartedDateTime,
    DateTime? dateTimeOfLastStatusStarted,
    DriversJourneyEvent? driversJourneyEvent,
  }) {
    var startedDriversJourneyState = StartedDriversJourneyState(
      isLoading: isLoading ?? this.isLoading,
      journeyStartedDateTime:
          journeyStartedDateTime ?? this.journeyStartedDateTime,
      dateTimeOfLastStatusStarted:
          dateTimeOfLastStatusStarted ?? this.dateTimeOfLastStatusStarted,
      driversJourneyEvent: driversJourneyEvent ?? this.driversJourneyEvent,
    );

    return startedDriversJourneyState;
  }
}

class NewActionStartedAndPreviousDoesNot extends DriversJourneyState {
  final DriversJourneyEvent previousAction;
  final DriversJourneyEvent newAction;

  NewActionStartedAndPreviousDoesNot({
    required this.previousAction,
    required this.newAction,
  });
}

class PreviousActionFinishedAndNewStarted extends DriversJourneyState {
  final DriversJourneyEvent previousAction;
  final DriversJourneyEvent newAction;

  PreviousActionFinishedAndNewStarted({
    required this.previousAction,
    required this.newAction,
  });
}

class ErrorDriversJourneyState extends DriversJourneyState {
  final String title;
  final String subtitle;

  ErrorDriversJourneyState({
    required this.title,
    required this.subtitle,
  }) {
    log('Error Drivers Journey');
    log('Title: $title');
    log('Subtitle: $subtitle');
  }
}
