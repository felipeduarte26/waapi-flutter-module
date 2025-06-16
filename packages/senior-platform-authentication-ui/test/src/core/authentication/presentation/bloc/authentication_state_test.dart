// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../mocks/token_mock.dart';

void main() {
  const tUsername = 'teste@senior.com.br';

  group('AuthenticationStateTest', () {
    test(
        'Should return AuthenticationState when '
        'call AuthenticationState.unknown constructor', () {
      // Arrange
      final tUnknownState = AuthenticationState.unknown();

      // Asserts
      expect(tUnknownState, isA<AuthenticationState>());
    });

    test(
        'Should return AuthenticationState when '
        'call AuthenticationState.authenticated constructor', () {
      // Arrange
      final tAuthenticatedState = AuthenticationState.authenticated(
        biometryStatus: BiometryStatus.success,
        keyToken: keyTokenMock,
        token: tokenMock,
        username: tUsername,
      );

      // Asserts
      expect(tAuthenticatedState, isA<AuthenticationState>());
      expect(tAuthenticatedState.username, tUsername);
    });

    test(
        'Should return AuthenticationState when '
        'call AuthenticationState.unauthenticated constructor', () {
      // Arrange
      final tUnknownState = AuthenticationState.unauthenticated();

      // Asserts
      expect(tUnknownState, isA<AuthenticationState>());
    });

    test(
        'Should return AuthenticationState when '
        'call AuthenticationState.offline constructor', () {
      // Arrange
      final tUnknownState = AuthenticationState.offline(tUsername);

      // Asserts
      expect(tUnknownState, isA<AuthenticationState>());
    });
  });
}
