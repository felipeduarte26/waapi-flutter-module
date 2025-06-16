import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/platform_user_dto.dart';

void main() {
  group('PlatformUserDto', () {
    test('should serialize from JSON correctly', () {
      final json = {
        'id': '123',
        'username': 'test_user',
      };

      final dto = PlatformUserDto.fromJson(json);

      expect(dto.id, '123');
      expect(dto.username, 'test_user');
    });

    test('should serialize to JSON correctly', () {
      final dto = PlatformUserDto(
        id: '123',
        username: 'test_user',
      );

      final json = dto.toJson();

      expect(json['id'], '123');
      expect(json['username'], 'test_user');
    });

    test('should handle null id correctly', () {
      final json = {
        'id': null,
        'username': 'test_user',
      };

      final dto = PlatformUserDto.fromJson(json);

      expect(dto.id, isNull);
      expect(dto.username, 'test_user');
    });
  });
}