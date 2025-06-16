import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/fence_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/check_employee_in_fences_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_fence_status_state_node.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../../mocks/employee_dto_mock.dart';
import '../../../../../../../mocks/state_location_entity_mock.dart';

class CheckEmployeeInFencesUsecaseMock extends Mock
    implements ICheckEmployeeInFencesUsecase {}

class MockNavigatorService extends Mock implements NavigatorService {}

class BuildContextMock extends Mock implements BuildContext {}

class MockLogService extends Mock implements LogService {}

class MockRegisterClockingEventBloc extends Mock
    implements RegisterClockingEventBloc {
  @override
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
}

void main() {
  late GetFenceStatusStateNode getFenceStatusStateNode;
  late ICheckEmployeeInFencesUsecase checkEmployeeInFencesUsecase;
  late NavigatorService navigatorService;
  late RegisterClockingEventBloc registerClockingEventBloc;
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
  late BuildContext mockContext;
  late LogService logService;

  List<FenceDto>? fences = [];

  setUp(() {
    checkEmployeeInFencesUsecase = CheckEmployeeInFencesUsecaseMock();
    navigatorService = MockNavigatorService();
    registerClockingEventBloc = MockRegisterClockingEventBloc();
    logService = MockLogService();
    clockingEventRegisterEntity = ClockingEventRegisterEntity(
      clockingEventRegisterType: ClockingEventRegisterTypeSession(),
      dateTime: DateTime(2024, 3, 5),
      location: stateLocationEntityMock,
      employeeDto: employeeMockDto,
    );
    registerClockingEventBloc.clockingEventRegisterEntity =
        clockingEventRegisterEntity;
    mockContext = BuildContextMock();

    registerFallbackValue(clockingEventRegisterEntity.location);
    registerFallbackValue(fences);

    when(
      () => checkEmployeeInFencesUsecase.call(
        location: any(named: 'location'),
        fences: any(named: 'fences'),
      ),
    ).thenReturn(true);

    when(
      () => navigatorService.pop(),
    ).thenReturn(null);

    when(
      () => logService.saveLocalLog(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    getFenceStatusStateNode = GetFenceStatusStateNode(
      checkEmployeeInFencesUsecase: checkEmployeeInFencesUsecase,
      navigatorService: navigatorService,
      logService: logService,
    );

    getFenceStatusStateNode.setContext(
      mockContext,
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
                    getFenceStatusStateNode.setContext(
                      context,
                      registerClockingEventBloc,
                    );
                    getFenceStatusStateNode.handler();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  group('GetFenceStatusStateNode', () {
    test('location is in fence teste', () async {
      dynamic result = await getFenceStatusStateNode.handler();

      expect(result, null);

      verify(
        () => checkEmployeeInFencesUsecase.call(
          location: any(named: 'location'),
          fences: any(named: 'fences'),
        ),
      ).called(1);
    });

    testWidgets('show fence message teste', (tester) async {
      when(
        () => checkEmployeeInFencesUsecase.call(
          location: any(named: 'location'),
          fences: any(named: 'fences'),
        ),
      ).thenReturn(false);

      await tester.pumpWidget(getWidget());
      Finder buttonFinder = find.text('showDialog');
      expect(buttonFinder, findsOneWidget);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(find.text('cancel'), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
      expect(find.text('message'), findsOneWidget);
      await tester.tap(find.text('confirm'));

      verify(() => navigatorService.pop()).called(1);
    });
  });
}
