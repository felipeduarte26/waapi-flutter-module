import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/reminder.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/reminder_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/reminder_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/reminder_mapper.dart';

void main() {
  group('ReminderMapper', () {
    test('fromClockToCollectorDtoList should return null when input is null', () {
      final result = ReminderMapper.fromClockToCollectorDtoList(null);
      expect(result, isNull);
    });

    test('fromClockToCollectorDtoList should map clock.ReminderDto list to ReminderDto list', () {
      final clockList = [
        clock.ReminderDto(id: '1', enabled: true, period: DateTime.now(), type: clock.ReminderType.interjourney),
        clock.ReminderDto(id: '2', enabled: false, period: DateTime.now(), type: clock.ReminderType.interjourney),
      ];

      final result = ReminderMapper.fromClockToCollectorDtoList(clockList);

      expect(result, isNotNull);
      expect(result!.length, clockList.length);
      expect(result[0].id, clockList[0].id);
      expect(result[0].enabled, clockList[0].enabled);
    });

    test('fromCollectorDtoToClockList should return null when input is null', () {
      final result = ReminderMapper.fromCollectorDtoToClockList(null);
      expect(result, isNull);
    });

    test('fromCollectorDtoToClockList should map ReminderDto list to clock.ReminderDto list', () {
      final dtoList = [
        ReminderDto(id: '1', enabled: true, period: DateTime.now(), type: ReminderType.interjourney),
        ReminderDto(id: '2', enabled: false, period: DateTime.now(), type: ReminderType.interjourney),
      ];

      final result = ReminderMapper.fromCollectorDtoToClockList(dtoList);

      expect(result, isNotNull);
      expect(result!.length, dtoList.length);
      expect(result[0].id, dtoList[0].id);
      expect(result[0].enabled, dtoList[0].enabled);
    });

    test('fromDtoToEntityCollectorList should return null when input is null', () {
      final result = ReminderMapper.fromDtoToEntityCollectorList(null);
      expect(result, isNull);
    });

    test('fromDtoToEntityCollectorList should map ReminderDto list to Reminder entity list', () {
      final dtoList = [
        ReminderDto(id: '1', enabled: true, period: DateTime.now(), type: ReminderType.interjourney),
        ReminderDto(id: '2', enabled: false, period: DateTime.now(), type: ReminderType.interjourney),
      ];

      final result = ReminderMapper.fromDtoToEntityCollectorList(dtoList);

      expect(result, isNotNull);
      expect(result!.length, dtoList.length);
      expect(result[0].id, dtoList[0].id);
      expect(result[0].enabled, dtoList[0].enabled);
    });

    test('fromEntityToDtoCollectorList should return null when input is null', () {
      final result = ReminderMapper.fromEntityToDtoCollectorList(null);
      expect(result, isNull);
    });

    test('fromEntityToDtoCollectorList should map Reminder entity list to ReminderDto list', () {
      final entityList = [
        Reminder(id: '1', enabled: true, period: DateTime.now(), type: ReminderType.interjourney),
        Reminder(id: '2', enabled: false, period: DateTime.now(), type: ReminderType.interjourney),
      ];

      final result = ReminderMapper.fromEntityToDtoCollectorList(entityList);

      expect(result, isNotNull);
      expect(result!.length, entityList.length);
      expect(result[0].id, entityList[0].id);
      expect(result[0].enabled, entityList[0].enabled);
    });

    test('fromAuthToCollectorDtoList should return null when input is null', () {
      final result = ReminderMapper.fromAuthToCollectorDtoList(null);
      expect(result, isNull);
    });

    test('fromAuthToCollectorDtoList should map auth.ReminderDTO list to ReminderDto list', () {
      final authList = [
        auth.ReminderDTO(id: '1', enabled: true, period: DateTime.now().toIso8601String(), type: auth.ReminderType.interjourney),
        auth.ReminderDTO(id: '2', enabled: false, period: DateTime.now().toIso8601String(), type: auth.ReminderType.interjourney),
      ];

      final result = ReminderMapper.fromAuthToCollectorDtoList(authList);

      expect(result, isNotNull);
      expect(result!.length, authList.length);
      expect(result[0].id, authList[0].id);
      expect(result[0].enabled, authList[0].enabled);
    });
  });
}