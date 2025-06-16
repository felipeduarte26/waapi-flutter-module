import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/has_unread_push_message_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/infra/adapters/get_number_unread_notifications_adapter.dart';
import 'package:test/test.dart';

void main() {
  group('GetNumberUnreadNotificationsAdapter', () {
    test('toMap should return a valid map', () {
      // Arrange
      const jsonString = '{"hasUnreadPushMessage": true, "number": 5}';

      // Act
      final map = GetNumberUnreadNotificationsAdapter.toMap(jsonString);

      // Assert
      expect(map, isA<Map<String, dynamic>>());
      expect(map['hasUnreadPushMessage'], true);
      expect(map['number'], 5);
    });

    test('fromJSON should return a valid HasUnreadPushMessageEntity', () {
      // Arrange
      const jsonString = '{"hasUnreadPushMessage": true, "number": 5}';

      // Act
      final entity = GetNumberUnreadNotificationsAdapter.fromJSON(jsonString);

      // Assert
      expect(entity, isA<HasUnreadPushMessageEntity>());
      expect(entity.hasUnreadPushMessage, true);
      expect(entity.number, 5);
    });

    test('fromJSON should handle invalid JSON gracefully', () {
      // Arrange
      const invalidJsonString = 'invalid json';

      // Act
      final entity =
          GetNumberUnreadNotificationsAdapter.fromJSON(invalidJsonString);

      // Assert
      expect(entity, isA<HasUnreadPushMessageEntity>());
      expect(entity.hasUnreadPushMessage, false);
      expect(entity.number, 0);
    });
  });
}
