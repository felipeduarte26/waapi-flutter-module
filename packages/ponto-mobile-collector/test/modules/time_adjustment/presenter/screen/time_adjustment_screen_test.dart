import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_clock_time_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_event.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/routes/collector_routes.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/presenter/screen/time_adjustment_screen.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockUtils extends Mock implements IUtils {}

class MockGetClockDateTimeUsecase extends Mock implements IGetClockDateTimeUsecase {}

class MockTabActionBloc extends MockBloc<TabActionEvent, TabActionState> implements TabActionBloc {}

class MockPeriodBloc extends MockBloc<PeriodEvent, PeriodState> implements PeriodBloc {}

class MockNavigatorService extends Mock implements NavigatorService {}

class MockTimerAdjustmentBloc extends MockBloc<TimerAdjustmentEvent, TimerAdjustmentState>
    implements TimerAdjustmentBloc {}

class MockSynchronizeClockingEventBloc extends MockBloc<SyncClockingEventEvent, SyncClockingEventState>
    implements SynchronizeClockingEventBloc {}

class MockShowBottomSheetUsecase extends Mock implements IShowBottomSheetUsecase {}

void main() {
  String configurationScreen = 'configurationScreen';
  late TabActionBloc tabActionBloc;
  late PeriodBloc periodBloc;
  late NavigatorService navigatorService;
  late TimerAdjustmentBloc timerAdjustmentBloc;
  late IGetClockDateTimeUsecase getClockDateTimeUsecase;
  late SynchronizeClockingEventBloc synchronizeClockingEventBloc;
  late IUtils utils;
  late IShowBottomSheetUsecase showBottomSheetUsecase;

  Widget getWidget(
    String locale, {
    Widget? content,
    List<Object>? routeArguments,
    bool isCustom = false,
  }) {
    return MaterialApp(
      routes: {
        '/${PontoMobileCollectorRoutes.configurationHome}': (context) => Text(configurationScreen),
      },
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: Locale(locale),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: isCustom
                ? SENIOR_LIGHT_THEME.copyWith(themeType: ThemeType.custom, primaryColor: Colors.red)
                : SENIOR_LIGHT_THEME,
            child: TimeAdjustmentScreen(
              content: content,
              tabActionBloc,
              navigatorService,
              periodBloc,
              timerAdjustmentBloc,
              getClockDateTimeUsecase,
              synchronizeClockingEventBloc,
              utils,
              showBottomSheetUsecase = showBottomSheetUsecase,
              hideBackButton: false,
              showNotificationButton: true,
              routeArguments: routeArguments,
            ),
          ),
        ),
      ),
    );
  }

  setUp(() {
    tabActionBloc = MockTabActionBloc();
    getClockDateTimeUsecase = MockGetClockDateTimeUsecase();
    synchronizeClockingEventBloc = MockSynchronizeClockingEventBloc();
    periodBloc = MockPeriodBloc();
    timerAdjustmentBloc = MockTimerAdjustmentBloc();
    utils = MockUtils();
    showBottomSheetUsecase = MockShowBottomSheetUsecase();
    navigatorService = MockNavigatorService();

    when(() => tabActionBloc.state).thenReturn(tabActionInitialState);

    when(() => periodBloc.state).thenReturn(LoadingDayInfoState());
    when(() => timerAdjustmentBloc.state).thenReturn(InitialTimerAdjustmentState());
    when(() => synchronizeClockingEventBloc.state).thenReturn(SyncClockingEventInitial());

    when(() => periodBloc.stream).thenAnswer(
      (invocation) => Stream.fromIterable(
        [LoadingDayInfoState()],
      ),
    );

    when(() => timerAdjustmentBloc.stream).thenAnswer(
      (invocation) => Stream.fromIterable(
        [InitialTimerAdjustmentState()],
      ),
    );

    when(() => synchronizeClockingEventBloc.stream).thenAnswer(
      (invocation) => Stream.fromIterable(
        [SyncClockingEventInitial()],
      ),
    );

    when(() => utils.maskCPF(cpf: any(named: 'cpf'))).thenReturn('***.999.888-**');
  });

  group('TimeAdjustmentScreen', () {
    testWidgets('show TimeAdjustmentScreen', (tester) async {
      when(() => periodBloc.stream).thenAnswer(
        (invocation) => Stream.fromIterable(
          [LoadingDayInfoState()],
        ),
      );

      when(() => timerAdjustmentBloc.stream).thenAnswer(
        (invocation) => Stream.fromIterable(
          [InitialTimerAdjustmentState()],
        ),
      );

      when(() => synchronizeClockingEventBloc.stream).thenAnswer(
        (invocation) => Stream.fromIterable(
          [SyncClockingEventInitial()],
        ),
      );

      Widget widget = getWidget('en');
      await tester.pumpWidget(widget);

      expect(find.text('Clocking events'), findsNWidgets(2));
      expect(find.text('Period'), findsOneWidget);
    });

    testWidgets('click back button', (tester) async {
      Widget widget = getWidget('en');

      await tester.pumpWidget(widget);
      await tester.tap(find.byIcon(FontAwesomeIcons.angleLeft));
    });

    testWidgets('Call Notification screen test', (tester) async {
      Widget widget = getWidget('en', content: const Text('content'));
      await tester.pumpWidget(widget);

      expect(find.text('content'), findsOneWidget);
      Finder eventFinder = find.byIcon(FontAwesomeIcons.solidBell);
      expect(eventFinder, findsOneWidget);

      await tester.tap(eventFinder);
      await tester.pumpAndSettle();
    });

    testWidgets('TimeAdjustmentScreen with route arguments', (WidgetTester tester) async {
      final routeArguments = [true, true, 'username'];

      await tester.pumpWidget(
        getWidget(
          'en',
          routeArguments: routeArguments,
        ),
      );

      expect(find.text('Clocking events'), findsNWidgets(2));
      expect(find.text('Period'), findsOneWidget);
    });

    testWidgets('show TimeAdjustmentScreen with custom theme', (tester) async {
      when(() => periodBloc.stream).thenAnswer(
        (invocation) => Stream.fromIterable(
          [LoadingDayInfoState()],
        ),
      );

      when(() => timerAdjustmentBloc.stream).thenAnswer(
        (invocation) => Stream.fromIterable(
          [InitialTimerAdjustmentState()],
        ),
      );

      when(() => synchronizeClockingEventBloc.stream).thenAnswer(
        (invocation) => Stream.fromIterable(
          [SyncClockingEventInitial()],
        ),
      );

      Widget widget = getWidget('en', isCustom: true);
      await tester.pumpWidget(widget);

      expect(find.text('Clocking events'), findsNWidgets(2));
      expect(find.text('Period'), findsOneWidget);
    });
  });
}
