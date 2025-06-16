import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/platform_user.dart';

void main() {
  group('PlatformUser', () {
    test('should correctly compare two PlatformUser instances with the same properties', () {
      const user1 = PlatformUser(
        id: '123',
        mail: 'test@example.com',
        platformUserName: 'testUser',
      );

      const user2 = PlatformUser(
        id: '123',
        mail: 'test@example.com',
        platformUserName: 'testUser',
      );

      expect(user1, equals(user2));
    });

    test('should correctly identify two PlatformUser instances with different properties as not equal', () {
      const user1 = PlatformUser(
        id: '123',
        mail: 'test@example.com',
        platformUserName: 'testUser',
      );

      const user2 = PlatformUser(
        id: '456',
        mail: 'other@example.com',
        platformUserName: 'otherUser',
      );

      expect(user1, isNot(equals(user2)));
    });

    test('props should return the correct list of properties', () {
      const user = PlatformUser(
        id: '123',
        mail: 'test@example.com',
        platformUserName: 'testUser',
      );

      expect(user.props, ['123', 'test@example.com', 'testUser']);
    });
  });
}