import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../mocks/authentication_data_mock.dart';
import '../../../../../mocks/token_mock.dart';
import '../../../../../mocks/user_mock.dart';

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

void main() {
  late final StoreAuthenticationDataUsecase storeAuthenticationDataUsecase;
  late final SecureStorageRepository repository;

  setUpAll(() {
    repository = MockSecureStorageRepository();
    storeAuthenticationDataUsecase =
        StoreAuthenticationDataUsecase(secureStorageRepository: repository);

    registerFallbackValue(tokenMock);
    registerFallbackValue(userMock);
  });

  group('storeAuthenticationDataUsecase', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => repository.writeToken(any()),
      ).thenAnswer((_) async {
        return;
      });

      when(
        () => repository.writeUser(any()),
      ).thenAnswer((_) async {
        return;
      });

      when(
        () => repository.writeTokenExpirationDate(any(), any(), any()),
      ).thenAnswer((_) async {
        return;
      });

      when(
        () =>
            repository.writeLastUser(userMock.username, userMock.tenantDomain),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => repository.writeToken(any()),
      );

      verifyNever(
        () => repository.writeUser(any()),
      );

      verifyNever(
        () => repository.writeTokenExpirationDate(any(), any(), any()),
      );

      verifyNever(
        () =>
            repository.writeLastUser(userMock.username, userMock.tenantDomain),
      );

      // Act
      final result =
          await storeAuthenticationDataUsecase(authenticationDataMock);

      // Assert
      expect(result, true);

      verify(
        () => repository.writeToken(any()),
      ).called(1);

      verify(
        () => repository.writeUser(any()),
      ).called(1);

      verify(
        () => repository.writeTokenExpirationDate(any(), any(), any()),
      ).called(1);

      verify(
        () =>
            repository.writeLastUser(userMock.username, userMock.tenantDomain),
      ).called(1);
    });

    test('should catch exception when repository throws', () async {
      // Arrange
      when(
        () => repository.writeToken(any()),
      ).thenThrow(Exception('oops'));

      when(
        () => repository.writeUser(any()),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => repository.writeToken(any()),
      );

      verifyNever(
        () => repository.writeUser(any()),
      );

      // Act
      final result =
          await storeAuthenticationDataUsecase(authenticationDataMock);

      // Assert
      expect(result, false);

      // Assert
      verify(
        () => repository.writeUser(any()),
      ).called(1);

      verifyNever(
        () => repository.writeToken(any()),
      );
    });

    test('should verify if user is valid', () async {
      // Arrange
      when(
        () => repository.writeToken(any()),
      ).thenAnswer((_) async {
        return;
      });

      when(
        () => repository.writeUser(any()),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => repository.writeToken(any()),
      );

      verifyNever(
        () => repository.writeUser(any()),
      );

      // Act
      final result = await storeAuthenticationDataUsecase(
        const AuthenticationData(
          user: null,
          token: tokenMock,
        ),
      );

      // Assert
      expect(result, false);

      verifyNever(
        () => repository.writeToken(any()),
      );

      verifyNever(
        () => repository.writeUser(any()),
      );
    });

    test('should verify if token is valid', () async {
      // Arrange
      when(
        () => repository.writeToken(any()),
      ).thenAnswer((_) async {
        return;
      });

      when(
        () => repository.writeUser(any()),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => repository.writeToken(any()),
      );

      verifyNever(
        () => repository.writeUser(any()),
      );

      // Act
      final result = await storeAuthenticationDataUsecase(
        const AuthenticationData(
          user: userMock,
          token: null,
        ),
      );

      // Assert
      expect(result, false);

      verifyNever(
        () => repository.writeToken(any()),
      );

      verifyNever(
        () => repository.writeUser(any()),
      );
    });
  });
}
