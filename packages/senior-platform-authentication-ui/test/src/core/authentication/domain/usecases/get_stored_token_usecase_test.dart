import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../mocks/token_mock.dart';

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

class MockClearStoredDataUsecase extends Mock
    implements ClearStoredDataUsecase {}

void main() {
  late final GetStoredTokenUsecase getStoredTokenUsecase;
  late final SecureStorageRepository repository;
  late final ClearStoredDataUsecase clearStoredDataUsecase;
  const tCurrentUsername = 'teste@senior.com.br';
  const tUsername = UserName(currentUsername: tCurrentUsername);
  const tUsernameNull = UserName(currentUsername: null);

  setUpAll(() {
    repository = MockSecureStorageRepository();
    clearStoredDataUsecase = MockClearStoredDataUsecase();
    getStoredTokenUsecase = GetStoredTokenUsecase(
      secureStorageRepository: repository,
      clearStoredDataUsecase: clearStoredDataUsecase,
    );

    registerFallbackValue(tUsername);
    registerFallbackValue(tUsernameNull);
  });

  group('getStoredTokenUsecase', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => repository.readToken(username: tCurrentUsername),
      ).thenAnswer((_) async {
        return tokenMock;
      });

      verifyNever(
        () => repository.readToken(username: tCurrentUsername),
      );

      // Act
      final result = await getStoredTokenUsecase(tUsername);

      // Assert
      expect(result.token, isA<Token?>());

      verify(
        () => repository.readToken(username: tCurrentUsername),
      ).called(1);
    });

    test('should execute successfully with last user', () async {
      // Arrange
      when(
        () => repository.readToken(username: ''),
      ).thenAnswer((_) async {
        return tokenMock;
      });

      when(
        () => repository.readLastUser(),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => repository.readToken(username: ''),
      );

      verifyNever(
        () => repository.readLastUser(),
      );

      // Act
      final result = await getStoredTokenUsecase(const UserName());

      // Assert
      expect(result.token, isA<Token?>());

      verify(
        () => repository.readToken(username: ''),
      ).called(1);

      verify(
        () => repository.readLastUser(),
      ).called(1);
    });

    test('should return null and clear storage if GetStoredTokenUsecase fails',
        () async {
      // Arrange
      when(
        () => repository.readToken(username: tCurrentUsername),
      ).thenThrow(Exception());

      when(
        () => repository.readLastUser(),
      ).thenAnswer(
        (_) async => tCurrentUsername,
      );

      when(
        () => clearStoredDataUsecase.call(tUsername),
      ).thenAnswer((_) => Future.value());

      // Act
      final result = await getStoredTokenUsecase(tUsername);

      // Assert
      verify(
        () => repository.readToken(username: tCurrentUsername),
      ).called(1);

      verifyNever(
        () => repository.readLastUser(),
      );

      verify(
        () => clearStoredDataUsecase.call(tUsername),
      ).called(1);

      expect(result.token, null);
    });

    test(
        'should return null and clear storage if GetStoredTokenUsecase fails without username',
        () async {
      // Arrange
      when(
        () => repository.readToken(username: ''),
      ).thenThrow(Exception());

      when(
        () => repository.readLastUser(),
      ).thenAnswer(
        (_) async => '',
      );

      when(
        () => clearStoredDataUsecase.call(tUsernameNull),
      ).thenAnswer((_) => Future.value());

      // Act
      final result = await getStoredTokenUsecase(tUsernameNull);

      // Assert
      verify(
        () => repository.readToken(username: ''),
      ).called(1);

      verify(
        () => repository.readLastUser(),
      ).called(1);

      verify(
        () => clearStoredDataUsecase.call(tUsernameNull),
      ).called(1);

      expect(result.token, null);
    });

    test('should return null if clear storage fails', () async {
      // Arrange
      when(
        () => repository.readToken(username: tCurrentUsername),
      ).thenThrow(Exception());

      when(
        () => repository.readLastUser(),
      ).thenAnswer(
        (_) async => tCurrentUsername,
      );

      when(
        () => clearStoredDataUsecase.call(tUsername),
      ).thenThrow(
        (_) async => Exception(),
      );

      // Act
      final result = await getStoredTokenUsecase(tUsername);

      // Assert
      verify(
        () => repository.readToken(username: tCurrentUsername),
      ).called(1);

      verifyNever(
        () => repository.readLastUser(),
      );

      verify(
        () => clearStoredDataUsecase.call(tUsername),
      ).called(1);

      expect(result.token, null);
    });
  });
}
