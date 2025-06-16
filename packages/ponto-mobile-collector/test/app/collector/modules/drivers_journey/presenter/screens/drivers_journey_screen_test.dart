import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/journey_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/extension/string_extension.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/cubit/work_indicator/work_indicator_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/cubit/work_indicator/work_indicator_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/timer/timer_state.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/components/senior_button/components/components.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../mocks/clocking_event_mock.dart';

class MockRegisterClockingEventBloc extends MockBloc<RegisterClockingEventEvent, RegisterClockingState> implements RegisterClockingEventBloc {
  @override
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
}

class MockTimerBloc extends MockBloc<TimerEvent, TimerState> implements TimerBloc {}

class MockDriversJourneyBloc extends MockBloc<DriversJourneyEvent, DriversJourneyState> implements DriversJourneyBloc {
  @override
  bool get showDrivingButton => true;

  @override
  bool get showMandatoryBreakButton => true;

  @override
  bool get showWaitingButton => true;
}

class MockWorkIndicatorCubit extends Mock implements WorkIndicatorCubit {}

class MockShowBottomSheetUsecase extends Mock implements IShowBottomSheetUsecase {}

class MockUtils extends Mock implements IUtils {}

class MockNavigatorService extends Mock implements NavigatorService {}

class FakeBuildContext extends Fake implements BuildContext {}

class MockBuildContext extends Mock implements BuildContext {}

class FakeClockingEvent extends Fake implements ClockingEvent {}

class MockFacialRegistrationMessageWidget extends Mock implements FacialRegistrationMessageWidget {}

class MockConfirmationSnackbarWidget extends Mock implements ConfirmationSnackbarWidget {}

class MockClockingEventBloc extends MockBloc<ClockingEventEvent, ClockingEventBaseState> implements ClockingEventBloc {}

void main() {
  late RegisterClockingEventBloc registerClockingEventBloc;
  late TimerBloc timerBloc;
  late DriversJourneyBloc driversJourneyBloc;
  late WorkIndicatorCubit mockWorkIndicatorCubit;
  late IShowBottomSheetUsecase showBottomSheetUsecase;
  late IUtils utils;
  late NavigatorService navigatorService;
  late BuildContext buildContext;
  late ClockingEventBloc clockingEventBloc;
  late ConfirmationSnackbarWidget confirmationSnackbarWidget;
  late MockFacialRegistrationMessageWidget mockFacialRegistrationMessageWidget;

  final day = DateTime(2023, 4, 27, 10, 15, 33);
  final currentJourney = JourneyEntity(
    id: 'journeyId',
    employeeId: 'employeeId',
    startDate: day,
  );

  const locale = Locale('en');
  final collectorLocalizations = lookupCollectorLocalizations(locale);

  Widget getWidget(String locale) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: Locale(locale),
          child: Scaffold(
            body: DriversJourneyScreen(
              confirmationSnackbarWidget: confirmationSnackbarWidget,
              registerClockingEventBloc: registerClockingEventBloc,
              timerBloc: timerBloc,
              driversJourneyBloc: driversJourneyBloc,
              workIndicatorCubit: mockWorkIndicatorCubit,
              showBottomSheetUsecase: showBottomSheetUsecase,
              utils: utils,
              navigatorService: navigatorService,
              showNotificationButton: true,
              clockingEventBloc: clockingEventBloc,
              facialRegistrationMessageWidget: mockFacialRegistrationMessageWidget,
            ),
          ),
        ),
      ),
    );
  }

  setUpAll(() {
    registerFallbackValue(FakeClockingEvent());
  });

  setUp(
    () {
      registerClockingEventBloc = MockRegisterClockingEventBloc();
      timerBloc = MockTimerBloc();
      driversJourneyBloc = MockDriversJourneyBloc();
      mockWorkIndicatorCubit = MockWorkIndicatorCubit();
      showBottomSheetUsecase = MockShowBottomSheetUsecase();
      utils = MockUtils();
      navigatorService = MockNavigatorService();
      buildContext = FakeBuildContext();
      clockingEventBloc = MockClockingEventBloc();
      confirmationSnackbarWidget = MockConfirmationSnackbarWidget();
      mockFacialRegistrationMessageWidget = MockFacialRegistrationMessageWidget();

      registerFallbackValue(buildContext);

      when(
        () => utils.getDateTimePattern(
          localeName: collectorLocalizations.localeName,
        ),
      ).thenReturn('yyyy/MM/dd HH:mm');

      when(() => registerClockingEventBloc.state).thenReturn(SuccessRegisterState(clockingEvent: clockingEventMock));

      when(() => mockWorkIndicatorCubit.stream).thenAnswer(
        (_) => StreamController<WorkIndicatorState>().stream,
      );

      when(
        () => timerBloc.state,
      ).thenReturn(
        TimerClockState(
          dateTime: day,
        ),
      );

      when(
        () => timerBloc.lastDateTime,
      ).thenReturn(
        day,
      );

      when(
        () => registerClockingEventBloc.state,
      ).thenReturn(
        SuccessRegisterState(clockingEvent: clockingEventMock),
      );

      when(
        () => driversJourneyBloc.state,
      ).thenReturn(
        InitialDriversJourneyState(),
      );

      when(
        () => driversJourneyBloc.totalBreaks,
      ).thenReturn(
        0,
      );

      when(
        () => mockWorkIndicatorCubit.state,
      ).thenReturn(WorkIndicatorUpdate());

      when(
        () => mockWorkIndicatorCubit.isWorkInProgress,
      ).thenReturn(false);

      when(
        () => mockFacialRegistrationMessageWidget.show(
          clockingEventUse: any(named: 'clockingEventUse'),
        ),
      ).thenAnswer(
        (_) async => {},
      );
    },
  );

  group(
    'Snackbar',
    () {
      testWidgets(
        'Confirm snackbar',
        (tester) async {
          const locale = Locale('en');

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );
          await tester.pumpWidget(widget);

          verifyNever(
            () => confirmationSnackbarWidget.show(
              clockingEvent: clockingEventMock,
              duration: const Duration(seconds: 3),
            ),
          );
        },
      );
    },
  );

  group(
    'BottomSheet test',
    () {
      testWidgets(
        'Status explanation test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          final context = MockBuildContext();
          final content = [
            const StatusExplanationWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SeniorSpacing.normal,
              ),
              child: SeniorButton(
                fullWidth: true,
                outlined: true,
                label: collectorLocalizations.close,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ];

          registerFallbackValue(context);
          registerFallbackValue(content);

          when(
            () => showBottomSheetUsecase.call(
              content: any(named: 'content'),
              context: any(named: 'context'),
            ),
          ).thenAnswer(
            (_) => Future.value(null),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final solidCircleQuestionIconFinder = find.byIcon(
            FontAwesomeIcons.solidCircleQuestion,
          );

          expect(
            solidCircleQuestionIconFinder,
            findsOneWidget,
          );

          await tester.tap(solidCircleQuestionIconFinder);
          await tester.pump();
        },
      );

      testWidgets(
        'Info icon button for pauses test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);
          const totalBreaks = 1;

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );
          when(
            () => driversJourneyBloc.totalBreaks,
          ).thenReturn(
            totalBreaks,
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: StartLunchEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final context = MockBuildContext();
          final content = [
            Align(
              alignment: Alignment.centerLeft,
              child: SeniorText.labelBold(
                collectorLocalizations.breaks,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SeniorText.body(
              collectorLocalizations.breaksInfo,
            ),
            const SizedBox(
              height: 15,
            ),
            SeniorButton.ghost(
              fullWidth: true,
              label: collectorLocalizations.infoUnderstoodButton,
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(
              height: 15,
            ),
          ];

          registerFallbackValue(context);
          registerFallbackValue(content);

          when(
            () => showBottomSheetUsecase.call(
              content: any(named: 'content'),
              context: any(named: 'context'),
            ),
          ).thenAnswer(
            (_) => Future.value(null),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final circleInfoButton = find.descendant(
            of: find.widgetWithText(
              JourneyInfoWidget,
              collectorLocalizations.numberOfPauses,
            ),
            matching: find.byIcon(
              FontAwesomeIcons.circleInfo,
            ),
          );

          expect(
            circleInfoButton,
            findsOneWidget,
          );

          await tester.tap(circleInfoButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Info icon button for total worked test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.currentJourney,
          ).thenReturn(
            currentJourney,
          );

          when(
            () => driversJourneyBloc.getTotalWorkedAtMoment(
              any(),
            ),
          ).thenReturn(
            const Duration(seconds: 30),
          );

          when(
            () => utils.getHourMinuteSecondFromDuration(
              const Duration(seconds: 30),
            ),
          ).thenReturn(
            '00:00:30',
          );

          when(
            () => driversJourneyBloc.isOddClockingEvents,
          ).thenReturn(
            false,
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: StartDrivingEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final context = MockBuildContext();
          final content = [
            Align(
              alignment: Alignment.centerLeft,
              child: SeniorText.labelBold(
                collectorLocalizations.totalWorked,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SeniorText.body(
              collectorLocalizations.totalWorkedInfo,
            ),
            const SizedBox(
              height: 15,
            ),
            SeniorButton.ghost(
              fullWidth: true,
              label: collectorLocalizations.infoUnderstoodButton,
              onPressed: () => Navigator.pop(
                context,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ];

          registerFallbackValue(context);
          registerFallbackValue(content);

          when(
            () => showBottomSheetUsecase.call(
              content: any(named: 'content'),
              context: any(named: 'context'),
            ),
          ).thenAnswer(
            (_) => Future.value(null),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final circleInfoButton = find.descendant(
            of: find.widgetWithText(
              JourneyInfoWidget,
              collectorLocalizations.totalWorked,
            ),
            matching: find.byIcon(
              FontAwesomeIcons.circleInfo,
            ),
          );

          expect(
            circleInfoButton,
            findsOneWidget,
          );

          await tester.tap(circleInfoButton);
          await tester.pump();
        },
      );
    },
  );

  group(
    'Icons and labels from work status',
    () {
      testWidgets(
        'Header icons test',
        (tester) async {
          const locale = Locale('en');

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );
          await tester.pumpWidget(widget);

          expect(
            find.byIcon(
              FontAwesomeIcons.solidCircleQuestion,
            ),
            findsOneWidget,
          );

          final solidBellIconFinder = find.byIcon(
            FontAwesomeIcons.solidBell,
          );

          expect(
            solidBellIconFinder,
            findsOneWidget,
          );

          await tester.tap(solidBellIconFinder);
          await tester.pump();
        },
      );

      testWidgets(
        'Not Started status test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            NotStartedDriversJourneyState(),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.byIcon(
              DriversWorkStatusEnum.notStarted.icon,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.notStarted,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'When driversJourneyEvent is null test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);
          final dateTimePattern = Utils().getDateTimePattern(
            localeName: collectorLocalizations.localeName,
          );
          const totalWorkedDuration = Duration(
            seconds: 30,
          );

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            dateTimePattern,
          );

          when(
            () => driversJourneyBloc.currentJourney,
          ).thenReturn(
            currentJourney,
          );

          when(
            () => driversJourneyBloc.getTotalWorkedAtMoment(
              any(),
            ),
          ).thenReturn(
            totalWorkedDuration,
          );

          when(
            () => utils.getHourMinuteSecondFromDuration(
              totalWorkedDuration,
            ),
          ).thenReturn(
            '00:00:30',
          );

          when(
            () => driversJourneyBloc.totalTimeSinceLastJourneyUseCase,
          ).thenReturn(
            const Duration(days: 1, hours: 1, minutes: 30),
          );

          when(
            () => driversJourneyBloc.isOddClockingEvents,
          ).thenReturn(
            true,
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: null,
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            (driversJourneyBloc.state as StartedDriversJourneyState).driversJourneyEvent,
            isNull,
          );
        },
      );

      testWidgets(
        'Widget visible by state test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            RegisteringClockingEvent(),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.loading,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Start Journey button test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            NotStartedDriversJourneyState(),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final startJourneyButton = find.text(
            collectorLocalizations.startJourney,
          );
          expect(
            startJourneyButton,
            findsOneWidget,
          );

          await tester.tap(startJourneyButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Time started journey test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);
          final dateTimePattern = Utils().getDateTimePattern(
            localeName: collectorLocalizations.localeName,
          );
          const totalWorkedDuration = Duration(
            seconds: 30,
          );

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            dateTimePattern,
          );

          when(
            () => driversJourneyBloc.currentJourney,
          ).thenReturn(
            currentJourney,
          );

          when(
            () => driversJourneyBloc.totalTimeSinceLastJourneyUseCase,
          ).thenReturn(
            const Duration(days: 1, hours: 1, minutes: 30),
          );

          when(
            () => driversJourneyBloc.getTotalWorkedAtMoment(
              any(),
            ),
          ).thenReturn(
            totalWorkedDuration,
          );

          when(
            () => utils.getHourMinuteSecondFromDuration(
              totalWorkedDuration,
            ),
          ).thenReturn(
            '00:00:30',
          );

          when(
            () => driversJourneyBloc.isOddClockingEvents,
          ).thenReturn(
            true,
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: StartJourneyEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final timeStartedJourney = find.descendant(
            of: find.widgetWithText(
              JourneyInfoWidget,
              collectorLocalizations.journeyStart,
            ),
            matching: find.text(
              DateFormat(
                dateTimePattern,
              ).format(
                currentJourney.startDate,
              ),
            ),
          );

          expect(
            timeStartedJourney,
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Start journey by Start Driving button test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            NotStartedDriversJourneyState(),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final startDrivingButton = find.text(
            collectorLocalizations.startDrivingWithLineBreak,
          );
          expect(
            startDrivingButton,
            findsOneWidget,
          );

          when(() => driversJourneyBloc.driverEventInExecution).thenReturn(StartJourneyEvent());

          await tester.tap(startDrivingButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Working status test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: StartJourneyEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.byIcon(
              DriversWorkStatusEnum.working.icon,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.working,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Start Driving button test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: StartJourneyEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final startDrivingButton = find.text(
            collectorLocalizations.startDrivingWithLineBreak,
          );
          expect(
            startDrivingButton,
            findsOneWidget,
          );
          when(() => driversJourneyBloc.driverEventInExecution).thenReturn(StartJourneyEvent());
          await tester.tap(startDrivingButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Driving status test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: StartDrivingEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.byIcon(
              DriversWorkStatusEnum.driving.icon,
            ),
            findsWidgets,
          );

          expect(
            find.text(
              collectorLocalizations.driving,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Start Mandatory Break button test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: StartDrivingEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final startMandatoryBreakButton = find.text(
            collectorLocalizations.startMandatoryBreakWithLineBreak,
          );
          expect(
            startMandatoryBreakButton,
            findsOneWidget,
          );
          when(() => driversJourneyBloc.driverEventInExecution).thenReturn(StartJourneyEvent());

          await tester.tap(startMandatoryBreakButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Mandatory Break status test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: StartMandatoryBreakEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.byIcon(
              DriversWorkStatusEnum.mandatoryBreak.icon,
            ),
            findsWidgets,
          );

          expect(
            find.text(
              collectorLocalizations.mandatoryBreak,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Start Waiting button test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: StartMandatoryBreakEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final startWaitingButton = find.text(
            collectorLocalizations.startWaitingWithLineBreak,
          );
          expect(
            startWaitingButton,
            findsOneWidget,
          );

          final scrollablesFinder = find.descendant(
            of: find.byKey(
              const Key(
                'main_scrollable',
              ),
            ),
            matching: find.byType(
              Scrollable,
            ),
          );

          await tester.scrollUntilVisible(
            startWaitingButton,
            500,
            scrollable: scrollablesFinder.first,
          );
          when(() => driversJourneyBloc.driverEventInExecution).thenReturn(StartJourneyEvent());
          await tester.tap(startWaitingButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Waiting status test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: StartWaitingBreakEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.byIcon(
              DriversWorkStatusEnum.waiting.icon,
            ),
            findsWidgets,
          );

          expect(
            find.text(
              collectorLocalizations.waiting,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Start Food Time button test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: StartWaitingBreakEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final startFoodTimeButton = find.text(
            collectorLocalizations.startFoodTimeWithLineBreak,
          );
          expect(
            startFoodTimeButton,
            findsOneWidget,
          );

          final scrollablesFinder = find.descendant(
            of: find.byKey(
              const Key(
                'main_scrollable',
              ),
            ),
            matching: find.byType(
              Scrollable,
            ),
          );

          await tester.scrollUntilVisible(
            startFoodTimeButton,
            500,
            scrollable: scrollablesFinder.first,
          );
          when(() => driversJourneyBloc.driverEventInExecution).thenReturn(StartJourneyEvent());

          await tester.tap(startFoodTimeButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Food Time status test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: StartLunchEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.byIcon(
              DriversWorkStatusEnum.foodTime.icon,
            ),
            findsWidgets,
          );

          expect(
            find.text(
              collectorLocalizations.foodTime,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Total of pauses test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);
          const totalBreaks = 2;

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.totalBreaks,
          ).thenReturn(
            totalBreaks,
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: StartLunchEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          expect(
            find.text(
              collectorLocalizations.numberOfPauses,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              totalBreaks.toString(),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'New Journey button test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: StartJourneyEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final newJourneyButton = find.text(
            collectorLocalizations.newJourney,
          );
          expect(
            newJourneyButton,
            findsOneWidget,
          );

          await tester.tap(newJourneyButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Just finish journey test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          when(
            () => driversJourneyBloc.state,
          ).thenReturn(
            StartedDriversJourneyState(
              driversJourneyEvent: StartJourneyEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final finishJourneyButton = find.byWidgetPredicate(
            (widget) => widget is SeniorButton && widget.danger == true && widget.label == collectorLocalizations.finishJourney,
          );
          expect(
            finishJourneyButton,
            findsOneWidget,
          );

          final scrollablesFinder = find.descendant(
            of: find.byKey(
              const Key(
                'main_scrollable',
              ),
            ),
            matching: find.byType(
              Scrollable,
            ),
          );

          await tester.scrollUntilVisible(
            finishJourneyButton,
            500,
            scrollable: scrollablesFinder.first,
          );

          await tester.tap(finishJourneyButton);
          await tester.pump();
        },
      );
    },
  );

  group(
    'Pop-Ups tests',
    () {
      testWidgets(
        'Closing actions pop up by timer test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                NewActionStartedAndPreviousDoesNot(
                  previousAction: StartDrivingEvent(),
                  newAction: StartMandatoryBreakEvent(),
                ),
              ],
            ),
            initialState: CallingModalToClosePrevious(
              toClose: StartDrivingEvent(),
              actual: StartMandatoryBreakEvent(),
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.info,
            ),
            findsOneWidget,
          );

          await tester.pump(const Duration(seconds: 10));

          expect(
            find.text(
              collectorLocalizations.info,
            ),
            findsNothing,
          );
        },
      );

      testWidgets(
        'Closing actions pop up by close button test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                CallingModalToClosePrevious(
                  toClose: StartDrivingEvent(),
                  actual: StartMandatoryBreakEvent(),
                ),
              ],
            ),
            initialState: StartedDriversJourneyState(
              driversJourneyEvent: StartDrivingEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final startMandatoryBreakButton = find.text(
            collectorLocalizations.startMandatoryBreakWithLineBreak,
          );
          expect(
            startMandatoryBreakButton,
            findsOneWidget,
          );

          await tester.tap(
            startMandatoryBreakButton,
            warnIfMissed: false,
          );
          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.continueRegistration,
            ),
            findsOneWidget,
          );

          final closePopUpButton = find.byIcon(
            FontAwesomeIcons.x,
          );
          expect(
            closePopUpButton,
            findsOneWidget,
          );

          await tester.tap(closePopUpButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Closing pop up by close button when start journey from action test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                CallingModalToStartJourneyFromAction(
                  action: StartDrivingEvent(),
                ),
              ],
            ),
            initialState: NotStartedDriversJourneyState(),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final startDrivingButton = find.text(
            collectorLocalizations.startDrivingWithLineBreak,
          );
          expect(
            startDrivingButton,
            findsOneWidget,
          );

          await tester.tap(
            startDrivingButton,
            warnIfMissed: false,
          );
          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.wantToStartJourney,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.startJourneyBeforeStartAction(
                collectorLocalizations.drive.toLowerCase(),
              ),
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.no,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.yes,
            ),
            findsOneWidget,
          );

          final closePopUpButton = find.byIcon(
            FontAwesomeIcons.x,
          );
          expect(
            closePopUpButton,
            findsOneWidget,
          );

          await tester.tap(closePopUpButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Starting journey by action test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                CallingModalToStartJourneyFromAction(
                  action: StartDrivingEvent(),
                ),
              ],
            ),
            initialState: NotStartedDriversJourneyState(),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final startDrivingButton = find.text(
            collectorLocalizations.startDrivingWithLineBreak,
          );
          expect(
            startDrivingButton,
            findsOneWidget,
          );

          await tester.tap(
            startDrivingButton,
            warnIfMissed: false,
          );
          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.wantToStartJourney,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.startJourneyBeforeStartAction(
                collectorLocalizations.drive.toLowerCase(),
              ),
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.no,
            ),
            findsOneWidget,
          );

          final startJourneyBeforeActionButton = find.text(
            collectorLocalizations.yes,
          );
          expect(
            startJourneyBeforeActionButton,
            findsOneWidget,
          );

          await tester.tap(startJourneyBeforeActionButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Starting action but journey does not test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                CallingModalToStartJourneyFromAction(
                  action: StartDrivingEvent(),
                ),
              ],
            ),
            initialState: NotStartedDriversJourneyState(),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final startDrivingButton = find.text(
            collectorLocalizations.startDrivingWithLineBreak,
          );
          expect(
            startDrivingButton,
            findsOneWidget,
          );

          await tester.tap(
            startDrivingButton,
            warnIfMissed: false,
          );
          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.wantToStartJourney,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.startJourneyBeforeStartAction(
                collectorLocalizations.drive.toLowerCase(),
              ),
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.yes,
            ),
            findsOneWidget,
          );

          final startActionOnlyButton = find.text(
            collectorLocalizations.no,
          );
          expect(
            startActionOnlyButton,
            findsOneWidget,
          );

          await tester.tap(startActionOnlyButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Info journey and action started test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                JourneyStartedBeforeAction(
                  action: StartDrivingEvent(),
                ),
              ],
            ),
            initialState: CallingModalToStartJourneyFromAction(
              action: StartDrivingEvent(),
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.info,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations
                  .journeyStartedBeforeAction(
                    collectorLocalizations.drive.toLowerCase(),
                  )
                  .capitalize(),
            ),
            findsOneWidget,
          );

          final okButton = find.text(
            collectorLocalizations.ok,
          );
          expect(
            okButton,
            findsOneWidget,
          );

          await tester.tap(okButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Info action started without journey test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                ActionStartedWithoutJourney(
                  action: StartDrivingEvent(),
                ),
              ],
            ),
            initialState: CallingModalToStartJourneyFromAction(
              action: StartDrivingEvent(),
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.info,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations
                  .actionStartedWithoutJourney(
                    collectorLocalizations.drive.toLowerCase(),
                  )
                  .capitalize(),
            ),
            findsOneWidget,
          );

          final okButton = find.text(
            collectorLocalizations.ok,
          );
          expect(
            okButton,
            findsOneWidget,
          );

          await tester.tap(okButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Stop current action and start another action test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                CallingModalToClosePrevious(
                  toClose: StartDrivingEvent(),
                  actual: StartMandatoryBreakEvent(),
                ),
              ],
            ),
            initialState: StartedDriversJourneyState(
              driversJourneyEvent: StartDrivingEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final startMandatoryBreakButton = find.text(
            collectorLocalizations.startMandatoryBreakWithLineBreak,
          );
          expect(
            startMandatoryBreakButton,
            findsOneWidget,
          );

          await tester.tap(
            startMandatoryBreakButton,
            warnIfMissed: false,
          );
          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.continueRegistration,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.finishCurrentActionBeforeStartNextAction(
                collectorLocalizations.drive.toLowerCase(),
                collectorLocalizations.mandatoryBreak.toLowerCase(),
              ),
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.no,
            ),
            findsOneWidget,
          );

          final finishCurrentActionButton = find.text(
            collectorLocalizations.yes,
          );
          expect(
            finishCurrentActionButton,
            findsOneWidget,
          );

          await tester.tap(finishCurrentActionButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Start action when other is running test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                CallingModalToClosePrevious(
                  toClose: StartWaitingBreakEvent(),
                  actual: StartLunchEvent(),
                ),
              ],
            ),
            initialState: StartedDriversJourneyState(
              driversJourneyEvent: StartWaitingBreakEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final startLunchButton = find.text(
            collectorLocalizations.startFoodTimeWithLineBreak,
          );
          expect(
            startLunchButton,
            findsOneWidget,
          );

          await tester.tap(
            startLunchButton,
            warnIfMissed: false,
          );
          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.continueRegistration,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.finishCurrentActionBeforeStartNextAction(
                collectorLocalizations.waiting.toLowerCase(),
                collectorLocalizations.foodTime.toLowerCase(),
              ),
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.yes,
            ),
            findsOneWidget,
          );

          final startNextActionButton = find.text(
            collectorLocalizations.no,
          );
          expect(
            startNextActionButton,
            findsOneWidget,
          );

          await tester.tap(startNextActionButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Info new action started and previous does not test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                NewActionStartedAndPreviousDoesNot(
                  previousAction: StartDrivingEvent(),
                  newAction: StartMandatoryBreakEvent(),
                ),
              ],
            ),
            initialState: CallingModalToClosePrevious(
              toClose: StartDrivingEvent(),
              actual: StartMandatoryBreakEvent(),
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.info,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations
                  .newActionStartedAndPreviousDoesNot(
                    collectorLocalizations.mandatoryBreak.toLowerCase(),
                    collectorLocalizations.drive.toLowerCase(),
                  )
                  .capitalize(),
            ),
            findsOneWidget,
          );

          final okButton = find.text(
            collectorLocalizations.ok,
          );
          expect(
            okButton,
            findsOneWidget,
          );

          await tester.tap(okButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Info previous action finished and new started test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                PreviousActionFinishedAndNewStarted(
                  previousAction: StartDrivingEvent(),
                  newAction: StartMandatoryBreakEvent(),
                ),
              ],
            ),
            initialState: CallingModalToClosePrevious(
              toClose: StartDrivingEvent(),
              actual: StartMandatoryBreakEvent(),
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.info,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations
                  .previousActionFinishedAndNewStarted(
                    collectorLocalizations.drive.toLowerCase(),
                    collectorLocalizations.mandatoryBreak.toLowerCase(),
                  )
                  .capitalize(),
            ),
            findsOneWidget,
          );

          final okButton = find.text(
            collectorLocalizations.ok,
          );
          expect(
            okButton,
            findsOneWidget,
          );

          await tester.tap(okButton);
          await tester.pump();
        },
      );

      testWidgets(
        'No start new journey when other is running test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                StartNewDriverJourney(
                  toExecute: StartJourneyEvent(
                    force: true,
                  ),
                ),
              ],
            ),
            initialState: StartedDriversJourneyState(
              driversJourneyEvent: StartJourneyEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final newJourneyButton = find.text(
            collectorLocalizations.newJourney,
          );
          expect(
            newJourneyButton,
            findsOneWidget,
          );

          await tester.tap(
            newJourneyButton,
            warnIfMissed: false,
          );
          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.sureStartNewJourney,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.previousJourneyStillRunning,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.yes,
            ),
            findsOneWidget,
          );

          final noButton = find.text(
            collectorLocalizations.no,
          );
          expect(
            noButton,
            findsOneWidget,
          );

          await tester.tap(noButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Start new journey when other is running test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                StartNewDriverJourney(
                  toExecute: StartJourneyEvent(
                    force: true,
                  ),
                ),
              ],
            ),
            initialState: StartedDriversJourneyState(
              driversJourneyEvent: StartJourneyEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final newJourneyButton = find.text(
            collectorLocalizations.newJourney,
          );
          expect(
            newJourneyButton,
            findsOneWidget,
          );

          await tester.tap(
            newJourneyButton,
            warnIfMissed: false,
          );
          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.sureStartNewJourney,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.previousJourneyStillRunning,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.no,
            ),
            findsOneWidget,
          );

          final yesButton = find.text(
            collectorLocalizations.yes,
          );
          expect(
            yesButton,
            findsOneWidget,
          );

          await tester.tap(yesButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Closing pop up by close button when ending journey with action running test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                CallingModalToCloseActionBeforeEndJourney(
                  action: StartDrivingEvent(),
                ),
              ],
            ),
            initialState: StartedDriversJourneyState(
              driversJourneyEvent: StartDrivingEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final finishJourneyButton = find.byWidgetPredicate(
            (widget) => widget is SeniorButton && widget.danger == true && widget.label == collectorLocalizations.finishJourney,
          );
          expect(
            finishJourneyButton,
            findsOneWidget,
          );

          await tester.tap(
            finishJourneyButton,
            warnIfMissed: false,
          );
          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.continueRegistration,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.closeActionBeforeEndJourney(
                collectorLocalizations.drive.toLowerCase(),
              ),
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.no,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.yes,
            ),
            findsOneWidget,
          );

          final closePopUpButton = find.byIcon(
            FontAwesomeIcons.x,
          );
          expect(
            closePopUpButton,
            findsOneWidget,
          );

          await tester.tap(closePopUpButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Closing action and ending journey test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                CallingModalToCloseActionBeforeEndJourney(
                  action: StartDrivingEvent(),
                ),
              ],
            ),
            initialState: StartedDriversJourneyState(
              driversJourneyEvent: StartDrivingEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final finishJourneyButton = find.byWidgetPredicate(
            (widget) => widget is SeniorButton && widget.danger == true && widget.label == collectorLocalizations.finishJourney,
          );
          expect(
            finishJourneyButton,
            findsOneWidget,
          );

          await tester.tap(
            finishJourneyButton,
            warnIfMissed: false,
          );
          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.continueRegistration,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.closeActionBeforeEndJourney(
                collectorLocalizations.drive.toLowerCase(),
              ),
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.no,
            ),
            findsOneWidget,
          );

          final closeActionBeforeEndJourney = find.text(
            collectorLocalizations.yes,
          );
          expect(
            closeActionBeforeEndJourney,
            findsOneWidget,
          );

          await tester.tap(closeActionBeforeEndJourney);
          await tester.pump();
        },
      );

      testWidgets(
        'Ending journey without action test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                CallingModalToCloseActionBeforeEndJourney(
                  action: StartDrivingEvent(),
                ),
              ],
            ),
            initialState: StartedDriversJourneyState(
              driversJourneyEvent: StartDrivingEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final finishJourneyButton = find.byWidgetPredicate(
            (widget) => widget is SeniorButton && widget.danger == true && widget.label == collectorLocalizations.finishJourney,
          );
          expect(
            finishJourneyButton,
            findsOneWidget,
          );

          await tester.tap(
            finishJourneyButton,
            warnIfMissed: false,
          );
          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.continueRegistration,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.closeActionBeforeEndJourney(
                collectorLocalizations.drive.toLowerCase(),
              ),
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.yes,
            ),
            findsOneWidget,
          );

          final endJourneyWithoutAction = find.text(
            collectorLocalizations.no,
          );
          expect(
            endJourneyWithoutAction,
            findsOneWidget,
          );

          await tester.tap(endJourneyWithoutAction);
          await tester.pump();
        },
      );

      testWidgets(
        'Info action closed and journey ended test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                PreviousActionClosedAndJourneyEnded(
                  action: StartDrivingEvent(),
                ),
              ],
            ),
            initialState: CallingModalToCloseActionBeforeEndJourney(
              action: StartDrivingEvent(),
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.info,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations
                  .previousActionClosedAndJourneyEnded(
                    collectorLocalizations.drive.toLowerCase(),
                  )
                  .capitalize(),
            ),
            findsOneWidget,
          );

          final okButton = find.text(
            collectorLocalizations.ok,
          );
          expect(
            okButton,
            findsOneWidget,
          );

          await tester.tap(okButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Info journey finished without action test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                JourneyFinishedAndPreviousActionDoesNot(
                  action: StartDrivingEvent(),
                ),
              ],
            ),
            initialState: CallingModalToCloseActionBeforeEndJourney(
              action: StartDrivingEvent(),
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.info,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations
                  .journeyFinishedAndPreviousActionDoesNot(
                    collectorLocalizations.drive.toLowerCase(),
                  )
                  .capitalize(),
            ),
            findsOneWidget,
          );

          final okButton = find.text(
            collectorLocalizations.ok,
          );
          expect(
            okButton,
            findsOneWidget,
          );

          await tester.tap(okButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Closing overnight pop up by close button test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                CallingOvernight(),
              ],
            ),
            initialState: StartedDriversJourneyState(
              driversJourneyEvent: StartJourneyEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final finishJourneyButton = find.byWidgetPredicate(
            (widget) => widget is SeniorButton && widget.danger == true && widget.label == collectorLocalizations.finishJourney,
          );
          expect(
            finishJourneyButton,
            findsOneWidget,
          );

          await tester.tap(
            finishJourneyButton,
            warnIfMissed: false,
          );
          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.wantRegisterOvernight,
            ),
            findsOneWidget,
          );

          final closePopUpButton = find.byIcon(
            FontAwesomeIcons.x,
          );
          expect(
            closePopUpButton,
            findsOneWidget,
          );

          await tester.tap(closePopUpButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Finish journey without overnight test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                CallingOvernight(),
              ],
            ),
            initialState: StartedDriversJourneyState(
              driversJourneyEvent: StartJourneyEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final finishJourneyButton = find.byWidgetPredicate(
            (widget) => widget is SeniorButton && widget.danger == true && widget.label == collectorLocalizations.finishJourney,
          );
          expect(
            finishJourneyButton,
            findsOneWidget,
          );

          await tester.tap(
            finishJourneyButton,
            warnIfMissed: false,
          );
          await tester.pump();

          expect(
            find.text(
              collectorLocalizations.wantRegisterOvernight,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.reportOvernightAfterJourney,
            ),
            findsOneWidget,
          );

          expect(
            find.text(
              collectorLocalizations.registerOvernight,
            ),
            findsOneWidget,
          );

          final confirmFinishJourneyButton = find.byWidgetPredicate(
            (widget) => widget is SeniorButtonGhost && widget.label == collectorLocalizations.finishJourney,
          );
          expect(
            confirmFinishJourneyButton,
            findsOneWidget,
          );

          await tester.tap(confirmFinishJourneyButton);
          await tester.pump();
        },
      );

      testWidgets(
        'Finish journey with overnight test',
        (tester) async {
          const locale = Locale('en');
          final collectorLocalizations = lookupCollectorLocalizations(locale);

          when(
            () => utils.getDateTimePattern(
              localeName: locale.languageCode,
            ),
          ).thenReturn(
            Utils().getDateTimePattern(
              localeName: locale.languageCode,
            ),
          );

          whenListen(
            driversJourneyBloc,
            Stream.fromIterable(
              [
                CallingOvernight(),
              ],
            ),
            initialState: StartedDriversJourneyState(
              driversJourneyEvent: StartJourneyEvent(),
              journeyStartedDateTime: day,
              dateTimeOfLastStatusStarted: day,
            ),
          );

          final widget = getWidget(
            locale.languageCode,
          );

          await tester.pumpWidget(widget);

          final finishJourneyButton = find.byWidgetPredicate(
            (widget) => widget is SeniorButton && widget.danger == true && widget.label == collectorLocalizations.finishJourney,
          );
          expect(
            finishJourneyButton,
            findsOneWidget,
          );

          await tester.tap(
            finishJourneyButton,
            warnIfMissed: false,
          );
          await tester.pump();

          expect(
            find.byWidgetPredicate(
              (widget) => widget is SeniorButtonGhost && widget.label == collectorLocalizations.finishJourney,
            ),
            findsOneWidget,
          );

          final registerOvernightButton = find.text(
            collectorLocalizations.registerOvernight,
          );
          expect(
            registerOvernightButton,
            findsOneWidget,
          );

          await tester.tap(registerOvernightButton);
          await tester.pump();
        },
      );

      testWidgets('should display error state correctly', (WidgetTester tester) async {
        const locale = Locale('en');

        final errorState = ErrorDriversJourneyState(
          title: 'Error Title',
          subtitle: 'Error Subtitle',
        );
        when(() => driversJourneyBloc.state).thenReturn(errorState);

        final widget = getWidget(
          locale.languageCode,
        );

        await tester.pumpWidget(widget);

        expect(
          find.byIcon(FontAwesomeIcons.triangleExclamation),
          findsOneWidget,
        );
        expect(find.text('Error Title'), findsOneWidget);
        expect(find.text('Error Subtitle'), findsOneWidget);

        final backHomeButton = find.text('Back home');

        expect(backHomeButton, findsOneWidget);

        await tester.tap(backHomeButton);
        await tester.pump();
      });

      testWidgets('IconButton should add LoadClockingEventEvent and call pop on NavigatorService', (WidgetTester tester) async {
        const locale = Locale('en');
        final widget = getWidget(
          locale.languageCode,
        );
        await tester.pumpWidget(widget);

        await tester.tap(find.byIcon(FontAwesomeIcons.angleLeft));
        await tester.pump();

        verify(() => navigatorService.pop()).called(1);
      });

      testWidgets(
        'Should show error message when state is ErrorDriversJourneyState',
        (tester) async {
          const locale = Locale('en');
          when(() => driversJourneyBloc.state).thenReturn(
            ErrorDriversJourneyState(
              title: 'Test Error',
              subtitle: 'Test Error Subtitle',
            ),
          );

          final widget = getWidget(locale.languageCode);
          await tester.pumpWidget(widget);

          expect(find.text('Test Error'), findsOneWidget);
          expect(find.text('Test Error Subtitle'), findsOneWidget);
        },
      );

      testWidgets(
        'Should display overnight modal when state is CallingOvernight',
        (tester) async {
          whenListen(
            driversJourneyBloc,
            Stream.fromIterable([
              CallingOvernight(),
            ]),
            initialState: CallingOvernight(), // Garante que o estado inicial já é o esperado
          );

          final widget = getWidget(locale.languageCode);
          await tester.pumpWidget(widget);
          await tester.pump(); // Adiciona um pump extra para garantir renderização

          expect(
            find.text(collectorLocalizations.wantRegisterOvernight),
            findsOneWidget,
          );
        },
      );

      testWidgets('Should show snackbar when register event succeeds', (tester) async {
        when(
          () => confirmationSnackbarWidget.show(
            clockingEvent: any(named: 'clockingEvent'),
            duration: any(named: 'duration'),
          ),
        ).thenAnswer((_) async {});

        whenListen(
          registerClockingEventBloc,
          Stream.fromIterable([
            SuccessRegisterState(clockingEvent: clockingEventMock),
          ]),
          initialState: SuccessRegisterState(clockingEvent: clockingEventMock),
        );

        final widget = getWidget(locale.languageCode);
        await tester.pumpWidget(widget);
        await tester.pump();

        verify(
          () => confirmationSnackbarWidget.show(
            clockingEvent: any(named: 'clockingEvent'),
            duration: any(named: 'duration'),
          ),
        );
      });
    },
  );
}
