import 'package:flutter_test/flutter_test.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../../../../mocks/authentication_data_mock.dart';
import '../../../../../mocks/integration_mock.dart';
import '../../../../../mocks/token_mock.dart';

void main() {
  group('copywith', () {
    test(
        'copywith without any arguments should not modify any propertie of entity',
        () {
      final newAuthenticationData = authenticationDataMock.copyWith();
      expect(newAuthenticationData, authenticationDataMock);
    });

    test('copywith should work for all properties of entity', () {
      final integrationModified = integrationMock.copyWith(
        integrationName: 'integrationName modified',
      );

      final userModified = User(
        changePassword: true,
        admin: false,
        allowedToChangePassword: false,
        id: 'id modified',
        username: 'username modified',
        fullName: 'fullName modified',
        email: 'email modified',
        tenantDomain: 'tenantDomain modified',
        tenantName: 'tenantName modified',
        tenantLocale: 'tenantLocale modified',
        blocked: true,
        locale: 'locale modified',
        photoUrl: 'photoUrl modified',
        authenticationType: 'authenticationType modified',
        description: 'description modified',
        integration: integrationModified,
        discriminator: 'discriminator modified',
      );

      final tokenModified = tokenMock.copyWith(
        version: 2,
        expiresIn: 9000,
        username: 'username modified',
        tokenType: 'token_type modified',
        accessToken: 'access_token modified',
        refreshToken: 'refresh_token modified',
        type: 'type modified',
        email: 'email modified',
        fullName: 'fullName modified',
        tenantName: 'tenantName modified',
        locale: 'locale modified',
      );

      final newAuthenticationData = authenticationDataMock.copyWith(
        user: userModified,
        token: tokenModified,
      );

      expect(newAuthenticationData.user?.changePassword, true);
      expect(newAuthenticationData.user?.admin, false);
      expect(newAuthenticationData.user?.allowedToChangePassword, false);
      expect(newAuthenticationData.user?.id, 'id modified');
      expect(newAuthenticationData.user?.username, 'username modified');
      expect(newAuthenticationData.user?.fullName, 'fullName modified');
      expect(newAuthenticationData.user?.email, 'email modified');
      expect(newAuthenticationData.user?.tenantDomain, 'tenantDomain modified');
      expect(newAuthenticationData.user?.tenantName, 'tenantName modified');
      expect(newAuthenticationData.user?.tenantLocale, 'tenantLocale modified');
      expect(newAuthenticationData.user?.blocked, true);
      expect(newAuthenticationData.user?.locale, 'locale modified');
      expect(newAuthenticationData.user?.photoUrl, 'photoUrl modified');
      expect(newAuthenticationData.user?.authenticationType,
          'authenticationType modified');
      expect(newAuthenticationData.user?.description, 'description modified');
      expect(newAuthenticationData.user?.integration, integrationModified);
      expect(
          newAuthenticationData.user?.discriminator, 'discriminator modified');

      expect(newAuthenticationData.token?.version, 2);
      expect(newAuthenticationData.token?.expiresIn, 9000);
      expect(newAuthenticationData.token?.username, 'username modified');
      expect(newAuthenticationData.token?.tokenType, 'token_type modified');
      expect(newAuthenticationData.token?.accessToken, 'access_token modified');
      expect(
          newAuthenticationData.token?.refreshToken, 'refresh_token modified');
      expect(newAuthenticationData.token?.type, 'type modified');
      expect(newAuthenticationData.token?.email, 'email modified');
      expect(newAuthenticationData.token?.fullName, 'fullName modified');
      expect(newAuthenticationData.token?.tenantName, 'tenantName modified');
      expect(newAuthenticationData.token?.locale, 'locale modified');
    });
  });
}
