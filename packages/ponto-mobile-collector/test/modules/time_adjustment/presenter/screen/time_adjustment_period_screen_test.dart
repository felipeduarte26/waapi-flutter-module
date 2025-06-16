//import 'package:bloc_test/bloc_test.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_state.dart';

//import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/routes/collector_routes.dart';
import 'package:ponto_mobile_collector/app/collector/modules/routes/time_adjustment_multi_routes.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/screen/time_adjustment_period_screen.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockTimerAdjustmentBloc extends Mock implements TimerAdjustmentBloc {}

class MockPeriodBloc extends Mock implements PeriodBloc {}

class MockNavigatorService extends Mock implements NavigatorService {}

class MockTabActionBloc extends Mock implements TabActionBloc {}

class MockSynchronizeClockingEventBloc extends Mock
    implements SynchronizeClockingEventBloc {}

class MockUtils extends Mock implements IUtils {}

class MockShowBottomSheetUsecase extends Mock
    implements IShowBottomSheetUsecase {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late PeriodBloc periodBloc;
  late TimerAdjustmentBloc timerAdjustmentBloc;
  late TabActionBloc tabActionBloc;
  late SynchronizeClockingEventBloc synchronizeClockingEventBloc;
  late IUtils utils;
  late NavigatorService navigatorService;
  IShowBottomSheetUsecase showBottomSheetUsecase = MockShowBottomSheetUsecase();

  Widget getWidget(String locale, Widget widget) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: Locale(locale),
          child: Scaffold(
            body: widget,
          ),
        ),
      ),
    );
  }

  setUp(
    () {
      periodBloc = MockPeriodBloc();
      timerAdjustmentBloc = MockTimerAdjustmentBloc();
      tabActionBloc = MockTabActionBloc();
      synchronizeClockingEventBloc = MockSynchronizeClockingEventBloc();
      utils = MockUtils();
      navigatorService = MockNavigatorService();

      when(
        () => navigatorService.pushNamed(
          route:
              '/${PontoMobileCollectorRoutes.module}/${TimeAdjustmentMultiRoutes.selectEmployeeFull}',
        ),
      ).thenAnswer((_) async => true);

      when(() => periodBloc.stream).thenAnswer(
        (_) => StreamController<PeriodState>().stream,
      );

      when(() => periodBloc.initialDateFilter).thenAnswer(
            (_) => DateTime.now(),
      );

      when(() => periodBloc.finalDateFilter).thenAnswer(
            (_) => DateTime.now(),
      );

      when(() => periodBloc.requestDate).thenAnswer(
            (_) => DateTime.now(),
      );
    },
  );

  testWidgets(
    'TimeAdjustmentPeriodScreen loading content.',
    (tester) async {

      when(() => periodBloc.isPeriodSelected).thenAnswer(
            (_) => false,
      );

      when(() => periodBloc.isEmployeesSelected).thenAnswer(
            (_) => false,
      );

      PeriodState state = LoadingDayInfoState();

      when(() => periodBloc.state).thenReturn(state);
      when(() => synchronizeClockingEventBloc.state)
          .thenReturn(SyncClockingEventInitial());

      Widget widget = getWidget(
        'pt',
        TimeAdjustmentPeriodScreen(
          navigatorService,
          periodBloc,
          tabActionBloc,
          timerAdjustmentBloc,
          synchronizeClockingEventBloc,
          utils,
          showBottomSheetUsecase,
          '',
        ),
      );

      await tester.pumpWidget(widget);
      final loadingFinder = find.byType(LoadingWidget);

      expect(loadingFinder, findsOneWidget);
    },
  );

  testWidgets(
    'TimeAdjustmentPeriodScreen show content.',
    (tester) async {
      when(() => periodBloc.isPeriodSelected).thenAnswer(
            (_) => false,
      );

      when(() => periodBloc.isEmployeesSelected).thenAnswer(
            (_) => false,
      );

      PeriodState state = PeriodState();

      when(() => periodBloc.state).thenReturn(state);

      when(() => synchronizeClockingEventBloc.state)
          .thenReturn(SyncClockingEventInitial());

      Widget widget = getWidget(
        'pt',
        TimeAdjustmentPeriodScreen(
          navigatorService,
          periodBloc,
          tabActionBloc,
          timerAdjustmentBloc,
          synchronizeClockingEventBloc,
          utils,
          showBottomSheetUsecase,
          '',
        ),
      );

      await tester.pumpWidget(widget);

      final leftButton = find.byIcon(FontAwesomeIcons.angleLeft);
      await tester.tap(leftButton);
      await tester.pump();

      final rightButton = find.byIcon(FontAwesomeIcons.angleRight);
      await tester.tap(rightButton);
      await tester.pump();

      final iconCalendarFinder = find.byIcon(FontAwesomeIcons.calendarWeek);
      expect(iconCalendarFinder, findsOneWidget);

      final iconQuestionFinder =
          find.byIcon(FontAwesomeIcons.solidCircleQuestion);
      expect(iconQuestionFinder, findsOneWidget);

      final calendarHEaderFinder = find.byType(SeniorCalendarHeader);
      expect(calendarHEaderFinder, findsOneWidget);

    },
  );

  testWidgets(
    'Show Bottom Sheet content.',
    (tester) async {

      when(() => periodBloc.isPeriodSelected).thenAnswer(
            (_) => false,
      );

      when(() => periodBloc.isEmployeesSelected).thenAnswer(
            (_) => false,
      );

      PeriodState state = PeriodState();

      showBottomSheetUsecase = MockShowBottomSheetUsecase();
      BuildContext context = MockBuildContext();
      List<Widget> content = [];
      dynamic retorno = true;

      registerFallbackValue(context);
      registerFallbackValue(content);

      when(
        () => showBottomSheetUsecase.call(
          content: any(named: 'content'),
          context: any(named: 'context'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(retorno),
      );

      when(() => periodBloc.state).thenReturn(state);
      when(() => synchronizeClockingEventBloc.state)
          .thenReturn(SyncClockingEventInitial());

      Widget widget = getWidget(
        'pt',
        TimeAdjustmentPeriodScreen(
          navigatorService,
          periodBloc,
          tabActionBloc,
          timerAdjustmentBloc,
          synchronizeClockingEventBloc,
          utils,
          showBottomSheetUsecase,
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
    'Filter by Period test.',
    (tester) async {
      DayInfoModel dayInfoModel = DayInfoModel(
        isOdd: false,
        day: DateTime.now(),
        isSynchronized: true,
        isRemoteness: false,
        times: [],
      );

      when(() => periodBloc.isPeriodSelected).thenAnswer(
            (_) => false,
      );

      when(() => periodBloc.isEmployeesSelected).thenAnswer(
            (_) => false,
      );

      PeriodState state = PeriodState(
        data: [dayInfoModel],
      );

      showBottomSheetUsecase = MockShowBottomSheetUsecase();
      BuildContext context = MockBuildContext();
      List<Widget> content = [];
      dynamic retorno = true;

      registerFallbackValue(context);
      registerFallbackValue(content);

      when(
        () => showBottomSheetUsecase.call(
          content: any(named: 'content'),
          context: any(named: 'context'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(retorno),
      );

      when(() => periodBloc.state).thenReturn(state);
      when(() => synchronizeClockingEventBloc.state)
          .thenReturn(SyncClockingEventInitial());

      Widget widget = getWidget(
        'pt',
        TimeAdjustmentPeriodScreen(
          navigatorService,
          periodBloc,
          tabActionBloc,
          timerAdjustmentBloc,
          synchronizeClockingEventBloc,
          utils,
          showBottomSheetUsecase = showBottomSheetUsecase,
          '',
        ),
      );

      await tester.pumpWidget(widget);

      var badgeFinder = find.text('Período');
      expect(badgeFinder, findsOneWidget);

      await tester.tap(badgeFinder);

      verify(
        () => showBottomSheetUsecase.call(
          content: any(named: 'content'),
          context: any(named: 'context'),
        ),
      ).called(1);
      verifyNoMoreInteractions(showBottomSheetUsecase);

      await tester.tap(badgeFinder);
    },
  );
}
