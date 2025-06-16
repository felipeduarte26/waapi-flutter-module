import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/authentication/domain/entities/key_authentication_data.dart';

import '../../../../../../mocks/login_with_key_mock.dart';
import '../../../../../../mocks/tenant_login_settings_mock.dart';
import '../../../../../../mocks/token_mock.dart';

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

class MockLoginWithKeyUsecase extends Mock implements LoginWithKeyUsecase {}

class MockGetTenantLoginSettingsUsecase extends Mock
    implements GetTenantLoginSettingsUsecase {}

class MockStoreKeyAuthenticationDataUsecase extends Mock
    implements StoreKeyAuthenticationDataUsecase {}

void main() {
  late SecureStorageRepository repository;
  late LoginWithKeyUsecase loginWithKeyUsecase;
  late AuthenticateKeyUsecase authenticateKeyUsecase;
  late GetTenantLoginSettingsUsecase getTenantLoginSettingsUsecase;
  late StoreKeyAuthenticationDataUsecase storeKeyAuthenticationDataUsecase;
  const tAccessKey = 'accessKey';

  setUp(() {
    loginWithKeyUsecase = MockLoginWithKeyUsecase();
    repository = MockSecureStorageRepository();
    getTenantLoginSettingsUsecase = MockGetTenantLoginSettingsUsecase();
    storeKeyAuthenticationDataUsecase = MockStoreKeyAuthenticationDataUsecase();

    authenticateKeyUsecase = AuthenticateKeyUsecase(
      loginWithKeyUsecase: loginWithKeyUsecase,
      secureStorageRepository: repository,
      getTenantLoginSettingsUsecase: getTenantLoginSettingsUsecase,
      storeKeyAuthenticationDataUsecase: storeKeyAuthenticationDataUsecase,
    );
  });

  group('AuthenticateKeyUsecase', () {
    test('should execute successfully', () async {
      // Arrange
      registerFallbackValue(
          TenantLogin(tenantDomain: loginWithKeyMock.tenantName));

      registerFallbackValue(const KeyAuthenticationData(
          loginWithKey: loginWithKeyMock, token: tokenMock));

      when(
        () => repository.readKey(accessKey: tAccessKey),
      ).thenAnswer((_) async {
        return loginWithKeyMock;
      });

      when(
        () => repository.readLastKey(),
      ).thenAnswer((_) async {
        return tAccessKey;
      });

      when(
        () => loginWithKeyUsecase.call(loginWithKeyMock),
      ).thenAnswer((_) async {
        return authenticationResponseMock;
      });

      when(
        () => getTenantLoginSettingsUsecase.call(any()),
      ).thenAnswer((_) async {
        return tenantLoginSettingsMock;
      });

      when(
        () => storeKeyAuthenticationDataUsecase.call(any()),
      ).thenAnswer((_) async {
        return true;
      });

      // Act
      final result = await authenticateKeyUsecase.call();

      // Assert
      expect(result, authenticationResponseMock);

      verify(
        () => repository.readKey(accessKey: tAccessKey),
      ).called(1);

      verify(
        () => repository.readLastKey(),
      ).called(1);

      verify(
        () => loginWithKeyUsecase.call(loginWithKeyMock),
      ).called(1);

      verify(
        () => getTenantLoginSettingsUsecase.call(any()),
      ).called(1);

      verify(
        () => storeKeyAuthenticationDataUsecase.call(any()),
      ).called(1);

      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(loginWithKeyUsecase);
      verifyNoMoreInteractions(getTenantLoginSettingsUsecase);
      verifyNoMoreInteractions(storeKeyAuthenticationDataUsecase);
    });

    test('should return null when key is null', () async {
      // Arrange
      when(
        () => repository.readKey(accessKey: tAccessKey),
      ).thenAnswer((_) async {
        return null;
      });

      // Act
      final result = await authenticateKeyUsecase.call(tAccessKey);

      // Asser
      expect(result, null);
      verify(
        () => repository.readKey(accessKey: tAccessKey),
      ).called(1);

      verifyNoMoreInteractions(repository);
      verifyZeroInteractions(loginWithKeyUsecase);
    });

    test('should return null when no key is provided', () async {
      // Arrange
      when(
        () => repository.readLastKey(),
      ).thenAnswer((_) async {
        return null;
      });

      // Act
      final result = await authenticateKeyUsecase.call();

      // Asser
      expect(result, null);
      verify(
        () => repository.readLastKey(),
      ).called(1);

      verifyNoMoreInteractions(repository);
      verifyZeroInteractions(loginWithKeyUsecase);
    });
  });
}
