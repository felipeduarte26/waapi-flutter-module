import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/drivers_work_status_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/presenter/bloc/drivers_journey/drivers_journey_bloc.dart';

void main() {
  group(
    'DriversJourneyEvent Tests',
    () {
      test(
        'ClockingEventFinish should set dateTimeEvent correctly',
        () {
          final dateTime = DateTime.now();
          final event = ClockingEventFinish(dateTime);

          expect(
            event.dateTimeEvent,
            dateTime,
          );
        },
      );

      test(
        'StartJourneyEvent should set force and status correctly',
        () {
          final event = StartJourneyEvent(force: true);

          expect(
            event.force,
            true,
          );
          expect(
            event.status,
            DriversWorkStatusEnum.working,
          );
        },
      );

      test(
        'ConfirmStartJourneyBeforeAction should set action correctly',
        () {
          final action = StartDrivingEvent();
          final event = ConfirmStartJourneyBeforeAction(action: action);

          expect(
            event.action,
            action,
          );
        },
      );

      test(
        'StartActionWithoutJourney should set action correctly',
        () {
          final action = StartDrivingEvent();
          final event = StartActionWithoutJourney(action: action);

          expect(
            event.action,
            action,
          );
        },
      );

      test(
        'EmitJourneyStartedBeforeAction should set action correctly',
        () {
          final action = StartDrivingEvent();
          final event = EmitJourneyStartedBeforeAction(action: action);

          expect(
            event.action,
            action,
          );
        },
      );

      test(
        'EmitActionStartedWithoutJourney should set action correctly',
        () {
          final action = StartDrivingEvent();
          final event = EmitActionStartedWithoutJourney(action: action);

          expect(
            event.action,
            action,
          );
        },
      );

      test(
        'EndJourneyEvent should set closeJourney, overnight, and status correctly',
        () {
          final event = EndJourneyEvent(
            doClose: true,
            withOvernight: true,
          );

          expect(
            event.closeJourney,
            true,
          );
          expect(
            event.overnight,
            true,
          );
          expect(
            event.status,
            DriversWorkStatusEnum.notStarted,
          );
        },
      );

      test(
        'ConfirmCloseActionBeforeEndJourney should set action correctly',
        () {
          final action = StartDrivingEvent();
          final event = ConfirmCloseActionBeforeEndJourney(action: action);

          expect(
            event.action,
            action,
          );
        },
      );

      test(
        'FinishJourneyAndPreviousActionDoesNot should set action correctly',
        () {
          final action = StartDrivingEvent();
          final event = FinishJourneyAndPreviousActionDoesNot(action: action);

          expect(
            event.action,
            action,
          );
        },
      );

      test(
        'EmitJourneyFinishedAndPreviousActionDoesNot should set action correctly',
        () {
          final action = StartDrivingEvent();
          final event = EmitJourneyFinishedAndPreviousActionDoesNot(
            action: action,
          );

          expect(
            event.action,
            action,
          );
        },
      );

      test(
        'EmitPreviousActionClosedAndJourneyEnded should set action correctly',
        () {
          final action = StartDrivingEvent();
          final event = EmitPreviousActionClosedAndJourneyEnded(action: action);

          expect(
            event.action,
            action,
          );
        },
      );

      test(
        'StartDrivingEvent should set use, status, startAction, and closedBy correctly',
        () {
          final event = StartDrivingEvent();

          expect(
            event.use,
            ClockingEventUseType.driving,
          );
          expect(
            event.status,
            DriversWorkStatusEnum.driving,
          );
          expect(
            event.startAction,
            true,
          );
          expect(
            event.closedBy,
            isA<StopDrivingEvent>(),
          );
        },
      );

      test(
        'StopDrivingEvent should set use and status correctly',
        () {
          final event = StopDrivingEvent();

          expect(
            event.use,
            ClockingEventUseType.driving,
          );
          expect(
            event.status,
            DriversWorkStatusEnum.working,
          );
        },
      );

      test(
        'StartMandatoryBreakEvent should set use, status, startAction, and closedBy correctly',
        () {
          final event = StartMandatoryBreakEvent();

          expect(
            event.use,
            ClockingEventUseType.mandatoryBreak,
          );
          expect(
            event.status,
            DriversWorkStatusEnum.mandatoryBreak,
          );
          expect(
            event.startAction,
            true,
          );
          expect(
            event.closedBy,
            isA<EndMandatoryBreakEvent>(),
          );
        },
      );

      test(
        'EndMandatoryBreakEvent should set use and status correctly',
        () {
          final event = EndMandatoryBreakEvent();

          expect(
            event.use,
            ClockingEventUseType.mandatoryBreak,
          );
          expect(
            event.status,
            DriversWorkStatusEnum.working,
          );
        },
      );

      test(
        'StartLunchEvent should set use, status, startAction, and closedBy correctly',
        () {
          final event = StartLunchEvent();

          expect(
            event.use,
            ClockingEventUseType.clockingEvent,
          );
          expect(
            event.status,
            DriversWorkStatusEnum.foodTime,
          );
          expect(
            event.startAction,
            true,
          );
          expect(
            event.closedBy,
            isA<EndLunchEvent>(),
          );
        },
      );

      test(
        'EndLunchEvent should set use and status correctly',
        () {
          final event = EndLunchEvent();

          expect(
            event.use,
            ClockingEventUseType.clockingEvent,
          );
          expect(
            event.status,
            DriversWorkStatusEnum.working,
          );
        },
      );

      test(
        'StartWaitingBreakEvent should set use, status, startAction, and closedBy correctly',
        () {
          final event = StartWaitingBreakEvent();

          expect(
            event.use,
            ClockingEventUseType.waiting,
          );
          expect(
            event.status,
            DriversWorkStatusEnum.waiting,
          );
          expect(
            event.startAction,
            true,
          );
          expect(
            event.closedBy,
            isA<EndWaitingBreakEvent>(),
          );
        },
      );

      test(
        'EndWaitingBreakEvent should set use and status correctly',
        () {
          final event = EndWaitingBreakEvent();

          expect(
            event.use,
            ClockingEventUseType.waiting,
          );
          expect(
            event.status,
            DriversWorkStatusEnum.working,
          );
        },
      );

      test(
        'ConfirmClosePreviousAction should set toExecute correctly',
        () {
          final events = [
            StartJourneyEvent(),
            EndJourneyEvent(),
          ];
          final event = ConfirmClosePreviousAction(events);

          expect(
            event.toExecute,
            events,
          );
        },
      );

      test(
        'EmitNewActionStartedAndPreviousDoesNot should set newAction correctly',
        () {
          final newAction = StartJourneyEvent();
          final event =
              EmitNewActionStartedAndPreviousDoesNot(newAction: newAction);

          expect(
            event.newAction,
            newAction,
          );
        },
      );

      test(
        'EmitPreviousActionFinishedAndNewStarted should set newAction correctly',
        () {
          final newAction = StartJourneyEvent();
          final event =
              EmitPreviousActionFinishedAndNewStarted(newAction: newAction);

          expect(
            event.newAction,
            newAction,
          );
        },
      );

      test(
        'DoNothing should be a DoNothing',
        () {
          final event = DoNothing();

          expect(
            event,
            isA<DoNothing>(),
          );
        },
      );
    },
  );
}
