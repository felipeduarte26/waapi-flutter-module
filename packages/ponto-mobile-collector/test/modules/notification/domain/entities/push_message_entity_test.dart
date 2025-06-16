import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/push_message_entity.dart';
import 'package:test/test.dart';

void main() {
  group('PushMessageEntity', () {
    test('fromJson should return a valid instance', () {
      // Arrange
      final json = {
        'id': '123',
        'title': 'Test Title',
        'messageContent': 'Test Content',
        'createdAt': '2023-10-05T14:48:00.000Z',
        'read': true,
      };

      // Act
      final entity = PushMessageEntity.fromJson(json);

      // Assert
      expect(entity.id, '123');
      expect(entity.title, 'Test Title');
      expect(entity.messageContent, 'Test Content');
      expect(entity.createdAt, DateTime.parse('2023-10-05T14:48:00.000Z'));
      expect(entity.read, true);
    });

    test('toJson should return a valid map', () {
      // Arrange
      final entity = PushMessageEntity(
        id: '123',
        title: 'Test Title',
        messageContent: 'Test Content',
        createdAt: DateTime.parse('2023-10-05T14:48:00.000Z'),
        read: true,
      );

      // Act
      final json = entity.toJson();

      // Assert
      expect(json, {
        'id': '123',
        'title': 'Test Title',
        'messageContent': 'Test Content',
        'createdAt': '2023-10-05T14:48:00.000Z',
        'read': true,
      });
    });
  });
}
