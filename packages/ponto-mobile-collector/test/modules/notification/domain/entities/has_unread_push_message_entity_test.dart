import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/has_unread_push_message_entity.dart';
import 'package:test/test.dart';

void main() {
  group('HasUnreadPushMessageEntity', () {
    test('fromJson should return a valid instance', () {
      // Arrange
      final json = {
        'number': 5,
        'hasUnreadPushMessage': true,
      };

      // Act
      final entity = HasUnreadPushMessageEntity.fromJson(json);

      // Assert
      expect(entity.number, 5);
      expect(entity.hasUnreadPushMessage, true);
    });

    test('toJson should return a valid map', () {
      // Arrange
      final entity = HasUnreadPushMessageEntity(
        number: 5,
        hasUnreadPushMessage: true,
      );

      // Act
      final json = entity.toJson();

      // Assert
      expect(json, {
        'number': 5,
        'hasUnreadPushMessage': true,
      });
    });
  });
}