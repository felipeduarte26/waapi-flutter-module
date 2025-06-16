import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_use_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_employee_node.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../../../mocks/employee_dto_mock.dart';
import '../../../../../../../mocks/employee_entity_mock.dart';

class MckEmployeeRepository extends Mock implements IEmployeeRepository {}

class MockSessionService extends Mock implements ISessionService {}

class MockLogService extends Mock implements LogService {}

class MockRegisterClockingEventBloc
    extends MockBloc<RegisterClockingEventEvent, RegisterClockingState>
    implements RegisterClockingEventBloc {
  @override
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
}

void main() {
  String tEmployeeId = 'tEmployeeId';
  String tJourneyId = 'tJourneyId';
  DateTime date = DateTime(2024, 3, 4);
  late GetEmployeeNode getEmployeeNode;
  late IEmployeeRepository employeeRepository;
  late ISessionService sessionService;
  late RegisterClockingEventBloc registerClockingEventBloc;
  late LogService logService;

  setUp(() {
    employeeRepository = MckEmployeeRepository();
    sessionService = MockSessionService();
    registerClockingEventBloc = MockRegisterClockingEventBloc();
    logService = MockLogService();

    when(
      () => sessionService.getEmployee(),
    ).thenReturn(employeeMockDto);

    when(
      () => employeeRepository.findById(id: tEmployeeId),
    ).thenAnswer(
      (_) async => employeeEntityMock,
    );

    when(
      () => logService.saveLocalLog(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    getEmployeeNode = GetEmployeeNode(
      employeeRepository: employeeRepository,
      sessionService: sessionService,
      logService: logService,
    );

    registerClockingEventBloc.clockingEventRegisterEntity =
        ClockingEventRegisterEntity(
      dateTime: date,
      clockingEventRegisterType: ClockingEventRegisterTypeSession(),
    );

    getEmployeeNode.setContext(registerClockingEventBloc);
  });

  group('GetEmployeeNode', () {
    test('define ClockingEventRegisterTypeSession register type test',
        () async {
      await getEmployeeNode.handler();
      verify(() => sessionService.getEmployee()).called(1);
    });

    test('define ClockingEventRegisterTypeSession register type test',
        () async {
      registerClockingEventBloc.clockingEventRegisterEntity =
          ClockingEventRegisterEntity(
        dateTime: date,
        clockingEventRegisterType: ClockingEventRegisterTypeDriver(
          journeyEventName: 'StartJourneyEvent',
          journeyId: tJourneyId,
          clockingEventUse: ClockingEventUseType.clockingEvent,
          isMealBreak: false,
        ),
      );

      await getEmployeeNode.handler();
      verify(() => sessionService.getEmployee());
    });

    test('define ClockingEventRegisterTypeNFC register type test', () async {
      registerClockingEventBloc.clockingEventRegisterEntity =
          ClockingEventRegisterEntity(
        dateTime: date,
        clockingEventRegisterType: ClockingEventRegisterTypeNFC(
          employeeId: tEmployeeId,
        ),
      );

      await getEmployeeNode.handler();
      verify(() => employeeRepository.findById(id: tEmployeeId)).called(1);
    });

    test('define ClockingEventRegisterTypeQRCode register type test', () async {
      registerClockingEventBloc.clockingEventRegisterEntity =
          ClockingEventRegisterEntity(
        dateTime: date,
        clockingEventRegisterType: ClockingEventRegisterTypeQRCode(
          employeeId: tEmployeeId,
        ),
      );

      await getEmployeeNode.handler();
      verify(() => employeeRepository.findById(id: tEmployeeId)).called(1);
    });

    test('define ClockingEventRegisterTypeFacialRecognition register type test',
        () async {
      registerClockingEventBloc.clockingEventRegisterEntity =
          ClockingEventRegisterEntity(
        dateTime: date,
        clockingEventRegisterType: ClockingEventRegisterTypeFacialRecognition(
          employeeId: tEmployeeId,
        ),
      );

      await getEmployeeNode.handler();
      verify(() => employeeRepository.findById(id: tEmployeeId)).called(1);
    });

    test('define ClockingEventRegisterTypeEmailPassword register type test',
        () async {
      registerClockingEventBloc.clockingEventRegisterEntity =
          ClockingEventRegisterEntity(
        dateTime: date,
        clockingEventRegisterType: ClockingEventRegisterTypeEmailPassword(
          employeeId: tEmployeeId,
        ),
      );

      await getEmployeeNode.handler();
      verify(() => employeeRepository.findById(id: tEmployeeId)).called(1);
    });
  });
}
