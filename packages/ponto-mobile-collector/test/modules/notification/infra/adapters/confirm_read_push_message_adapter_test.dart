import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/confirm_read_push_message_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/infra/adapters/confirm_read_push_message_adapter.dart';
import 'package:test/test.dart';

void main() {
  group('ConfirmReadPushMessageAdapter', () {
    test('toMap should return a valid map', () {
      // Arrange
      const jsonString = '{"confirmed": true}';

      // Act
      final map = ConfirmReadPushMessageAdapter.toMap(jsonString);

      // Assert
      expect(map, isA<Map<String, dynamic>>());
      expect(map['confirmed'], true);
    });

    test('fromJSON should return a valid ConfirmReadPushMessageEntity', () {
      // Arrange
      const jsonString = '{"confirmed": true}';

      // Act
      final entity = ConfirmReadPushMessageAdapter.fromJSON(jsonString);

      // Assert
      expect(entity, isA<ConfirmReadPushMessageEntity>());
      expect(entity.confirmed, true);
    });

    test('fromJSON should handle invalid JSON gracefully', () {
      // Arrange
      const invalidJsonString = 'invalid json';

      // Act
      final entity = ConfirmReadPushMessageAdapter.fromJSON(invalidJsonString);

      // Assert
      expect(entity, isA<ConfirmReadPushMessageEntity>());
      expect(entity.confirmed, false);
    });
  });
}
