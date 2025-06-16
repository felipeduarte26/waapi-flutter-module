import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:intl/intl.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/reminder_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/reminder_dto.dart';

clock.ReminderDto reminderDto = clock.ReminderDto(
  id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  period: DateFormat('HH:mm:ss').parse('01:30:00'),
  enabled: true,
  type: clock.ReminderType.intrajourney,
);

auth.ReminderDTO reminderDTO = auth.ReminderDTO(
  id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  period: '01:30:00',
  enabled: true,
  type: auth.ReminderType.intrajourney,
);

ReminderDto reminderDtoMock = ReminderDto(
  id: '83e1a9c8-11ec-4f8b-8a92-3f22782b4f9f',
  period:  DateTime(2023, 4, 27, 01, 30, 00),
  enabled: true,
  type: ReminderType.intrajourney,
);
