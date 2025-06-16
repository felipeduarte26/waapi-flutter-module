// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter_test/flutter_test.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../mocks/mfa_info_mock.dart';
import '../../../../../mocks/token_mock.dart';

void main() {
  const tAccessKey = 'tAccessKey';

  group('AuthenticationEventTest', () {
    test(
        'Should event be AuthenticationEventTest when '
        'call AuthenticationStatusChanged constructor', () {
      //Arrange
      final tResponse = AuthenticationResponse(
          token: tokenMock, mfaInfo: mfaInfoUnconfiguredMock);
      final status = AuthenticationStatus.authenticated;
      final isBiometricEnabled = BiometryStatus.success;
      //Act
      var tAuthenticationStatusChanged = AuthenticationStatusChanged(
        authenticationResponse: tResponse,
        status,
        biometryStatus: isBiometricEnabled,
      );

      //Assert
      expect(
        tAuthenticationStatusChanged,
        isA<AuthenticationEvent>(),
      );

      expect(
        tAuthenticationStatusChanged,
        AuthenticationStatusChanged(
            authenticationResponse: tResponse,
            status,
            biometryStatus: isBiometricEnabled),
      );
    });

    test(
        'Should event be AuthenticationEventTest when '
        'call AuthenticationStatusChanged constructor Without isBiometricEnabled and with your return false',
        () {
      //Arrange
      final tResponse = AuthenticationResponse(
          token: tokenMock, mfaInfo: mfaInfoUnconfiguredMock);
      final status = AuthenticationStatus.authenticated;
      //Act
      var tAuthenticationStatusChanged = AuthenticationStatusChanged(
        authenticationResponse: tResponse,
        status,
      );

      //Assert
      expect(
        tAuthenticationStatusChanged,
        isA<AuthenticationEvent>(),
      );

      expect(
        tAuthenticationStatusChanged,
        AuthenticationStatusChanged(
          authenticationResponse: tResponse,
          status,
          biometryStatus: BiometryStatus.unknown,
        ),
      );
    });

    test(
        'Should event be AuthenticationEventTest when '
        'call LogoutOnlineRequested constructor', () {
      //Act
      var tLogoutOnlineRequested = LogoutOnlineRequested();

      //Assert
      expect(
        tLogoutOnlineRequested,
        isA<AuthenticationEvent>(),
      );

      expect(tLogoutOnlineRequested.props.isEmpty, true);

      expect(
        tLogoutOnlineRequested,
        LogoutOnlineRequested(),
      );
    });

    test(
        'Should event be AuthenticationEventTest when '
        'call CheckAuthenticationRequested constructor', () {
      //Arrange
      final tUsername = 'teste@senior.com.br';

      //Act
      var tLogoutOnlineRequested = CheckAuthenticationRequested(
        username: tUsername,
        accesskey: tAccessKey,
      );

      //Assert
      expect(
        tLogoutOnlineRequested,
        isA<AuthenticationEvent>(),
      );

      expect(tLogoutOnlineRequested.props[0], tUsername);
      expect(tLogoutOnlineRequested.props[1], tAccessKey);

      expect(
        tLogoutOnlineRequested,
        CheckAuthenticationRequested(
          username: tUsername,
          accesskey: tAccessKey,
        ),
      );
    });

    test(
        'Should event be AuthenticationEventTest when '
        'call LogoutOfflineRequested constructor', () {
      //Arrange
      final tUsername = 'teste@senior.com.br';

      //Act
      var tLogoutOfflineRequested = LogoutOfflineRequested(
        username: tUsername,
        eraseKeyToken: true,
        eraseUserToken: false,
      );

      //Assert
      expect(
        tLogoutOfflineRequested,
        isA<AuthenticationEvent>(),
      );

      expect(tLogoutOfflineRequested.props[0], tUsername);
      expect(tLogoutOfflineRequested.props[1], false);
      expect(tLogoutOfflineRequested.props[2], true);

      expect(
        tLogoutOfflineRequested,
        LogoutOfflineRequested(
          username: tUsername,
          eraseKeyToken: true,
          eraseUserToken: false,
        ),
      );
    });

    test(
        'Should event be AuthenticationEventTest when '
        'call LogoutOfflineRequested constructor', () {
      //Arrange

      //Act
      var tCheckBiometricAuthenticationRequested =
          CheckBiometricAuthenticationRequested();

      //Assert
      expect(
        tCheckBiometricAuthenticationRequested,
        isA<AuthenticationEvent>(),
      );

      expect(
        tCheckBiometricAuthenticationRequested,
        CheckBiometricAuthenticationRequested(),
      );
    });

    test(
        'Should event be AuthenticationEventTest when '
        'call LogoutOfflineRequested constructor', () {
      //Act
      var tCheckBiometricAuthenticationRequested =
          AuthenticationBiometricAuthRequested(
        biometricEnabled: true,
        status: AuthenticationStatus.authenticated,
      );

      //Assert
      expect(
        tCheckBiometricAuthenticationRequested,
        isA<AuthenticationEvent>(),
      );

      expect(
        tCheckBiometricAuthenticationRequested,
        AuthenticationBiometricAuthRequested(
          biometricEnabled: true,
          status: AuthenticationStatus.authenticated,
        ),
      );
    });

    test(
        'Should event be AuthenticationEventTest when '
        'call AuthenticateKey constructor', () {
      //Arrange
      final tResponse = AuthenticationResponse(
        token: tokenMock,
        mfaInfo: mfaInfoUnconfiguredMock,
      );

      //Act
      var tAuthenticateKey = AuthenticateKey(
        authenticationResponse: tResponse,
      );

      //Assert
      expect(
        tAuthenticateKey,
        isA<AuthenticationEvent>(),
      );

      expect(tAuthenticateKey.props[0], tResponse);
      expect(
        tAuthenticateKey,
        AuthenticateKey(
          authenticationResponse: tResponse,
        ),
      );
    });

    test(
        'Should event be AuthenticationEventTest when '
        'call ChangeAccessTokenAuthenticationRequested constructor', () {
      //Arrange
      //Act
      var tChangeAccessTokenAuthenticationRequested =
          const ChangeAccessTokenAuthenticationRequested(
        token: tokenMock,
      );

      //Assert
      expect(
        tChangeAccessTokenAuthenticationRequested,
        isA<AuthenticationEvent>(),
      );

      expect(tChangeAccessTokenAuthenticationRequested.props[0], tokenMock);
      expect(
        tChangeAccessTokenAuthenticationRequested,
        ChangeAccessTokenAuthenticationRequested(
          token: tokenMock,
        ),
      );
    });
  });
}
