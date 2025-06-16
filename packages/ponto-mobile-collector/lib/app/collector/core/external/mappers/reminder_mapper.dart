import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:intl/intl.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

import '../../domain/entities/reminder.dart';
import '../../domain/enums/reminder_type.dart';
import '../../domain/input_model/reminder_dto.dart';

class ReminderMapper {
  static List<ReminderDto>? fromClockToCollectorDtoList(
    List<clock.ReminderDto>? clockList,
  ) {
    if (clockList == null) {
      return null;
    }
    List<ReminderDto> remindersList = [];
    for (var reminder in clockList) {
      var reminderCollector = fromClockToCollectorDto(reminder);
      if (reminderCollector != null) {
        remindersList.add(reminderCollector);
      }
    }
    return remindersList;
  }

  static ReminderDto? fromClockToCollectorDto(clock.ReminderDto? dtoClock) {
    if (dtoClock == null) {
      return null;
    }
    return ReminderDto(
      id: dtoClock.id,
      enabled: dtoClock.enabled,
      period: dtoClock.period,
      type: ReminderType.build(dtoClock.type.value),
    );
  }

  static List<clock.ReminderDto>? fromCollectorDtoToClockList(
    List<ReminderDto>? dtoList,
  ) {
    if (dtoList == null) {
      return null;
    }
    List<clock.ReminderDto> remindersList = [];
    for (var reminder in dtoList) {
      var reminderClock = fromCollectorDtoToClock(reminder);
      if (reminderClock != null) {
        remindersList.add(reminderClock);
      }
    }
    return remindersList;
  }

  static clock.ReminderDto? fromCollectorDtoToClock(ReminderDto? dto) {
    if (dto == null) {
      return null;
    }
    return clock.ReminderDto(
      id: dto.id,
      enabled: dto.enabled,
      period: dto.period,
      type: clock.ReminderType.build(dto.type.value),
    );
  }

  static List<Reminder>? fromDtoToEntityCollectorList(
    List<ReminderDto>? dtoList,
  ) {
    if (dtoList == null) {
      return null;
    }
    List<Reminder> remindersList = [];
    for (var reminder in dtoList) {
      var reminderCollector = fromDtoToEntityCollector(reminder);
      if (reminderCollector != null) {
        remindersList.add(reminderCollector);
      }
    }
    return remindersList;
  }

  static Reminder? fromDtoToEntityCollector(ReminderDto? dto) {
    if (dto == null) {
      return null;
    }
    return Reminder(
      id: dto.id,
      enabled: dto.enabled,
      period: dto.period,
      type: dto.type,
    );
  }

  static List<ReminderDto>? fromEntityToDtoCollectorList(
    List<Reminder>? entityList,
  ) {
    if (entityList == null) {
      return null;
    }
    List<ReminderDto> remindersList = [];
    for (var reminder in entityList) {
      var reminderCollector = fromEntityToDtoCollector(reminder);
      if (reminderCollector != null) {
        remindersList.add(reminderCollector);
      }
    }
    return remindersList;
  }

  static ReminderDto? fromEntityToDtoCollector(Reminder? entity) {
    if (entity == null) {
      return null;
    }
    return ReminderDto(
      id: entity.id ?? '',
      enabled: entity.enabled,
      period: entity.period,
      type: entity.type,
    );
  }

  static List<ReminderDto>? fromAuthToCollectorDtoList(
    List<auth.ReminderDTO>? authList,
  ) {
    if (authList == null) {
      return null;
    }
    List<ReminderDto> remindersList = [];
    for (var reminder in authList) {
      var reminderCollector = fromAuthToCollectorDto(reminder);
      if (reminderCollector != null) {
        remindersList.add(reminderCollector);
      }
    }
    return remindersList;
  }

  static ReminderDto? fromAuthToCollectorDto(
    auth.ReminderDTO? dtoAuth,
  ) {
    if (dtoAuth == null) {
      return null;
    }

    try {
      DateFormat format = DateFormat('HH:mm:ss');
      DateTime dateTime = format.parse(dtoAuth.period);

      return ReminderDto(
        id: dtoAuth.id,
        enabled: dtoAuth.enabled,
        period: dateTime,
        type: ReminderType.build(dtoAuth.type.value),
      );
    } catch (e) {
      print('Error parsing time: $e');
    }

    return null;
  }

  static List<ReminderDto>? fromJsonToCollectorDtoList(
    List<dynamic>? jsonList,
    dynamic employeeId,
  ) {
    if (jsonList == null) {
      return null;
    }
    List<ReminderDto> remindersList = [];
    for (var reminder in jsonList) {
      var reminderCollector = fromJsonToCollectorDto(reminder, employeeId);
      if (reminderCollector != null) {
        remindersList.add(reminderCollector);
      }
    }
    return remindersList;
  }

  static ReminderDto? fromJsonToCollectorDto(
    Map<String, dynamic>? json,
    dynamic employeeId,
  ) {
    if (json == null) return null;

    try {
      return ReminderDto(
        id: employeeId,
        enabled: json['enabled'] as bool,
        period: parsePeriod(json['period'] as String),
        type: ReminderType.build(json['type'] as String),
      );
    } catch (e) {
      return null;
    }
  }

  static DateTime parsePeriod(String period) {
    return DateFormat('HH:mm:ss').parse(period);
  }
}
