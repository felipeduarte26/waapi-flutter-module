// ignore_for_file: unused_local_variable

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/entities/reminder.dart';
import '../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../core/domain/input_model/clocking_event_register_type.dart';
import '../../../../core/domain/input_model/reminder_dto.dart';
import '../../../../core/domain/repositories/database/ireminder_repository.dart';
import '../../../../core/external/mappers/clocking_event_mapper.dart';
import '../../../../core/external/mappers/reminder_mapper.dart';

abstract class IEmployeeHasReminderClockingEventUseCase {
  Future<DateTime?> callIntraJourney({
    required ClockingEventRegisterType clockingEventRegisterType,
    String? employeeId,
  });

  Future<DateTime?> callInterJourney({
    required ClockingEventRegisterType clockingEventRegisterType,
    String? employeeId,
  });
}

class EmployeeHasReminderClockingEventUseCase
    implements IEmployeeHasReminderClockingEventUseCase {
  final ISessionService _sessionService;
  final IJourneyRepository _journeyRepository;
  final IClockingEventRepository _clockingEventRepository;
  final clock.IInternalClockService _internalClockService;
  final IReminderRepository _reminderRepository;
  final IUtils _utils;
  final ClockingEventMapper _clockingEventMapper;

  const EmployeeHasReminderClockingEventUseCase({
    required ISessionService sessionService,
    required IJourneyRepository journeyRepository,
    required IClockingEventRepository clockingEventRepository,
    required clock.IInternalClockService internalClockService,
    required IReminderRepository reminderRepository,
    required IUtils utils,
    required ClockingEventMapper clockingEventMapper,
  })  : _sessionService = sessionService,
        _journeyRepository = journeyRepository,
        _clockingEventRepository = clockingEventRepository,
        _internalClockService = internalClockService,
        _reminderRepository = reminderRepository,
        _utils = utils,
        _clockingEventMapper = clockingEventMapper;

  @override
  Future<DateTime?> callIntraJourney({
    required ClockingEventRegisterType clockingEventRegisterType,
    String? employeeId,
  }) async {
    employeeId ??= _sessionService.getEmployeeId();

    final isRegisterTypeDriver =
        clockingEventRegisterType is ClockingEventRegisterTypeDriver;

    return isRegisterTypeDriver
        ? await driverIntraJourney(
            employeeId: employeeId,
            clockingEventRegisterTypeDriver: clockingEventRegisterType,
          )
        : await individualIntraJourney(employeeId: employeeId);
  }

  @override
  Future<DateTime?> callInterJourney({
    required ClockingEventRegisterType clockingEventRegisterType,
    String? employeeId,
  }) async {
    employeeId ??= _sessionService.getEmployeeId();

    final isRegisterTypeDriver =
        clockingEventRegisterType is ClockingEventRegisterTypeDriver;

    return isRegisterTypeDriver
        ? await driverInterJourney(employeeId: employeeId)
        : await individualInterJourney(employeeId: employeeId);
  }

  Future<DateTime?> driverIntraJourney({
    required String employeeId,
    required ClockingEventRegisterTypeDriver clockingEventRegisterTypeDriver,
  }) async {
    final clockingEvents = await getCurrentJourneyClockingEvents(
      employeeId: employeeId,
    );

    if (clockingEvents.isEmpty) {
      return null;
    }

    final allLastMealBreaks = filterClocinkgEventsByLastMealBreaks(
      clockingEvents: clockingEvents,
    );

    if (allLastMealBreaks.isEmpty || _utils.isEven(allLastMealBreaks.length)) {
      return null;
    }

    final lastClockingEvent = clockingEvents.last;

    final intraReminders = await getIntraReminders(
      employeeId: employeeId,
    );
    const minimumMinutes = 0;
    DateTime? value;

    for (final reminder in intraReminders) {
      if (reminder.enabled) {
        final difference = _internalClockService
            .getClockDateTime()
            .difference(lastClockingEvent.getDateTimeEvent())
            .inMinutes;
        final minimumMinutesFromPlatform = _utils.convertDateTimeToMinutes(
          reminder.period,
        );

        if (difference >= minimumMinutes &&
            difference < minimumMinutesFromPlatform) {
          value = reminder.period;
        }
        //value = reminder.period;
      }
    }

    return value;
  }

  Future<DateTime?> individualIntraJourney({
    required String employeeId,
  }) async {
    final clockingEvents = await getTodayClockingEvents(
      employeeId: employeeId,
    );

    if (clockingEvents.isEmpty || !_utils.isEven(clockingEvents.length)) {
      return null;
    }

    final lastClockingEvent = clockingEvents.last;
    final intraReminders = await getIntraReminders(
      employeeId: employeeId,
    );
    const minimumMinutes = 2;
    DateTime? value;

    for (final reminder in intraReminders) {
      if (reminder.enabled) {
        final difference = _internalClockService
            .getClockDateTime()
            .difference(lastClockingEvent.getDateTimeEvent())
            .inMinutes;
        final minimumMinutesFromPlatform = _utils.convertDateTimeToMinutes(
          reminder.period,
        );

        if (difference >= minimumMinutes &&
            difference < minimumMinutesFromPlatform) {
          value = reminder.period;
        }
      }
    }

    return value;
  }

  Future<DateTime?> driverInterJourney({
    required String employeeId,
  }) async {
    final clockingEvents = await getCurrentJourneyClockingEvents(
      employeeId: employeeId,
    );

    if (clockingEvents.isNotEmpty) {
      return null;
    }

    final lastClockingEvent = await getLastClockingEvent(
      employeeId: employeeId,
    );

    if (lastClockingEvent == null) {
      return null;
    }

    final interReminders = await getInterReminders(
      employeeId: employeeId,
    );
    const minimumMinutes = 360;
    DateTime? value;

    for (final reminder in interReminders) {
      if (reminder.enabled) {
        final difference = _internalClockService
            .getClockDateTime()
            .difference(lastClockingEvent.getDateTimeEvent())
            .inMinutes;
        final minimumMinutesFromPlatform = _utils.convertDateTimeToMinutes(
          reminder.period,
        );

        if (difference >= minimumMinutes &&
            difference < minimumMinutesFromPlatform) {
          value = reminder.period;
        }
      }
    }

    return value;
  }

  Future<DateTime?> individualInterJourney({
    required String employeeId,
  }) async {
    var clockingEvents = await getTodayClockingEvents(
      employeeId: employeeId,
    );

    if (clockingEvents.isEmpty) {
      clockingEvents =
          await getAtLeastPastSixHoursClockingEvents(employeeId: employeeId);
    }

    if (clockingEvents.isEmpty || !_utils.isEven(clockingEvents.length)) {
      return null;
    }

    final lastClockingEvent = clockingEvents.last;
    final interReminders = await getInterReminders(
      employeeId: employeeId,
    );
    const minimumMinutes = 360;
    DateTime? value;

    for (final reminder in interReminders) {
      if (reminder.enabled) {
        final difference = _internalClockService
            .getClockDateTime()
            .difference(lastClockingEvent.getDateTimeEvent())
            .inMinutes;
        final minimumMinutesFromPlatform = _utils.convertDateTimeToMinutes(
          reminder.period,
        );

        if (difference >= minimumMinutes &&
            difference < minimumMinutesFromPlatform) {
          value = reminder.period;
        }
      }
    }

    return value;
  }

  Future<List<ClockingEventDto>> getCurrentJourneyClockingEvents({
    required String employeeId,
  }) async {
    final currentJourney = await _journeyRepository
        .findCurrentJourneyByEmployeeId(employeeId: employeeId);

    if (currentJourney == null) {
      return [];
    }

    List<ClockingEvent> entityList =
        await _clockingEventRepository.findAllByJourneyId(
      journeyId: currentJourney.id,
    );
    if (entityList.isEmpty) {
      return [];
    }
    return await _clockingEventMapper.fromEntityToDtoCollectorList(entityList);
  }

  Future<List<ClockingEventDto>> getTodayClockingEvents({
    required String employeeId,
  }) async {
    List<ClockingEventDto> clockingEvents = [];
    List<ClockingEvent> entityList = await _clockingEventRepository.findByDate(
      date: _internalClockService.getClockDateTime(),
      employeeId: employeeId,
    );
    if (entityList.isNotEmpty) {
      return await _clockingEventMapper
          .fromEntityToDtoCollectorList(entityList);
    }
    return clockingEvents;
  }

  Future<List<ClockingEventDto>> getAtLeastPastSixHoursClockingEvents({
    required String employeeId,
  }) async {
    List<ClockingEvent> entityList = await _clockingEventRepository.findByDate(
      date: _internalClockService
          .getClockDateTime()
          .subtract(const Duration(hours: 6)),
      employeeId: employeeId,
    );
    return await _clockingEventMapper.fromEntityToDtoCollectorList(entityList);
  }

  List<ClockingEventDto> filterClocinkgEventsByLastMealBreaks({
    required List<ClockingEventDto> clockingEvents,
  }) {
    return clockingEvents.reversed
        .takeWhile((clockingEvent) => clockingEvent.isMealBreak ?? false)
        .toList();
  }

  Future<ClockingEventDto?> getLastClockingEvent({
    required String employeeId,
  }) async {
    var lastClockingEvent = await _clockingEventRepository
        .findLastClockingEventByEmployeeId(employeeId: employeeId);
    if (lastClockingEvent == null) {
      return null;
    }
    return _clockingEventMapper.fromEntityToDtoCollector(lastClockingEvent);
  }

  Future<List<ReminderDto>> getRemindersAndFilterByType({
    required String employeeId,
    required ReminderType reminderType,
  }) async {
    List<Reminder>? reminders = await _reminderRepository.findAllByEmployeeId(
      employeeId: employeeId,
    );
    List<ReminderDto> reminderDtoList =
        ReminderMapper.fromEntityToDtoCollectorList(reminders)!;
    return reminderDtoList
        .where((reminder) => reminder.type == reminderType)
        .toList();
  }

  Future<List<ReminderDto>> getIntraReminders({
    required String employeeId,
  }) async {
    return await getRemindersAndFilterByType(
      employeeId: employeeId,
      reminderType: ReminderType.intrajourney,
    );
  }

  Future<List<ReminderDto>> getInterReminders({
    required String employeeId,
  }) async {
    return await getRemindersAndFilterByType(
      employeeId: employeeId,
      reminderType: ReminderType.interjourney,
    );
  }
}
