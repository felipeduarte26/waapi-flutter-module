import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/reminder_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/reminder_dto.dart';

void main() {
  group('ReminderDto', () {
    test('fromJson should parse JSON correctly', () {
      final json = {
        'id': '123',
        'period': '2023-10-01T12:00:00.000Z',
        'enabled': true,
        'type': 'INTERJOURNEY',
      };

      final reminder = ReminderDto.fromJson(json);

      expect(reminder.id, '123');
      expect(reminder.period, DateTime.parse('2023-10-01T12:00:00.000Z'));
      expect(reminder.enabled, true);
      expect(reminder.type, ReminderType.interjourney);
    });

    test('toJson should convert object to JSON correctly', () {
      final reminder = ReminderDto(
        id: '123',
        period: DateTime.parse('2023-10-01T12:00:00.000Z'),
        enabled: true,
        type: ReminderType.interjourney,
      );

      final json = reminder.toJson();

      expect(json['id'], '123');
      expect(json['period'], '2023-10-01T12:00:00.000Z');
      expect(json['enabled'], true);
      expect(json['type'], 'INTERJOURNEY');
    });
  });
}
