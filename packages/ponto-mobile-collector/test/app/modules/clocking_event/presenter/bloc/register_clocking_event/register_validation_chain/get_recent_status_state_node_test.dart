import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/employee_has_recent_clocking_event_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_recent_status_state_node.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../../mocks/employee_dto_mock.dart';

class MockEmployeeHasRecentClockingEventUsecase extends Mock
    implements IEmployeeHasRecentClockingEventUsecase {}

class MockNavigatorService extends Mock implements NavigatorService {}

class BuildContextMock extends Mock implements BuildContext {}

class MockLogService extends Mock implements LogService {}

class MockRegisterClockingEventBloc extends Mock
    implements RegisterClockingEventBloc {
  @override
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
}

void main() {
  late IEmployeeHasRecentClockingEventUsecase
      employeeHasRecentClockingEventUsecase;
  late GetRecentStatusStateNode getRecentStatusStateNode;
  late NavigatorService navigatorService;
  late BuildContext buildContext;
  late RegisterClockingEventBloc registerClockingEventBloc;
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
  late LogService logService;

  setUp(() {
    employeeHasRecentClockingEventUsecase =
        MockEmployeeHasRecentClockingEventUsecase();
    navigatorService = MockNavigatorService();
    buildContext = BuildContextMock();
    registerClockingEventBloc = MockRegisterClockingEventBloc();
    logService = MockLogService();

    clockingEventRegisterEntity = ClockingEventRegisterEntity(
      clockingEventRegisterType: ClockingEventRegisterTypeSession(),
      dateTime: DateTime(2024, 3, 5),
      employeeDto: employeeMockDto,
    );
    registerClockingEventBloc = MockRegisterClockingEventBloc();
    registerClockingEventBloc.clockingEventRegisterEntity =
        clockingEventRegisterEntity;

    when(
      () => employeeHasRecentClockingEventUsecase.call(
        employeeId: any(
          named: 'employeeId',
        ),
        clockingEventRegisterType:
            clockingEventRegisterEntity.clockingEventRegisterType,
      ),
    ).thenAnswer((_) async => false);

    when(() => navigatorService.pop()).thenReturn(null);

    when(
      () => logService.saveLocalLog(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    getRecentStatusStateNode = GetRecentStatusStateNode(
      employeeHasRecentClockingEventUsecase:
          employeeHasRecentClockingEventUsecase,
      navigatorService: navigatorService,
      logService: logService,
    );

    getRecentStatusStateNode.setContext(
      buildContext,
      registerClockingEventBloc,
    );
  });

  Widget getWidget() {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        theme: SENIOR_LIGHT_THEME.themeData,
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: const Locale('pt'),
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return FilledButton(
                  child: const Text('showDialog'),
                  onPressed: () {
                    getRecentStatusStateNode.setContext(
                      context,
                      registerClockingEventBloc,
                    );
                    getRecentStatusStateNode.handler();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  group('GetRecentStatusStateNode', () {
    test('no recent register test', () async {
      final result = await getRecentStatusStateNode.handler();
      expect(result, isNull);

      verify(
        () => employeeHasRecentClockingEventUsecase.call(
          employeeId: any(
            named: 'employeeId',
          ),
          clockingEventRegisterType:
              clockingEventRegisterEntity.clockingEventRegisterType,
        ),
      ).called(1);
    });

    testWidgets('show camera message confirmation test', (tester) async {
      when(
        () => employeeHasRecentClockingEventUsecase.call(
          employeeId: any(
            named: 'employeeId',
          ),
          clockingEventRegisterType:
              clockingEventRegisterEntity.clockingEventRegisterType,
        ),
      ).thenAnswer(
        (_) async => true,
      );

      await tester.pumpWidget(getWidget());
      Finder buttonFinder = find.text('showDialog');
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(find.text('alert'), findsOneWidget);
      expect(find.text('content'), findsOneWidget);
      expect(find.text('cancel'), findsOneWidget);

      await tester.tap(find.text('confirm'));

      verify(() => navigatorService.pop()).called(1);
    });

    testWidgets('show camera message cancel test', (tester) async {
      when(
        () => employeeHasRecentClockingEventUsecase.call(
          employeeId: any(
            named: 'employeeId',
          ),
          clockingEventRegisterType:
              clockingEventRegisterEntity.clockingEventRegisterType,
        ),
      ).thenAnswer(
        (_) async => true,
      );

      await tester.pumpWidget(getWidget());
      Finder buttonFinder = find.text('showDialog');
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      await tester.tap(find.text('cancel'));

      verify(() => navigatorService.pop()).called(1);
    });
  });
}
