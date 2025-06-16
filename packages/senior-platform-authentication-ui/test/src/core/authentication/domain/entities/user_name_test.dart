import 'package:flutter_test/flutter_test.dart';

import '../../../../../mocks/user_name_mock.dart';

void main() {
  group('copywith', () {
    test('copywith without any arguments should reset currentUsername to null',
        () {
      final newUserName = userNameMock.copyWith();
      expect(newUserName.currentUsername, null);
    });

    test('copywith should work for all properties of entity', () {
      final userNameModified = userNameMock.copyWith(
        currentUsername: 'currentUsername modified',
      );

      expect(userNameModified.currentUsername, 'currentUsername modified');
    });
  });
}
