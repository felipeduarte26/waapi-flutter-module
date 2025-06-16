import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/journey_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/reminder.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/ireminder_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/clocking_event_mapper.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/employee_has_reminder_clocking_event_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/clocking_event_mock.dart';

class MockSessionService extends Mock implements ISessionService {}

class MockJourneyRepository extends Mock implements IJourneyRepository {}

class MockClockingEventRepository extends Mock
    implements IClockingEventRepository {}

class MockClockingEventMapper extends Mock implements ClockingEventMapper {}

class MockInternalClockService extends Mock
    implements clock.IInternalClockService {}

class MockReminderRepository extends Mock implements IReminderRepository {}

class MockUtils extends Mock implements IUtils {}

class FakeClockingEvent extends Fake implements ClockingEvent {
  final DateTime _dateTimeEvent;

  @override
  final bool isMealBreak;

  FakeClockingEvent({
    DateTime? dateTimeEvent,
    this.isMealBreak = false,
  }) : _dateTimeEvent = dateTimeEvent ?? DateTime.parse('2000-01-01T12:00:00Z');

  @override
  DateTime getDateTimeEvent() {
    return _dateTimeEvent;
  }
}

class FakeClockingEventDto extends Fake implements ClockingEventDto {
  final DateTime _dateTimeEvent;

  @override
  final bool isMealBreak;

  FakeClockingEventDto({
    DateTime? dateTimeEvent,
    this.isMealBreak = false,
  }) : _dateTimeEvent = dateTimeEvent ?? DateTime.parse('2000-01-01T12:00:00Z');

  @override
  DateTime getDateTimeEvent() {
    return _dateTimeEvent;
  }
}

class FakeIntraReminder extends Fake implements Reminder {
  @override
  final String id;

  @override
  final bool enabled;

  @override
   final period = DateFormat('HH:mm:ss').parse('01:30:00');

  @override
  final type = ReminderType.intrajourney;

  FakeIntraReminder({
    this.id = 'reminderId',
    this.enabled = true,
  });

  int get periodInMinutes => period.hour * 60 + period.minute;
}

class FakeInterReminder extends Fake implements Reminder {
  @override
  final String id;

  @override
  final bool enabled;

  @override
  final period = DateFormat('HH:mm:ss').parse('11:00:00');

  @override
  final type = ReminderType.interjourney;

  FakeInterReminder({
    this.id = 'reminderId',
    this.enabled = true,
  });

  int get periodInMinutes => period.hour * 60 + period.minute;
}

class FakeJourneyEntity extends Fake implements JourneyEntity {
  @override
  final String id = 'journeyId';
}

class FakeClockingEventRegisterTypeDriver extends Fake
    implements ClockingEventRegisterTypeDriver {}

class FakeClockingEventRegisterTypeSession extends Fake
    implements ClockingEventRegisterTypeSession {}

void main() {
  late ISessionService sessionService;
  late IJourneyRepository journeyRepository;
  late IClockingEventRepository clockingEventRepository;
  late clock.IInternalClockService internalClockService;
  late IReminderRepository reminderRepository;
  late IUtils utils;
  late IEmployeeHasReminderClockingEventUseCase
      employeeHasReminderClockingEventUseCase;
  late ClockingEventMapper clockingEventMapper;

  const employeeId = 'employeeId';
  final clockingEventRegisterTypeDriver = FakeClockingEventRegisterTypeDriver();
  final clockingEventRegisterTypeSession =
      FakeClockingEventRegisterTypeSession();

  setUpAll(() {
    registerFallbackValue(clockingEventMock);
  });

  setUp(() {
    sessionService = MockSessionService();
    journeyRepository = MockJourneyRepository();
    clockingEventRepository = MockClockingEventRepository();
    internalClockService = MockInternalClockService();
    reminderRepository = MockReminderRepository();
    utils = MockUtils();
    clockingEventMapper = MockClockingEventMapper();

    employeeHasReminderClockingEventUseCase =
        EmployeeHasReminderClockingEventUseCase(
      sessionService: sessionService,
      journeyRepository: journeyRepository,
      clockingEventRepository: clockingEventRepository,
      internalClockService: internalClockService,
      reminderRepository: reminderRepository,
      utils: utils,
      clockingEventMapper: clockingEventMapper,
    );

    when(() => sessionService.getEmployeeId()).thenReturn(employeeId);

    when(() => clockingEventMapper.fromEntityToDtoCollectorList(any()))
        .thenAnswer((_) async => [FakeClockingEventDto()]);

    when(() => utils.isEven(any())).thenReturn(true);

    when(
      () => reminderRepository.findAllByEmployeeId(
        employeeId: any(named: 'employeeId'),
      ),
    ).thenAnswer((_) async => [FakeIntraReminder(), FakeInterReminder()]);

    when(() => utils.convertDateTimeToMinutes(any())).thenReturn(90);
  });

  group(
    'EmployeeHasReminderClockingEventUseCase',
    () {
      group(
        'Intra Journey',
        () {
          group(
            'Driver',
            () {
              test(
                'return null when has no journey running (no one found)',
                () async {
                  when(
                    () => journeyRepository.findCurrentJourneyByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => null,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callIntraJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeDriver,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when has no journey running (found but has no clocking events)',
                () async {
                  when(
                    () => journeyRepository.findCurrentJourneyByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => FakeJourneyEntity(),
                  );

                  when(
                    () => clockingEventRepository.findAllByJourneyId(
                      journeyId: any(named: 'journeyId'),
                    ),
                  ).thenAnswer(
                    (_) async => [],
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callIntraJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeDriver,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when has no last meal breaks',
                () async {
                  when(
                    () => journeyRepository.findCurrentJourneyByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => FakeJourneyEntity(),
                  );

                  when(
                    () => clockingEventRepository.findAllByJourneyId(
                      journeyId: any(named: 'journeyId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      clockingEventMock,
                    ],
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callIntraJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeDriver,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when has even meal breaks',
                () async {
                  when(
                    () => journeyRepository.findCurrentJourneyByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => FakeJourneyEntity(),
                  );

                  when(
                    () => clockingEventRepository.findAllByJourneyId(
                      journeyId: any(named: 'journeyId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      clockingEventMock,
                      clockingEventMock,
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    true,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callIntraJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeDriver,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when has no intra reminder',
                () async {
                  when(
                    () => journeyRepository.findCurrentJourneyByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => FakeJourneyEntity(),
                  );

                  when(
                    () => clockingEventRepository.findAllByJourneyId(
                      journeyId: any(named: 'journeyId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      clockingEventMock,
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    false,
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeInterReminder(),
                    ],
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callIntraJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeDriver,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when reminder is not enabled',
                () async {
                  when(
                    () => journeyRepository.findCurrentJourneyByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => FakeJourneyEntity(),
                  );

                  when(
                    () => clockingEventRepository.findAllByJourneyId(
                      journeyId: any(named: 'journeyId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      clockingEventMock,
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    false,
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(
                        enabled: false,
                      ),
                      FakeInterReminder(),
                    ],
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callIntraJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeDriver,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when reminder is not necessary',
                () async {
                  when(
                    () => journeyRepository.findCurrentJourneyByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => FakeJourneyEntity(),
                  );

                  when(
                    () => clockingEventRepository.findAllByJourneyId(
                      journeyId: any(named: 'journeyId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeClockingEvent(
                        dateTimeEvent: DateTime.parse('2000-01-01T08:00:00Z'),
                      ),
                      clockingEventMock,
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    false,
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(),
                      FakeInterReminder(),
                    ],
                  );

                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.parse('2000-01-01T13:30:00Z'),
                  );

                  when(
                    () => utils.convertDateTimeToMinutes(
                      any(),
                    ),
                  ).thenReturn(
                    FakeIntraReminder().periodInMinutes,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callIntraJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeDriver,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return datetime value to reminder',
                () async {
                  when(
                    () => journeyRepository.findCurrentJourneyByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => FakeJourneyEntity(),
                  );

                  when(
                    () => clockingEventRepository.findAllByJourneyId(
                      journeyId: any(named: 'journeyId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeClockingEvent(
                        dateTimeEvent: DateTime.parse('2000-01-01T08:00:00Z'),
                      ),
                      FakeClockingEvent(
                        isMealBreak: true,
                      ),
                    ],
                  );

                  when(
                    () =>
                        clockingEventMapper.fromEntityToDtoCollectorList(any()),
                  ).thenAnswer(
                    (_) async => [
                      FakeClockingEventDto(
                        dateTimeEvent: DateTime.parse('2000-01-01T08:00:00Z'),
                      ),
                      FakeClockingEventDto(
                        isMealBreak: true,
                      ),
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    false,
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(),
                      FakeInterReminder(),
                    ],
                  );

                     when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.parse('2000-01-01T13:00:00Z'),
                  );


                  when(
                    () => utils.convertDateTimeToMinutes(
                      any(),
                    ),
                  ).thenReturn(
                    FakeIntraReminder().periodInMinutes,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callIntraJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeDriver,
                  );

                  expect(
                    value,
                    FakeIntraReminder().period,
                  );
                },
              );
            },
          );

          group(
            'Individual',
            () {
              test(
                'return null when has no clocking events',
                () async {
                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.now(),
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: any(named: 'date'),
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [],
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callIntraJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeSession,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when has no even clocking events',
                () async {
                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.now(),
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: any(named: 'date'),
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      clockingEventMock,
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    false,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callIntraJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeSession,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when has no intra reminder',
                () async {
                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.now(),
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: any(named: 'date'),
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      clockingEventMock,
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    true,
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeInterReminder(),
                    ],
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callIntraJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeSession,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when reminder is not enabled',
                () async {
                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.now(),
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: any(named: 'date'),
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      clockingEventMock,
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    true,
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(
                        enabled: false,
                      ),
                      FakeInterReminder(),
                    ],
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callIntraJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeSession,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when reminder is not necessary',
                () async {
                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.parse('2000-01-01T13:30:00Z'),
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: any(named: 'date'),
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeClockingEvent(
                        dateTimeEvent: DateTime.parse('2000-01-01T08:00:00Z'),
                      ),
                      clockingEventMock,
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    true,
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(),
                      FakeInterReminder(),
                    ],
                  );

                  when(
                    () => utils.convertDateTimeToMinutes(
                      any(),
                    ),
                  ).thenReturn(
                    FakeIntraReminder().periodInMinutes,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callIntraJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeSession,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return datetime value to reminder',
                () async {
                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.parse('2000-01-01T13:00:00Z'),
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: any(named: 'date'),
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeClockingEvent(
                        dateTimeEvent: DateTime.parse('2000-01-01T08:00:00Z'),
                      ),
                      clockingEventMock,
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    true,
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(),
                      FakeInterReminder(),
                    ],
                  );
                  

                  when(
                    () => utils.convertDateTimeToMinutes(
                      any(),
                    ),
                  ).thenReturn(
                    FakeIntraReminder().periodInMinutes,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callIntraJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeSession,
                  );

                  expect(
                    value,
                    FakeIntraReminder().period,
                  );
                },
              );
            },
          );
        },
      );

      group(
        'Inter Journey',
        () {
          group(
            'Driver',
            () {
              test(
                'return null when has journey running',
                () async {
                  when(
                    () => journeyRepository.findCurrentJourneyByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => FakeJourneyEntity(),
                  );

                  when(
                    () => clockingEventRepository.findAllByJourneyId(
                      journeyId: any(named: 'journeyId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      clockingEventMock,
                    ],
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeDriver,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when has no last clocking event',
                () async {
                  when(
                    () => journeyRepository.findCurrentJourneyByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => null,
                  );

                  when(
                    () => clockingEventRepository
                        .findLastClockingEventByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => null,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeDriver,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

             /* test(
                'return null when has no inter reminder',
                () async {
                  when(
                    () => journeyRepository.findCurrentJourneyByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => null,
                  );

                  when(
                    () => clockingEventRepository
                        .findLastClockingEventByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => FakeClockingEvent(
                      dateTimeEvent: DateTime.parse('2000-01-01T18:00:00Z'),
                    ),
                  );

                  when(
                    () => clockingEventMapper
                        .fromEntityToDtoCollectorList(any()),
                  ).thenAnswer(
                    (_) async => [
                      FakeClockingEventDto(
                        dateTimeEvent: DateTime.parse('2000-01-01T18:00:00Z'),
                      ),
                    ],
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(),
                    ],
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeDriver,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );*/

             /* test(
                'return null when reminder is not enabled',
                () async {
                  when(
                    () => journeyRepository.findCurrentJourneyByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => null,
                  );

                  when(
                    () => clockingEventRepository
                        .findLastClockingEventByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => FakeClockingEvent(
                      dateTimeEvent: DateTime.parse('2000-01-01T18:00:00Z'),
                    ),
                  );
                    when(
                    () => clockingEventMapper
                        .fromEntityToDtoCollectorList(
                      any(),
                    ),
                  ).thenAnswer(
                    (_) async => [FakeClockingEventDto(
                      dateTimeEvent: DateTime.parse('2000-01-01T18:00:00Z'),
                    ),],
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(),
                      FakeInterReminder(
                        enabled: false,
                      ),
                    ],
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeDriver,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );*/

              /*test(
                'return null when reminder is not necessary (has no minimum minutes)',
                () async {
                  when(
                    () => journeyRepository.findCurrentJourneyByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => null,
                  );

                  when(
                    () => clockingEventRepository
                        .findLastClockingEventByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => FakeClockingEvent(
                      dateTimeEvent: DateTime.parse('2000-01-01T22:00:00Z'),
                    ),
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(),
                      FakeInterReminder(),
                    ],
                  );

                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.parse('2000-01-02T00:00:00Z'),
                  );

                  when(
                    () => utils.convertDateTimeToMinutes(
                      any(),
                    ),
                  ).thenReturn(
                    FakeInterReminder().periodInMinutes,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeDriver,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );*/

              /*test(
                'return null when reminder is not necessary',
                () async {
                  when(
                    () => journeyRepository.findCurrentJourneyByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => null,
                  );
                  var fakeclockingEvent = FakeClockingEvent(
                    dateTimeEvent: DateTime.parse('2000-01-01T18:00:00Z'),
                  );
                  when(
                    () => clockingEventRepository
                        .findLastClockingEventByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => fakeclockingEvent,
                  );
                  registerFallbackValue(fakeclockingEvent);

                  when(
                    () =>
                        clockingEventMapper.fromEntityToDtoCollectorList([fakeclockingEvent]),
                  ).thenAnswer(
                    (_) async => [
                      FakeClockingEventDto(
                        dateTimeEvent: DateTime.parse('2000-01-01T18:00:00Z'),
                      ),
                    ],
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(),
                      FakeInterReminder(),
                    ],
                  );

                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.parse('2000-01-02T08:00:00Z'),
                  );

                  when(
                    () => utils.convertDateTimeToMinutes(
                      any(),
                    ),
                  ).thenReturn(
                    FakeInterReminder().periodInMinutes,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeDriver,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return datetime to reminder',
                () async {
                  when(
                    () => journeyRepository.findCurrentJourneyByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => null,
                  );

                  when(
                    () => clockingEventRepository
                        .findLastClockingEventByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => FakeClockingEvent(
                      dateTimeEvent: DateTime.parse('2000-01-01T18:00:00Z'),
                    ),
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(),
                      FakeInterReminder(),
                    ],
                  );

                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.parse('2000-01-02T00:00:00Z'),
                  );
                  when(
                    () =>
                        clockingEventMapper.fromEntityToDtoCollectorList(any()),
                  ).thenAnswer(
                    (_) async => [
                      FakeClockingEventDto(
                        dateTimeEvent: DateTime.parse('2000-01-01T18:00:00Z'),
                      ),
                    ],
                  );

                  when(
                    () => utils.convertDateTimeToMinutes(
                      any(),
                    ),
                  ).thenReturn(
                    FakeInterReminder().periodInMinutes,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeDriver,
                  );

                  expect(
                    value,
                    FakeInterReminder().period,
                  );
                },
              );*/
            },
          );

          group(
            'Individual',
            () {
              test(
                'return null when has no clocking events',
                () async {
                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.now(),
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: any(named: 'date'),
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [],
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeSession,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when has no today clocking events, but has yesterday clocking events and is not even clocking events',
                () async {
                  final clockDateTime = DateTime.now();

                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    clockDateTime,
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: clockDateTime,
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [],
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: clockDateTime.subtract(const Duration(days: 1)),
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      clockingEventMock,
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    false,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeSession,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when has no even clocking events',
                () async {
                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.now(),
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: any(named: 'date'),
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      clockingEventMock,
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    false,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeSession,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when has no inter reminder',
                () async {
                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.now(),
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: any(named: 'date'),
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      clockingEventMock,
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    true,
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(),
                    ],
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeSession,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when reminder is not enabled',
                () async {
                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.now(),
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: any(named: 'date'),
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      clockingEventMock,
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    true,
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(),
                      FakeInterReminder(
                        enabled: false,
                      ),
                    ],
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeSession,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                'return null when reminder is not necessary (has no minimum minutes)',
                () async {
                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.parse('2000-01-01T13:30:00Z'),
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: any(named: 'date'),
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeClockingEvent(
                        dateTimeEvent: DateTime.parse('2000-01-01T08:00:00Z'),
                      ),
                      clockingEventMock,
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    true,
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(),
                      FakeInterReminder(),
                    ],
                  );

                  when(
                    () => utils.convertDateTimeToMinutes(
                      any(),
                    ),
                  ).thenReturn(
                    FakeInterReminder().periodInMinutes,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeSession,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                '''return null when reminder is not necessary (from yesterday's clocking event)''',
                () async {
                  final clockDateTime = DateTime.parse('2000-01-02T08:00:00Z');

                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    clockDateTime,
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: clockDateTime,
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [],
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: clockDateTime.subtract(const Duration(days: 1)),
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeClockingEvent(
                        dateTimeEvent: DateTime.parse('2000-01-01T08:00:00Z'),
                      ),
                      clockingEventMock,
                      FakeClockingEvent(
                        dateTimeEvent: DateTime.parse('2000-01-01T13:30:00Z'),
                      ),
                      FakeClockingEvent(
                        dateTimeEvent: DateTime.parse('2000-01-01T18:00:00Z'),
                      ),
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    true,
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(),
                      FakeInterReminder(),
                    ],
                  );

                  when(
                    () => utils.convertDateTimeToMinutes(
                      any(),
                    ),
                  ).thenReturn(
                    FakeInterReminder().periodInMinutes,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeSession,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              test(
                '''return null when reminder is not necessary (from today's clocking event)''',
                () async {
                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    DateTime.parse('2000-01-01T20:00:00Z'),
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: any(named: 'date'),
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeClockingEvent(
                        dateTimeEvent: DateTime.parse('2000-01-01T02:00:00Z'),
                      ),
                      FakeClockingEvent(
                        dateTimeEvent: DateTime.parse('2000-01-01T07:00:00Z'),
                      ),
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    true,
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(),
                      FakeInterReminder(),
                    ],
                  );

                  when(
                    () => utils.convertDateTimeToMinutes(
                      any(),
                    ),
                  ).thenReturn(
                    FakeInterReminder().periodInMinutes,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeSession,
                  );

                  expect(
                    value,
                    isNull,
                  );
                },
              );

              /*test(
                'return datetime value to reminder',
                () async {
                  final clockDateTime = DateTime.parse('2000-01-02T06:00:00Z');

                  when(
                    () => internalClockService.getClockDateTime(),
                  ).thenReturn(
                    clockDateTime,
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: clockDateTime,
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [],
                  );

                  when(
                    () => clockingEventRepository.findByDate(
                      date: clockDateTime.subtract(const Duration(days: 1)),
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeClockingEvent(
                        dateTimeEvent: DateTime.parse('2000-01-01T08:00:00Z'),
                      ),
                      FakeClockingEvent(
                        dateTimeEvent: DateTime.parse('2000-01-01T13:30:00Z'),
                      ),
                      FakeClockingEvent(
                        dateTimeEvent: DateTime.parse('2000-01-01T20:00:00Z'),
                      ),
                    ],
                  );

                  when(
                    () => utils.isEven(
                      any(),
                    ),
                  ).thenReturn(
                    true,
                  );

                  when(
                    () => reminderRepository.findAllByEmployeeId(
                      employeeId: any(named: 'employeeId'),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      FakeIntraReminder(),
                      FakeInterReminder(),
                    ],
                  );

                  when(
                    () => utils.convertDateTimeToMinutes(
                      any(),
                    ),
                  ).thenReturn(
                    FakeInterReminder().periodInMinutes,
                  );

                  final value = await employeeHasReminderClockingEventUseCase
                      .callInterJourney(
                    employeeId: employeeId,
                    clockingEventRegisterType: clockingEventRegisterTypeSession,
                  );

                  expect(
                    value?.toIso8601String(),
                    DateTime(
                      clockDateTime.year,
                      clockDateTime.month,
                      clockDateTime.day,
                      11, // Hora do FakeInterReminder
                      0,
                      0,
                    ).toIso8601String(),
                  );
                },
              );*/
            },
          );
        },
      );
    },
  );
}
