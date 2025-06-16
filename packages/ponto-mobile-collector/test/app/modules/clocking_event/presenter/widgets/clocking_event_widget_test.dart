import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/cubit/work_indicator/work_indicator_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/cubit/work_indicator/work_indicator_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_receipt_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/util/iclocking_event_utill.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/timer/timer_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/widgets/driver_register_button_widget.dart';
import 'package:ponto_mobile_collector/app/collector/modules/routes/collector_routes.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../mocks/clocking_event_mock.dart';
import '../../../../../mocks/state_location_entity_mock.dart';

class MockUtils extends Mock implements IUtils {}

class MockTimerBloc extends MockBloc<TimerEvent, TimerState>
    implements TimerBloc {}

class MockRegisterClockingEventBloc
    extends MockBloc<RegisterClockingEventEvent, RegisterClockingState>
    implements RegisterClockingEventBloc {
  @override
  bool isRegistering = false;
}

class MockClockingEventBloc extends Mock implements ClockingEventBloc {}

class FakeEmployeeDto extends Fake implements clock.EmployeeDto {
  @override
  String? name;

  FakeEmployeeDto({this.name});
}

class FakeNotificationMessage extends Fake implements NotificationMessage {}

class FakeImportClockingEventDto extends Fake
    implements clock.ImportClockingEventDto {}

class MockShowBottomSheetUsecase extends Mock
    implements IShowBottomSheetUsecase {}

class MockGetReceiptUsecase extends Mock implements IGetReceiptUsecase {}

class FakeBuildContext extends Fake implements BuildContext {}

class FakeClockingEventReceiptModel extends Fake
    implements ClockingEventReceiptModel {}

class MockClockingEventUtil extends Mock implements IClockingEventUtil {}

class MockWorkIndicatorCubit extends Mock implements WorkIndicatorCubit {}

class MockFacialRegistrationMessageWidget extends Mock
    implements FacialRegistrationMessageWidget {}

class MockConfirmationSnackbarWidget extends Mock
    implements ConfirmationSnackbarWidget {}

class MockNavigatorService extends Mock implements NavigatorService {}

class MockPlatformService extends Mock implements IPlatformService {}

void main() {
  String tFaceRegistrationScreen = 'tFaceRegistrationScreen';
  String tEmployeeName = 'tEmployeeName';
  late TimerBloc timerBloc;
  late RegisterClockingEventBloc registerClockingEventBloc;
  late ClockingEventBloc clockingEventBloc;
  late IShowBottomSheetUsecase showBottomSheetUsecase;
  DateTime day = DateTime(2023, 4, 27, 10, 15, 33);
  late IClockingEventUtil clockingEventUtil;
  late Widget Function(String message, String description)? errorBuilder;
  late WorkIndicatorCubit workIndicatorCubit;
  late ConfirmationSnackbarWidget confirmationSnackbarWidget;
  late FacialRegistrationMessageWidget facialRegistrationMessageWidget;
  late BuildContext buildContext;
  late NavigatorService navigatorService;
  late IPlatformService platformService;

  Widget getWidget(String locale) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        routes: {
          '/${PontoMobileCollectorRoutes.module}/${FacialRecognitionRoutes.registrationFull}':
              (context) => Text(tFaceRegistrationScreen),
        },
        theme: SENIOR_LIGHT_THEME.themeData,
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: Locale(locale),
          child: Scaffold(
            body: ClockingEventWidget(
              confirmationSnackbarWidget: confirmationSnackbarWidget,
              facialRegistrationMessageWidget: facialRegistrationMessageWidget,
              workIndicatorCubit: workIndicatorCubit,
              timerBloc: timerBloc,
              registerClockingEventBloc: registerClockingEventBloc,
              clockingEventBloc: clockingEventBloc,
              showBottomSheetUsecase: showBottomSheetUsecase,
              clockingEventUtil: clockingEventUtil,
              errorBuilder: errorBuilder,
              secondsToPressButton: 0,
              navigatorService: navigatorService,
              platformService: platformService,
            ),
          ),
        ),
      ),
    );
  }

  setUp(
    () {
      facialRegistrationMessageWidget = MockFacialRegistrationMessageWidget();
      confirmationSnackbarWidget = MockConfirmationSnackbarWidget();
      timerBloc = MockTimerBloc();
      registerClockingEventBloc = MockRegisterClockingEventBloc();
      clockingEventBloc = MockClockingEventBloc();
      showBottomSheetUsecase = MockShowBottomSheetUsecase();
      clockingEventUtil = MockClockingEventUtil();
      errorBuilder = null;
      workIndicatorCubit = MockWorkIndicatorCubit();
      buildContext = FakeBuildContext();
      navigatorService = MockNavigatorService();
      platformService = MockPlatformService();

      registerFallbackValue(buildContext);

      when(() => timerBloc.state).thenReturn(TimerClockState(dateTime: day));

      when(() => timerBloc.lastDateTime).thenReturn(day);

      when(() => clockingEventBloc.state)
          .thenReturn(ReadyContentClockingEventState(clockingEventsDto: []));

      when(() => clockingEventBloc.stream)
          .thenAnswer((_) => StreamController<ClockingEventBaseState>().stream);

      when(() => clockingEventBloc.deviceStatus(any())).thenReturn(null);

      when(() => clockingEventBloc.hasEmployee()).thenReturn(true);

      when(() => clockingEventBloc.getEmployeeName()).thenReturn(tEmployeeName);

      when(() => clockingEventBloc.clockingEvents).thenReturn([]);

      when(() => clockingEventBloc.expandTodaysWorkday).thenReturn(true);

      when(() => registerClockingEventBloc.state)
          .thenReturn(RegisterClockingEventState(data: null));

      when(() => registerClockingEventBloc.stream)
          .thenAnswer((_) => StreamController<RegisterClockingState>().stream);

      when(() => clockingEventUtil.getDateTimes(any())).thenReturn([]);

      when(() => workIndicatorCubit.state).thenReturn(WorkIndicatorUpdate());

      when(() => workIndicatorCubit.isWorkInProgress).thenReturn(false);

      when(() => workIndicatorCubit.stream).thenAnswer(
        (_) => StreamController<WorkIndicatorState>().stream,
      );

      when(
        () => platformService.getLocation(),
      ).thenAnswer((_) async => stateLocationEntityMock);
    },
  );

  group(
    'ClockingEventWidget',
    () {
      testWidgets(
        'Show loading with TimerUpdate clock from TimerBloc test',
        (tester) async {
          when(() => clockingEventBloc.state)
              .thenReturn(LoadingClockingEventState());

          whenListen(
            timerBloc,
            Stream.fromIterable([
              TimerUpdatingState(),
              TimerUpdatedState(dateTime: day),
            ]),
          );

          Widget widget = getWidget('en');
          await tester.pumpWidget(widget);

          Finder textFinder = find.text('Loading...');
          expect(textFinder, findsOneWidget);
        },
      );

      testWidgets(
        'press register button test',
        (tester) async {
          registerFallbackValue(
            NewRegisterEvent(
              clockingEventRegisterType:
                  ClockingEventRegisterTypeSession(),
            ),
          );

          when(
            () => clockingEventBloc.executionModeEnum,
          ).thenReturn(ExecutionModeEnum.individual);

          when(
            () => registerClockingEventBloc.add(any()),
          ).thenReturn(null);

          Widget widget = getWidget('en');
          await tester.pumpWidget(widget);

          Finder seniorLinearLongPressButtonFinder =
              find.byType(SeniorLinearLongPressButton);

          expect(seniorLinearLongPressButtonFinder, findsOneWidget);

          await tester.tap(
            seniorLinearLongPressButtonFinder,
          );

          verify(() => registerClockingEventBloc.add(any()));
          verify(() => clockingEventBloc.executionModeEnum);
        },
      );

      testWidgets(
        'find driver register button test',
        (tester) async {
          when(
            () => clockingEventBloc.executionModeEnum,
          ).thenReturn(ExecutionModeEnum.driver);

          await tester.pumpWidget(getWidget('en'));

          Finder driverRegisterButtonWidgetFinder =
              find.byType(DriverRegisterButtonWidget);

          expect(driverRegisterButtonWidgetFinder, findsOneWidget);
          verify(() => clockingEventBloc.executionModeEnum);
        },
      );

      testWidgets(
        'success on register clocking event test',
        (tester) async {
          when(
            () => clockingEventBloc.executionModeEnum,
          ).thenReturn(ExecutionModeEnum.individual);

          when(
            () => facialRegistrationMessageWidget.show(
              clockingEventUse: any(named: 'clockingEventUse'),
            ),
          ).thenAnswer((_) async {});

          when(
            () => confirmationSnackbarWidget.show(
              clockingEvent: clockingEventMock,
            ),
          ).thenAnswer((_) async {});

          whenListen(
            registerClockingEventBloc,
            Stream.fromIterable([
              SuccessRegisterState(clockingEvent: clockingEventMock),
            ]),
          );

          Widget widget = getWidget('en');
          await tester.pumpWidget(widget);

          verify(() => clockingEventBloc.executionModeEnum);
          verify(
            () => facialRegistrationMessageWidget.show(
              clockingEventUse: any(named: 'clockingEventUse'),
            ),
          );
          verify(
            () => confirmationSnackbarWidget.show(
              clockingEvent: clockingEventMock,
            ),
          );
        },
      );

      testWidgets(
        'Show collector device erro message test',
        (tester) async {
          when(() => clockingEventBloc.deviceStatus(any()))
              .thenReturn('Msg to show');

          Widget widget = getWidget('en');
          await tester.pumpWidget(widget);

          Finder res = find.text('Msg to show');
          expect(res, findsOneWidget);
        },
      );

      testWidgets(
        'Show waapi device erro message test',
        (tester) async {
          when(() => clockingEventBloc.deviceStatus(any()))
              .thenReturn('Msg to show');

          errorBuilder = (message, description) => (const Text('Msg to show'));

          Widget widget = getWidget('en');
          await tester.pumpWidget(widget);

          Finder res = find.text('Msg to show');
          expect(res, findsOneWidget);
        },
      );

      testWidgets('buildWhen returns true for specific state transitions',
          (WidgetTester tester) async {
        when(
          () => clockingEventBloc.executionModeEnum,
        ).thenReturn(ExecutionModeEnum.individual);

        // Arrange
        whenListen(
          timerBloc,
          Stream.fromIterable([
            TimerClockState(dateTime: day),
            TimerUpdatingState(),
            TimerUpdatedState(dateTime: day),
          ]),
          initialState: TimerUpdatedState(dateTime: day),
        );

        // Act
        Widget widget = getWidget('en');
        await tester.pumpWidget(widget);

        // Assert
        // Verify that the buildWhen condition was met and the widget rebuilt
        verify(() => timerBloc.state).called(4);
      });
    },
  );
}
