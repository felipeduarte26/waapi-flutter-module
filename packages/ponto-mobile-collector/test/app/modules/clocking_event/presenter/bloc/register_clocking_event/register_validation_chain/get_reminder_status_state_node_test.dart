import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/employee_has_reminder_clocking_event_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_reminder_status_state_node.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../../mocks/employee_dto_mock.dart';

class MockEmployeeHasReminderClockingEventUseCase extends Mock
    implements IEmployeeHasReminderClockingEventUseCase {}

class MockNavigatorService extends Mock implements NavigatorService {}

class MockLogService extends Mock implements LogService {}

class FakeBuildContext extends Fake implements BuildContext {}

class MockRegisterClockingEventBloc extends Mock
    implements RegisterClockingEventBloc {
  @override
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
}

void main() {
  late IEmployeeHasReminderClockingEventUseCase
      employeeHasReminderClockingEventUseCase;
  late GetReminderStatusStateNode getReminderStatusStateNode;
  late NavigatorService navigatorService;
  late RegisterClockingEventBloc registerClockingEventBloc;
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
  late LogService logService;
  late BuildContext buildContext;

  setUp(() {
    employeeHasReminderClockingEventUseCase =
        MockEmployeeHasReminderClockingEventUseCase();
    navigatorService = MockNavigatorService();
    registerClockingEventBloc = MockRegisterClockingEventBloc();
    logService = MockLogService();
    buildContext = FakeBuildContext();

    clockingEventRegisterEntity = ClockingEventRegisterEntity(
      clockingEventRegisterType: ClockingEventRegisterTypeSession(),
      dateTime: DateTime(2024, 3, 5),
      employeeDto: employeeMockDto,
    );
    registerClockingEventBloc = MockRegisterClockingEventBloc();
    registerClockingEventBloc.clockingEventRegisterEntity =
        clockingEventRegisterEntity;

    registerFallbackValue(ClockingEventRegisterTypeSession());

    when(
      () => logService.saveLocalLog(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    when(
      () => employeeHasReminderClockingEventUseCase.callInterJourney(
        employeeId: any(
          named: 'employeeId',
        ),
        clockingEventRegisterType: any(
          named: 'clockingEventRegisterType',
        ),
      ),
    ).thenAnswer(
      (_) async => null,
    );

    when(
      () => employeeHasReminderClockingEventUseCase.callIntraJourney(
        employeeId: any(
          named: 'employeeId',
        ),
        clockingEventRegisterType: any(
          named: 'clockingEventRegisterType',
        ),
      ),
    ).thenAnswer(
      (_) async => null,
    );

    when(
      () => navigatorService.pop(),
    ).thenReturn(null);

    getReminderStatusStateNode = GetReminderStatusStateNode(
      employeeHasReminderClockingEventUseCase:
          employeeHasReminderClockingEventUseCase,
      navigatorService: navigatorService,
      logService: logService,
    );

    getReminderStatusStateNode.setContext(
      buildContext,
      registerClockingEventBloc,
    );
  });

  Widget getWidget() {
    return MediaQuery(
      data: const MediaQueryData(size: Size(375, 667)),
      child: SeniorDesignSystem(
        theme: SENIOR_LIGHT_THEME,
        child: MaterialApp(
          theme: SENIOR_LIGHT_THEME.themeData,
          home: Localizations(
            delegates: const [
              CollectorLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: const Locale('pt'),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  return FilledButton(
                    child: const Text('showDialog'),
                    onPressed: () async {
                      getReminderStatusStateNode.setContext(
                        context,
                        registerClockingEventBloc,
                      );
                      await getReminderStatusStateNode.handler();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('GetReminderStatusStateNode', () {
    test('no recent register test', () async {
      final result = await getReminderStatusStateNode.handler();
      expect(result, isNull);

      verify(
        () => employeeHasReminderClockingEventUseCase.callIntraJourney(
          employeeId: any(
            named: 'employeeId',
          ),
          clockingEventRegisterType: any(
            named: 'clockingEventRegisterType',
          ),
        ),
      ).called(1);
    });

    testWidgets('show camera message confirmation test', (tester) async {
      when(
        () => employeeHasReminderClockingEventUseCase.callInterJourney(
          employeeId: any(
            named: 'employeeId',
          ),
          clockingEventRegisterType: any(
            named: 'clockingEventRegisterType',
          ),
        ),
      ).thenAnswer(
        (_) async => DateTime.parse('2023-07-28T11:30:33Z'),
      );

      await tester.pumpWidget(getWidget());
      Finder buttonFinder = find.text('showDialog');
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(find.text('Atenção'), findsOneWidget);
      expect(
        find.text(
          'Você marcou o ponto há menos de 11h30. No intervalo para descanso entre jornadas é importante completar o período mínimo antes de retornar ao trabalho.',
        ),
        findsOneWidget,
      );
      expect(find.text('Não realizar marcação'), findsOneWidget);

      await tester.tap(find.text('Confirmar marcação'));

      verify(() => navigatorService.pop());
    });

    testWidgets('show camera message cancel test', (tester) async {
      when(
        () => employeeHasReminderClockingEventUseCase.callIntraJourney(
          employeeId: any(
            named: 'employeeId',
          ),
          clockingEventRegisterType: any(
            named: 'clockingEventRegisterType',
          ),
        ),
      ).thenAnswer(
        (_) async => DateTime.parse('2023-07-28T01:30:33Z'),
      );

      await tester.pumpWidget(getWidget());
      Finder buttonFinder = find.text('showDialog');
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Não realizar marcação'));

      verify(() => navigatorService.pop());
    });
  });
}
