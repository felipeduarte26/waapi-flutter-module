import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../../mocks/key_authentication_data_mock.dart';
import '../../../../../../mocks/login_with_key_mock.dart';
import '../../../../../../mocks/token_mock.dart';

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

void main() {
  late StoreKeyAuthenticationDataUsecase
      storeKeyAuthenticationDataUsecase;
  late SecureStorageRepository repository;

  setUp(() {
    repository = MockSecureStorageRepository();
    storeKeyAuthenticationDataUsecase = StoreKeyAuthenticationDataUsecase(
      secureStorageRepository: repository,
    );

    registerFallbackValue(loginWithKeyMock);
    registerFallbackValue(tokenMock);
  });

  group('storeKeyAuthenticationDataUsecase', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => repository.writeKey(loginWithKey: any(named: 'loginWithKey')),
      ).thenAnswer((_) async {
        return;
      });

      when(() => repository.writeKeyToken(
            accessKey: any(named: 'accessKey'),
            token: any(named: 'token'),
          )).thenAnswer((_) async {
        return;
      });

      when(() => repository.writeKeyTokenExpirationDate(
            accessKey: any(named: 'accessKey'),
            tokenExpirationDate: any(named: 'tokenExpirationDate'),
          )).thenAnswer((_) async {
        return;
      });

      when(
        () => repository.writeLastKey(any()),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      final result = await storeKeyAuthenticationDataUsecase(
        keyAuthenticationDataMock,
      );

      // Assert
      expect(result, true);

      verify(() => repository.writeKey(
            loginWithKey: any(named: 'loginWithKey'),
          )).called(1);

      verify(() => repository.writeKeyToken(
            accessKey: any(named: 'accessKey'),
            token: any(named: 'token'),
          )).called(1);

      verify(() => repository.writeKeyTokenExpirationDate(
            accessKey: any(named: 'accessKey'),
            tokenExpirationDate: any(named: 'tokenExpirationDate'),
          )).called(1);

      verify(() => repository.writeLastKey(any())).called(1);

      verifyNoMoreInteractions(repository);
    });

    test('should catch exception when repository throws', () async {
      // Arrange
      when(
        () => repository.writeKey(loginWithKey: any(named: 'loginWithKey')),
      ).thenThrow(Exception('oops'));

      // Act
      final result = await storeKeyAuthenticationDataUsecase(
        keyAuthenticationDataMock,
      );

      // Assert
      expect(result, false);

      verify(() => repository.writeKey(
            loginWithKey: any(named: 'loginWithKey'),
          )).called(1);

      verifyNoMoreInteractions(repository);
    });
  });
}
