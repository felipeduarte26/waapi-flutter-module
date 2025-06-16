part of 'drivers_journey_bloc.dart';

abstract class DriversJourneyEvent {
  auth.ClockingEventUseType use = auth.ClockingEventUseType.clockingEvent;
  DriversWorkStatusEnum status = DriversWorkStatusEnum.working;
  bool startAction = false;
  DriversJourneyEvent? closedBy;
}

class ClockingEventFinish extends DriversJourneyEvent {
  final DateTime? dateTimeEvent;

  ClockingEventFinish(this.dateTimeEvent);
}

class StartJourneyEvent extends DriversJourneyEvent {
  bool force = false;
  StartJourneyEvent({this.force = false}) {
    status = DriversWorkStatusEnum.working;
  }
}

class ConfirmStartJourneyBeforeAction extends DriversJourneyEvent {
  final DriversJourneyEvent action;

  ConfirmStartJourneyBeforeAction({
    required this.action,
  });
}

class StartActionWithoutJourney extends DriversJourneyEvent {
  final DriversJourneyEvent action;

  StartActionWithoutJourney({
    required this.action,
  });
}

class EmitJourneyStartedBeforeAction extends DriversJourneyEvent {
  final DriversJourneyEvent action;

  EmitJourneyStartedBeforeAction({
    required this.action,
  });
}

class EmitActionStartedWithoutJourney extends DriversJourneyEvent {
  final DriversJourneyEvent action;

  EmitActionStartedWithoutJourney({
    required this.action,
  });
}

class JourneyInExecution extends DriversJourneyEvent {}

class EndJourneyEvent extends DriversJourneyEvent {
  bool closeJourney = false;
  bool overnight = false;
  EndJourneyEvent({bool? doClose, bool? withOvernight}) {
    closeJourney = doClose ?? false;
    overnight = withOvernight ?? false;
    status = DriversWorkStatusEnum.notStarted;
  }
}

class ConfirmCloseActionBeforeEndJourney extends DriversJourneyEvent {
  final DriversJourneyEvent action;

  ConfirmCloseActionBeforeEndJourney({
    required this.action,
  });
}

class FinishJourneyAndPreviousActionDoesNot extends DriversJourneyEvent {
  final DriversJourneyEvent action;

  FinishJourneyAndPreviousActionDoesNot({
    required this.action,
  });
}

class EmitJourneyFinishedAndPreviousActionDoesNot extends DriversJourneyEvent {
  final DriversJourneyEvent action;

  EmitJourneyFinishedAndPreviousActionDoesNot({
    required this.action,
  });
}

class EmitPreviousActionClosedAndJourneyEnded extends DriversJourneyEvent {
  final DriversJourneyEvent action;

  EmitPreviousActionClosedAndJourneyEnded({
    required this.action,
  });
}

class StartDrivingEvent extends DriversJourneyEvent {
  StartDrivingEvent() {
    use = auth.ClockingEventUseType.driving;
    status = DriversWorkStatusEnum.driving;
    startAction = true;
    closedBy = StopDrivingEvent();
  }
}

class StopDrivingEvent extends DriversJourneyEvent {
  StopDrivingEvent() {
    use = auth.ClockingEventUseType.driving;
    status = DriversWorkStatusEnum.working;
  }
}

class StartMandatoryBreakEvent extends DriversJourneyEvent {
  StartMandatoryBreakEvent() {
    use = auth.ClockingEventUseType.mandatoryBreak;
    status = DriversWorkStatusEnum.mandatoryBreak;
    startAction = true;
    closedBy = EndMandatoryBreakEvent();
  }
}

class EndMandatoryBreakEvent extends DriversJourneyEvent {
  EndMandatoryBreakEvent() {
    use = auth.ClockingEventUseType.mandatoryBreak;
    status = DriversWorkStatusEnum.working;
  }
}

class StartLunchEvent extends DriversJourneyEvent {
  StartLunchEvent() {
    use = auth.ClockingEventUseType.clockingEvent;
    status = DriversWorkStatusEnum.foodTime;
    startAction = true;
    closedBy = EndLunchEvent();
  }
}

class EndLunchEvent extends DriversJourneyEvent {
  EndLunchEvent() {
    use = auth.ClockingEventUseType.clockingEvent;
    status = DriversWorkStatusEnum.working;
  }
}

class StartWaitingBreakEvent extends DriversJourneyEvent {
  StartWaitingBreakEvent() {
    use = auth.ClockingEventUseType.waiting;
    status = DriversWorkStatusEnum.waiting;
    startAction = true;
    closedBy = EndWaitingBreakEvent();
  }
}

class EndWaitingBreakEvent extends DriversJourneyEvent {
  EndWaitingBreakEvent() {
    use = auth.ClockingEventUseType.waiting;
    status = DriversWorkStatusEnum.working;
  }
}

class LoadJourneyEvent extends DriversJourneyEvent {}

class ConfirmClosePreviousAction extends DriversJourneyEvent {
  List<DriversJourneyEvent> toExecute;

  ConfirmClosePreviousAction(this.toExecute);
}

class EmitNewActionStartedAndPreviousDoesNot extends DriversJourneyEvent {
  final DriversJourneyEvent newAction;

  EmitNewActionStartedAndPreviousDoesNot({required this.newAction});
}

class EmitPreviousActionFinishedAndNewStarted extends DriversJourneyEvent {
  final DriversJourneyEvent newAction;

  EmitPreviousActionFinishedAndNewStarted({required this.newAction});
}

class DoNothing extends DriversJourneyEvent {
  DoNothing();
}
