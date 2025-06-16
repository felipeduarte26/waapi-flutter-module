import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/push_notification_dto.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/infra/adapters/push_notification_adapter.dart';

void main() {
  group('PushNotificationAdapter', () {
    test('toMap should convert JSON string to Map', () {
      const jsonString = '{"key": "value"}';
      final result = PushNotificationAdapter.toMap(jsonString);
      expect(result, isA<Map<String, dynamic>>());
      expect(result['key'], 'value');
    });

    test('fromJSON should convert JSON string to PushNotificationDto', () {
      const jsonString = '''
      {
        "messages": {
          "messages": [
            {
              "id": "1",
              "title": "Test Title",
              "messageContent": "Test Content",
              "createdAt": "2023-03-28T16:02:00Z",
              "read": false
            }
          ]
        }
      }
      ''';
      final result = PushNotificationAdapter.fromJSON(jsonString);
      expect(result, isA<PushNotificationDto>());
      expect(result.messages.length, 1);
      expect(result.messages[0].id, '1');
      expect(result.messages[0].title, 'Test Title');
      expect(result.messages[0].messageContent, 'Test Content');
      expect(
        result.messages[0].createdAt,
        DateTime.parse('2023-03-28T16:02:00Z'),
      );
      expect(result.messages[0].read, false);
    });

    test('fromJSON should handle invalid JSON string gracefully', () {
      const invalidJsonString = 'invalid json';
      final result = PushNotificationAdapter.fromJSON(invalidJsonString);
      expect(result, isA<PushNotificationDto>());
      expect(result.messages, isEmpty);
    });
  });
}
