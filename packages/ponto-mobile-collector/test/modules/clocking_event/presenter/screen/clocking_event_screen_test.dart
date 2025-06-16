import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/menu_action/menu_action_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/timer/timer_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/screen/clocking_event_screen.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/has_unread_push_message_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/usecases/get_number_unread_notifications_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/counter_notifications_bloc/counter_notifications_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/routes/collector_routes.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

class MockNavigatorService extends Mock implements NavigatorService {}

class MockHasConnectivityUsecase extends Mock
    implements IHasConnectivityUsecase {}

class MockGetNumberUnreadNotificationsUsecase extends Mock
    implements GetNumberUnreadNotificationsUsecase {}

class MockTimerBloc extends MockBloc<TimerEvent, TimerState>
    implements TimerBloc {
  @override
  DateTime get lastDateTime => DateTime.now();
}

class MockClockingEventBloc
    extends MockBloc<ClockingEventEvent, ClockingEventBaseState>
    implements ClockingEventBloc {
  @override
  String? getEmployeeName() {
    return 'employeeName';
  }

  @override
  bool hasEmployee() {
    return true;
  }
}

class MockMenuActionCubit extends MockCubit<MenuActionCubitState>
    implements MenuActionCubit {
  @override
  List<SeniorSquareButtonsMenuItemData> squareButtonsMenuItemData = [];
}

class MockMenuActionCubitState extends Fake implements MenuActionCubitState {}

void main() {
  String configurationScreen = 'configurationScreen';
  late NavigatorService navigatorService;
  late GetNumberUnreadNotificationsUsecase getNumberUnreadNotificationsUsecase;
  late TimerBloc timerBloc;
  late MenuActionCubit menuActionCubit;
  late IHasConnectivityUsecase hasConnectivityUsecase;

  setUpAll(() {
    registerFallbackValue(MockMenuActionCubitState);
  });

  setUp(
    () {
      navigatorService = MockNavigatorService();
      getNumberUnreadNotificationsUsecase =
          MockGetNumberUnreadNotificationsUsecase();
      hasConnectivityUsecase = MockHasConnectivityUsecase();

      when(() => navigatorService.pop()).thenReturn(null);
      when(
        () => navigatorService.pushNamed(
          route: '/${PontoMobileCollectorRoutes.configurationHome}',
        ),
      ).thenAnswer((_) async => null);
      when(
        () => navigatorService.pushNamed(
          route: '/${PontoMobileCollectorRoutes.notificationHome}',
        ),
      ).thenAnswer((_) async => null);
      when(() => getNumberUnreadNotificationsUsecase.call()).thenAnswer(
        (_) async =>
            HasUnreadPushMessageEntity(number: 0, hasUnreadPushMessage: false),
      );

      timerBloc = MockTimerBloc();

      when(
        () => timerBloc.state,
      ).thenReturn(
        TimerClockState(dateTime: DateTime.now()),
      );

      menuActionCubit = MockMenuActionCubit();

      when(
        () => menuActionCubit.state,
      ).thenReturn(
        InitialMenuActionCubitState(),
      );
    },
  );

  Widget getWidget(String locale) {
    return MaterialApp(
      routes: {
        '/${PontoMobileCollectorRoutes.configurationHome}': (context) =>
            Text(configurationScreen),
      },
      home: Localizations(
        delegates: CollectorLocalizations.localizationsDelegates,
        locale: Locale(locale),
        child: Scaffold(
          body: SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: ClockingEventScreen(
              timerBloc: timerBloc,
              clockingEventBloc: MockClockingEventBloc(),
              menuActionCubit: menuActionCubit,
              clockingEventWidget: const Text('clockingEventWidget'),
              hideBackButton: false,
              navigatorService: navigatorService,
              counterNotificationsBloc: CounterNotificationsBloc(
                getNumberUnreadNotificationsUsecase:
                    getNumberUnreadNotificationsUsecase,
                hasConnectivityUsecase: hasConnectivityUsecase,
              ),
              showNotificationButton: true,
            ),
          ),
        ),
      ),
    );
  }

  group(
    'ClockingEventScreen',
    () {
      testWidgets(
        'Show Data test',
        (tester) async {
          Widget widget = getWidget('en');
          await tester.pumpWidget(widget);

          Finder findContent = find.text('clockingEventWidget');
          expect(findContent, findsOneWidget);
        },
      );

      testWidgets(
        'click back button test',
        (tester) async {
          Widget widget = getWidget('en');

          await tester.pumpWidget(widget);
          await tester.tap(find.byIcon(FontAwesomeIcons.angleLeft));
          verify(() => navigatorService.pop()).called(1);
        },
      );

      testWidgets('Call configuration screen test', (tester) async {
        Widget widget = getWidget('en');
        await tester.pumpWidget(widget);

        Finder configurationFinder = find.byIcon(FontAwesomeIcons.gear);
        expect(configurationFinder, findsOneWidget);

        await tester.tap(configurationFinder);
        verify(
          () => navigatorService.pushNamed(
            route: '/${PontoMobileCollectorRoutes.configurationHome}',
          ),
        );
      });
    },
  );
}
