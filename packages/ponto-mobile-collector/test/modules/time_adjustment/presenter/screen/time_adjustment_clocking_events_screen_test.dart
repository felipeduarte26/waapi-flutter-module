import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/journey_time_details_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/type_journey_time_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_clock_time_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_event.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/screen/time_adjustment_clocking_events_screen.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockTimerAdjustmentBloc
    extends MockBloc<TimerAdjustmentEvent, TimerAdjustmentState>
    implements TimerAdjustmentBloc {}

class MockSynchronizeClockingEventBloc
    extends MockBloc<SyncClockingEventEvent, SyncClockingEventState>
    implements SynchronizeClockingEventBloc {}

class MockGetClockDateTimeUsecase extends Mock
    implements IGetClockDateTimeUsecase {}

class MockUtils extends Mock implements IUtils {}

class MockShowBottomSheetUsecase extends Mock
    implements IShowBottomSheetUsecase {}

class MockBuildContext extends Mock implements BuildContext {}

class MockNavigatorService extends Mock implements NavigatorService {}

void main() {
  late IGetClockDateTimeUsecase getClockDateTimeUsecase;
  late TimerAdjustmentBloc timerAdjustmentBloc;
  late SynchronizeClockingEventBloc synchronizeClockingEventBloc;
  late IUtils utils;
  IShowBottomSheetUsecase showBottomSheetUsecase = MockShowBottomSheetUsecase();
  late List<JourneyTimeDetailsDto> journeyTimeDetailsList = [];
  late NavigatorService navigatorService;

  Widget getWidget(String locale, Widget widget) {
    return MaterialApp(
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: Locale(locale),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: widget,
          ),
        ),
      ),
    );
  }

  setUp(() {
    getClockDateTimeUsecase = MockGetClockDateTimeUsecase();
    timerAdjustmentBloc = MockTimerAdjustmentBloc();
    synchronizeClockingEventBloc = MockSynchronizeClockingEventBloc();
    utils = MockUtils();
    navigatorService = MockNavigatorService();
    journeyTimeDetailsList.add(
      JourneyTimeDetailsDto(
        time: DateTime.now(),
        use: TypeJourneyTimeEnum.driving,
      ),
    );

    when(() => timerAdjustmentBloc.totalBreakTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.totalWorkingTime)
        .thenReturn(DateTime(2023, 10, 1, 1, 45));
    when(() => timerAdjustmentBloc.clockingEventsJourneyList).thenReturn([]);
    when(() => timerAdjustmentBloc.hasOvernight).thenReturn(false);
    when(() => timerAdjustmentBloc.showAddOvernightButton).thenReturn(false);
  });

  testWidgets(
    'TimeAdjustmentClockingEventsScreen show loading screen.',
    (tester) async {
      DateTime today = DateTime.now();

      when(() => getClockDateTimeUsecase.call()).thenReturn(today);

      when(() => timerAdjustmentBloc.state)
          .thenReturn(InitialTimerAdjustmentState());

      Widget widget = getWidget(
        'pt',
        TimeAdjustmentClockingEventsScreen(
          timerAdjustmentBloc,
          getClockDateTimeUsecase,
          synchronizeClockingEventBloc,
          utils,
          showBottomSheetUsecase = showBottomSheetUsecase,
          navigatorService,
          '',
        ),
      );

      await tester.pumpWidget(widget);

      Finder loadingFinder = find.byType(LoadingWidget);
      expect(loadingFinder, findsOneWidget);

      verify(
        () => getClockDateTimeUsecase.call(),
      ).called(1);

      verify(
        () => timerAdjustmentBloc.state,
      ).called(2);

      verifyNoMoreInteractions(getClockDateTimeUsecase);
    },
  );

  testWidgets(
    'TimeAdjustmentClockingEventsScreen show clocking events screen.',
    (tester) async {
      // final collectorLocalizations = lookupCollectorLocalizations(
      //   const Locale('en'),
      // );

      DateTime today = DateTime.now();
      when(() => timerAdjustmentBloc.journeyTimeDetailsList)
          .thenReturn(journeyTimeDetailsList);

      DayInfoModel dayInfoModel = DayInfoModel(
        isOdd: false,
        day: today,
        isSynchronized: false,
        isRemoteness: true,
        times: [
          TimeInfoModel(
            clockingEventId: 'clockingEventId',
            dateTime: today,
            isBold: true,
            isPhoneOrigin: true,
            isPlatformOrigin: true,
            isManual: false,
            isRemoteness: false,
            isSynchronized: false,
            use: 2,
            isMealBreak: false,
          ),
        ],
      );

      when(() => getClockDateTimeUsecase.call()).thenReturn(today);

      when(() => synchronizeClockingEventBloc.state)
          .thenReturn(SyncClockingEventInitial());

      when(() => timerAdjustmentBloc.state).thenReturn(
        LoadedTimerAdjustmentState(
          dayInfoModel: dayInfoModel,
          showAddOvernightButton: true,
        ),
      );

      when(() => timerAdjustmentBloc.day).thenReturn(today);

      when(() => timerAdjustmentBloc.dayInfoModel).thenReturn(dayInfoModel);

      Widget widget = getWidget(
        'en',
        TimeAdjustmentClockingEventsScreen(
          timerAdjustmentBloc,
          getClockDateTimeUsecase,
          synchronizeClockingEventBloc,
          Utils(),
          showBottomSheetUsecase = showBottomSheetUsecase,
          navigatorService,
          '',
        ),
      );

      await tester.pumpWidget(widget);

      Finder calendarFinder = find.byType(SeniorCalendar);
      expect(calendarFinder, findsOneWidget);

      Finder timeAdjustmentWidgetFinder = find.byType(TimeAdjustmentWidget);
      expect(timeAdjustmentWidgetFinder, findsOneWidget);

      Finder calendarIconFinder = find.byIcon(
        FontAwesomeIcons.calendarDays,
      );

      expect(calendarIconFinder, findsOneWidget);

      Finder questionIconFinder = find.byIcon(
        FontAwesomeIcons.solidCircleQuestion,
      );

      expect(questionIconFinder, findsOneWidget);

      // Finder addIconFinder = find.byIcon(
      //   FontAwesomeIcons.plus,
      // );
      // expect(addIconFinder, findsOneWidget);

      // final buttonFinder = find.text(
      //   collectorLocalizations.addClocking,
      // );
      // expect(buttonFinder, findsOneWidget);
      // await tester.tap(buttonFinder);

      Finder textFinder = find.text(
        'Clocking events of the day',
      );

      expect(textFinder, findsOneWidget);

      verify(
        () => timerAdjustmentBloc.state,
      ).called(2);

      verify(
        () => timerAdjustmentBloc.day,
      ).called(2);

      verify(
        () => timerAdjustmentBloc.dayInfoModel,
      ).called(1);
    },
  );

  testWidgets(
    'Overnight card',
    (tester) async {
      const locale = Locale('en');
      final collectorLocalizations = lookupCollectorLocalizations(locale);
      DateTime today = DateTime.now();
      DayInfoModel dayInfoModel = DayInfoModel(
        isOdd: false,
        day: today,
        isSynchronized: false,
        isRemoteness: true,
        times: [
          TimeInfoModel(
            clockingEventId: 'clockingEventId',
            dateTime: today,
            isBold: true,
            isPhoneOrigin: true,
            isPlatformOrigin: true,
            isManual: false,
            isRemoteness: false,
            isSynchronized: false,
            use: 2,
            isMealBreak: false,
          ),
        ],
      );

      when(() => synchronizeClockingEventBloc.state)
          .thenReturn(SyncClockingEventInitial());

      when(() => timerAdjustmentBloc.day).thenReturn(today);

      when(() => getClockDateTimeUsecase.call()).thenReturn(today);

      when(() => timerAdjustmentBloc.dayInfoModel).thenReturn(dayInfoModel);

      when(() => timerAdjustmentBloc.journeyTimeDetailsList)
          .thenReturn(journeyTimeDetailsList);

      when(() => timerAdjustmentBloc.totalBreakTime)
          .thenReturn(DateTime(2023, 10, 1, 1, 45));

      when(() => timerAdjustmentBloc.totalWorkingTime)
          .thenReturn(DateTime(2023, 10, 1, 1, 45));

      when(() => timerAdjustmentBloc.hasOvernight).thenReturn(true);

      when(
        () => timerAdjustmentBloc.state,
      ).thenReturn(
        LoadedTimerAdjustmentState(
          dayInfoModel: dayInfoModel,
          showAddOvernightButton: true,
        ),
      );

      Widget widget = getWidget(
        locale.languageCode,
        TimeAdjustmentClockingEventsScreen(
          timerAdjustmentBloc,
          getClockDateTimeUsecase,
          synchronizeClockingEventBloc,
          Utils(),
          showBottomSheetUsecase = showBottomSheetUsecase,
          navigatorService,
          '',
        ),
      );
      await tester.pumpWidget(widget);

      expect(
        find.widgetWithIcon(
          SeniorElevatedElement,
          FontAwesomeIcons.solidMoon,
        ),
        findsOneWidget,
      );
      expect(
        find.widgetWithText(
          SeniorBadge,
          collectorLocalizations.overnight,
        ),
        findsOneWidget,
      );
    },
  );

  group(
    'Bottom Sheet',
    () {
      DateTime today = DateTime.now();

      ClockingEventReceiptModel clockingEventReceiptModel =
          ClockingEventReceiptModel(
        date: '2023-01-01',
        time: '10:41:32',
        timeZone: '-03:00',
        employeeName: 'employeeName',
        cpf: '99999999999',
        companyName: 'companyName',
        cnpj: 'cnpj',
        receiptIdentifier: 'receiptIdentifier',
      );

      DayInfoModel dayInfoModel = DayInfoModel(
        isOdd: false,
        day: today,
        isSynchronized: true,
        isRemoteness: false,
        times: [],
      );

      showBottomSheetUsecase = MockShowBottomSheetUsecase();
      BuildContext context = MockBuildContext();
      List<Widget> content = [];
      dynamic retorno = true;

      setUp(
        () {
          registerFallbackValue(context);
          registerFallbackValue(content);
          when(() => timerAdjustmentBloc.journeyTimeDetailsList)
              .thenReturn(journeyTimeDetailsList);
          when(
            () => showBottomSheetUsecase.call(
              content: any(named: 'content'),
              context: any(named: 'context'),
            ),
          ).thenAnswer(
            (invocation) => Future.value(retorno),
          );

          when(() => getClockDateTimeUsecase.call()).thenReturn(today);
          when(() => timerAdjustmentBloc.state).thenReturn(
            LoadedTimerAdjustmentState(
              dayInfoModel: dayInfoModel,
              showAddOvernightButton: true,
            ),
          );
          when(() => synchronizeClockingEventBloc.state)
              .thenReturn(SyncClockingEventInitial());

          when(() => timerAdjustmentBloc.day).thenReturn(today);
          when(() => timerAdjustmentBloc.dayInfoModel).thenReturn(dayInfoModel);
        },
      );

      testWidgets(
        'Show Bottom Sheet info screen.',
        (tester) async {
          when(() => timerAdjustmentBloc.journeyTimeDetailsList)
              .thenReturn(journeyTimeDetailsList);

          when(() => timerAdjustmentBloc.showDriverInfo()).thenReturn(true);

          Widget widget = getWidget(
            'pt',
            TimeAdjustmentClockingEventsScreen(
              timerAdjustmentBloc,
              getClockDateTimeUsecase,
              synchronizeClockingEventBloc,
              utils,
              showBottomSheetUsecase = showBottomSheetUsecase,
              navigatorService,
              '',
            ),
          );

          await tester.pumpWidget(widget);

          var iconFinder = find.byIcon(FontAwesomeIcons.solidCircleQuestion);
          await tester.tap(iconFinder);

          verify(
            () => showBottomSheetUsecase.call(
              content: any(named: 'content'),
              context: any(named: 'context'),
            ),
          ).called(1);
          verifyNoMoreInteractions(showBottomSheetUsecase);
        },
      );

      testWidgets(
        'Show Receipt screen.',
        (tester) async {
          whenListen(
            timerAdjustmentBloc,
            Stream.fromIterable([
              ReceiptTimerAdjustmentState(
                receiptModel: clockingEventReceiptModel,
              ),
            ]),
          );

          Widget widget = getWidget(
            'pt',
            TimeAdjustmentClockingEventsScreen(
              timerAdjustmentBloc,
              getClockDateTimeUsecase,
              synchronizeClockingEventBloc,
              utils,
              showBottomSheetUsecase = showBottomSheetUsecase,
              navigatorService,
              '',
            ),
          );

          await tester.pumpWidget(widget);

          verify(
            () => showBottomSheetUsecase.call(
              content: any(named: 'content'),
              context: any(named: 'context'),
            ),
          ).called(1);
          verifyNoMoreInteractions(showBottomSheetUsecase);
        },
      );
    },
  );
}
