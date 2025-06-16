import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/reminder.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/reminder_type.dart';

void main() {
  group('Reminder', () {
    test('should correctly initialize properties', () {
      final reminder = Reminder(
        id: '1',
        period: DateTime(2023, 10, 1),
        enabled: true,
        type: ReminderType.interjourney,
      );

      expect(reminder.id, '1');
      expect(reminder.period, DateTime(2023, 10, 1));
      expect(reminder.enabled, true);
      expect(reminder.type, ReminderType.interjourney);
    });

    test('should support value equality', () {
      final reminder1 = Reminder(
        id: '1',
        period: DateTime(2023, 10, 1),
        enabled: true,
        type: ReminderType.interjourney,
      );

      final reminder2 = Reminder(
        id: '1',
        period: DateTime(2023, 10, 1),
        enabled: true,
        type: ReminderType.interjourney,
      );

      expect(reminder1, equals(reminder2));
    });

    test('should correctly handle null id', () {
      final reminder = Reminder(
        id: null,
        period: DateTime(2023, 10, 1),
        enabled: false,
        type: ReminderType.interjourney,
      );

      expect(reminder.id, isNull);
      expect(reminder.period, DateTime(2023, 10, 1));
      expect(reminder.enabled, false);
      expect(reminder.type, ReminderType.interjourney);
    });
  });
}
