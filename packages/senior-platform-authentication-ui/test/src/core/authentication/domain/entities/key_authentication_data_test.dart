import 'package:flutter_test/flutter_test.dart';
import 'package:senior_platform_authentication_ui/src/core/authentication/domain/entities/key_authentication_data.dart';

import '../../../../../mocks/key_authentication_data_mock.dart';
import '../../../../../mocks/login_with_key_mock.dart';
import '../../../../../mocks/token_mock.dart';

void main() {
  group('copywith', () {
    test(
        'copywith without any arguments should not modify any propertie of entity',
        () {
      final keyAuthenticationData = keyAuthenticationDataMock.copyWith();
      expect(keyAuthenticationData, keyAuthenticationDataMock);
    });

    test('copywith should work for all properties of entity', () {
      final keyAuthenticationData = const KeyAuthenticationData(
        loginWithKey: null,
        token: null,
      ).copyWith(
        loginWithKey: loginWithKeyMock,
        token: tokenMock,
      );
      expect(keyAuthenticationData.loginWithKey, loginWithKeyMock);
      expect(keyAuthenticationData.token, tokenMock);
    });
  });
}
