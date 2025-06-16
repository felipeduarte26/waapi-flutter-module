import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/presenter/bloc/drivers_journey/drivers_journey_bloc.dart';

void main() {
  group(
    'DriversJourneyState Tests',
    () {
      test(
        'InitialDriversJourneyState should be an instance of DriversJourneyState',
        () {
          expect(
            InitialDriversJourneyState(),
            isA<DriversJourneyState>(),
          );
        },
      );

      test(
        'LoadingDriversJourneyState should be an instance of DriversJourneyState',
        () {
          expect(
            LoadingDriversJourneyState(),
            isA<DriversJourneyState>(),
          );
        },
      );

      test(
        'NotStartedDriversJourneyState should be an instance of DriversJourneyState',
        () {
          expect(
            NotStartedDriversJourneyState(),
            isA<DriversJourneyState>(),
          );
        },
      );

      test(
        'RegisteringClockingEvent should be an instance of DriversJourneyState',
        () {
          expect(
            RegisteringClockingEvent(),
            isA<DriversJourneyState>(),
          );
        },
      );

      test(
        'CallingModalToStartJourneyFromAction should be an instance of DriversJourneyState',
        () {
          final state = CallingModalToStartJourneyFromAction(
            action: StartDrivingEvent(),
          );

          expect(
            state,
            isA<DriversJourneyState>(),
          );
          expect(
            state.action,
            isA<StartDrivingEvent>(),
          );
        },
      );

      test(
        'JourneyStartedBeforeAction should be an instance of DriversJourneyState',
        () {
          final state = JourneyStartedBeforeAction(
            action: StartDrivingEvent(),
          );

          expect(
            state,
            isA<DriversJourneyState>(),
          );
          expect(
            state.action,
            isA<StartDrivingEvent>(),
          );
        },
      );

      test(
        'ActionStartedWithoutJourney should be an instance of DriversJourneyState',
        () {
          final state = ActionStartedWithoutJourney(
            action: StartDrivingEvent(),
          );

          expect(
            state,
            isA<DriversJourneyState>(),
          );
          expect(
            state.action,
            isA<StartDrivingEvent>(),
          );
        },
      );

      test(
        'CallingModalToClosePrevious should be an instance of DriversJourneyState',
        () {
          final state = CallingModalToClosePrevious();

          expect(
            state,
            isA<DriversJourneyState>(),
          );
          expect(
            state.toClose,
            isNull,
          );
          expect(
            state.actual,
            isNull,
          );
        },
      );

      test(
        'StartNewDriverJourney should be an instance of DriversJourneyState',
        () {
          final state = StartNewDriverJourney();

          expect(
            state,
            isA<DriversJourneyState>(),
          );
          expect(
            state.toExecute,
            isNull,
          );
        },
      );

      test(
        'CallingModalToCloseActionBeforeEndJourney should be an instance of DriversJourneyState',
        () {
          final state = CallingModalToCloseActionBeforeEndJourney(
            action: StartDrivingEvent(),
          );

          expect(
            state,
            isA<DriversJourneyState>(),
          );
          expect(
            state.action,
            isA<StartDrivingEvent>(),
          );
        },
      );

      test(
        'JourneyFinishedAndPreviousActionDoesNot should be an instance of DriversJourneyState',
        () {
          final state = JourneyFinishedAndPreviousActionDoesNot(
            action: StartDrivingEvent(),
          );

          expect(
            state,
            isA<DriversJourneyState>(),
          );
          expect(
            state.action,
            isA<StartDrivingEvent>(),
          );
        },
      );

      test(
        'PreviousActionClosedAndJourneyEnded should be an instance of DriversJourneyState',
        () {
          final state = PreviousActionClosedAndJourneyEnded(
            action: StartDrivingEvent(),
          );

          expect(
            state,
            isA<DriversJourneyState>(),
          );
          expect(
            state.action,
            isA<StartDrivingEvent>(),
          );
        },
      );

      test(
        'CallingOvernight should be an instance of DriversJourneyState',
        () {
          final state = CallingOvernight();

          expect(
            state,
            isA<DriversJourneyState>(),
          );
          expect(
            state.actual,
            isNull,
          );
        },
      );

      test(
        'StartedDriversJourneyState should be an instance of DriversJourneyState',
        () {
          final dateTime = DateTime.now();
          final state = StartedDriversJourneyState(
            journeyStartedDateTime: dateTime,
            dateTimeOfLastStatusStarted: dateTime,
            driversJourneyEvent: null,
          );

          expect(
            state,
            isA<DriversJourneyState>(),
          );
          expect(
            state.isLoading,
            isFalse,
          );
          expect(
            state.journeyStartedDateTime,
            dateTime,
          );
          expect(
            state.dateTimeOfLastStatusStarted,
            dateTime,
          );
          expect(
            state.driversJourneyEvent,
            isNull,
          );
        },
      );

      test(
        'StartedDriversJourneyState copyWith should return a new instance with updated values',
        () {
          final dateTime = DateTime.now();
          final state = StartedDriversJourneyState(
            journeyStartedDateTime: dateTime,
            dateTimeOfLastStatusStarted: dateTime,
            driversJourneyEvent: null,
          );
          final newDateTime = dateTime.add(
            const Duration(
              hours: 1,
            ),
          );
          final newState = state.copyWith(
            isLoading: true,
            journeyStartedDateTime: newDateTime,
          );

          expect(
            newState.isLoading,
            isTrue,
          );
          expect(
            newState.journeyStartedDateTime,
            newDateTime,
          );
          expect(
            newState.dateTimeOfLastStatusStarted,
            dateTime,
          );
          expect(
            newState.driversJourneyEvent,
            isNull,
          );
        },
      );

      test(
        'NewActionStartedAndPreviousDoesNot should be an instance of DriversJourneyState',
        () {
          final state = NewActionStartedAndPreviousDoesNot(
            previousAction: StartDrivingEvent(),
            newAction: StartMandatoryBreakEvent(),
          );

          expect(
            state,
            isA<DriversJourneyState>(),
          );
          expect(
            state.previousAction,
            isA<StartDrivingEvent>(),
          );
          expect(
            state.newAction,
            isA<StartMandatoryBreakEvent>(),
          );
        },
      );

      test(
        'PreviousActionFinishedAndNewStarted should be an instance of DriversJourneyState',
        () {
          final state = PreviousActionFinishedAndNewStarted(
            previousAction: StartDrivingEvent(),
            newAction: StartMandatoryBreakEvent(),
          );

          expect(
            state,
            isA<DriversJourneyState>(),
          );
          expect(
            state.previousAction,
            isA<StartDrivingEvent>(),
          );
          expect(
            state.newAction,
            isA<StartMandatoryBreakEvent>(),
          );
        },
      );

      test(
        'ErrorDriversJourneyState should be an instance of DriversJourneyState',
        () {
          final state = ErrorDriversJourneyState(
            title: 'Error',
            subtitle: 'An error occurred',
          );

          expect(
            state,
            isA<DriversJourneyState>(),
          );
          expect(
            state.title,
            'Error',
          );
          expect(
            state.subtitle,
            'An error occurred',
          );
        },
      );
    },
  );
}
