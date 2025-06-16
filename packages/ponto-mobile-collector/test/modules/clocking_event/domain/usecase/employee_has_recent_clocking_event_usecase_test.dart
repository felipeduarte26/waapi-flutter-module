import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/employee_has_recent_clocking_event_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockSessionService extends Mock implements ISessionService {}

class MockClockingEventRepository extends Mock
    implements IClockingEventRepository {}

class MockInternalClockService extends Mock
    implements clock.IInternalClockService {}

class FakeClockingEvent extends Fake
    implements ClockingEvent {
  @override
  DateTime getDateTimeEvent() {
    return DateTime.parse('2023-07-28T15:28:33Z');
  }
}

void main() {
  late ISessionService sessionService;
  late IClockingEventRepository clockingEventRepository;
  late clock.IInternalClockService internalClockService;
  String employeeId = 'employeeId';
  late ClockingEvent? clockingEvent;

  setUp(
    () {
      sessionService = MockSessionService();
      clockingEventRepository = MockClockingEventRepository();
      internalClockService = MockInternalClockService();

      when(
        () => sessionService.getEmployeeId(),
      ).thenReturn(employeeId);
    },
  );

  group(
    'EmployeeHasRecentClockingEventUsecase',
    () {
      test(
        'call no clocking events test.',
        () async {
          IEmployeeHasRecentClockingEventUsecase
              employeeHasRecentClockingEventUsecase =
              EmployeeHasRecentClockingEventUsecase(
            sessionService: sessionService,
            clockingEventRepository: clockingEventRepository,
            internalClockService: internalClockService,
          );

          when(
            () => clockingEventRepository.findLastClockingEventByEmployeeId(
              employeeId: employeeId,
            ),
          ).thenAnswer((invocation) => Future.value(null));

          bool hasRecentClockingEvent =
              await employeeHasRecentClockingEventUsecase.call(
            clockingEventRegisterType: ClockingEventRegisterTypeSession(),
          );

          expect(hasRecentClockingEvent, false);

          verify(
            () => sessionService.getEmployeeId(),
          ).called(1);

          verify(
            () => clockingEventRepository.findLastClockingEventByEmployeeId(
              employeeId: employeeId,
            ),
          ).called(1);

          verifyNoMoreInteractions(sessionService);
          verifyNoMoreInteractions(clockingEventRepository);
        },
      );

      test(
        'call with clocking events less 2 minutes test.',
        () async {
          IEmployeeHasRecentClockingEventUsecase
              employeeHasRecentClockingEventUsecase =
              EmployeeHasRecentClockingEventUsecase(
            sessionService: sessionService,
            clockingEventRepository: clockingEventRepository,
            internalClockService: internalClockService,
          );

          DateTime timeClock = DateTime.parse('2023-07-28T15:29:33Z');

          clockingEvent = FakeClockingEvent();

          when(
            () => clockingEventRepository.findLastClockingEventByEmployeeId(
              employeeId: employeeId,
            ),
          ).thenAnswer((invocation) => Future.value(clockingEvent));

          when(
            () => internalClockService.getClockDateTime(),
          ).thenReturn(timeClock);

          bool hasRecentClockingEvent =
              await employeeHasRecentClockingEventUsecase.call(
            clockingEventRegisterType: ClockingEventRegisterTypeSession(),
          );

          expect(hasRecentClockingEvent, true);

          verify(
            () => sessionService.getEmployeeId(),
          ).called(1);

          verify(
            () => clockingEventRepository.findLastClockingEventByEmployeeId(
              employeeId: employeeId,
            ),
          ).called(1);

          verify(
            () => internalClockService.getClockDateTime(),
          ).called(1);

          verifyNoMoreInteractions(sessionService);
          verifyNoMoreInteractions(clockingEventRepository);
          verifyNoMoreInteractions(internalClockService);
        },
      );
    },
  );
}
