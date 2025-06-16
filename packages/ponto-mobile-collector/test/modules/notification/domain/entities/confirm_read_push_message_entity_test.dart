import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/confirm_read_push_message_entity.dart';
import 'package:test/test.dart';

void main() {
  group('ConfirmReadPushMessageEntity', () {
    test('fromJson should return a valid instance', () {
      // Arrange
      final json = {'confirmed': true};

      // Act
      final entity = ConfirmReadPushMessageEntity.fromJson(json);

      // Assert
      expect(entity.confirmed, true);
    });

    test('toJson should return a valid map', () {
      // Arrange
      final entity = ConfirmReadPushMessageEntity(confirmed: true);

      // Act
      final json = entity.toJson();

      // Assert
      expect(json, {'confirmed': true});
    });
  });
}