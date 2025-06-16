import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../mocks/user_mock.dart';

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

class MockClearStoredDataUsecase extends Mock
    implements ClearStoredDataUsecase {}

void main() {
  late final GetStoredUserUsecase getStoredUserUsecase;
  late final SecureStorageRepository repository;
  late final ClearStoredDataUsecase clearStoredDataUsecase;
  const tCurrentUsername = 'teste@senior.com.br';
  const tUsername = UserName(currentUsername: tCurrentUsername);
  const tUsernameNull = UserName(currentUsername: null);

  setUpAll(() {
    repository = MockSecureStorageRepository();
    clearStoredDataUsecase = MockClearStoredDataUsecase();
    getStoredUserUsecase = GetStoredUserUsecase(
      secureStorageRepository: repository,
      clearStoredDataUsecase: clearStoredDataUsecase,
    );
  });

  group('getStoredUserUsecase', () {
    test(
        'should execute successfully when '
        'currentUsername is not empty', () async {
      // Arrange
      when(
        () => repository.readUser(username: tCurrentUsername),
      ).thenAnswer((_) async {
        return userMock;
      });

      when(
        () => repository.readLastUser(),
      ).thenAnswer((_) async {
        return tCurrentUsername;
      });

      verifyNever(
        () => repository.readToken(username: tCurrentUsername),
      );

      verifyNever(
        () => repository.readTokenExpirationDate(username: tCurrentUsername),
      );

      // Act
      final result = await getStoredUserUsecase(tUsername);

      // Assert
      expect(result, isA<User?>());

      verify(
        () => repository.readUser(username: tCurrentUsername),
      ).called(1);

      verifyNever(
        () => repository.readLastUser(),
      );
    });

    test(
        'should execute successfully when '
        'currentUsername is empty', () async {
      // Arrange
      when(
        () => repository.readUser(username: tCurrentUsername),
      ).thenAnswer((_) async {
        return userMock;
      });

      when(
        () => repository.readLastUser(),
      ).thenAnswer((_) async {
        return tCurrentUsername;
      });

      verifyNever(
        () => repository.readToken(username: tCurrentUsername),
      );

      verifyNever(
        () => repository.readTokenExpirationDate(username: tCurrentUsername),
      );

      // Act
      final result = await getStoredUserUsecase(const UserName());

      // Assert
      expect(result, isA<User?>());

      verify(
        () => repository.readUser(username: tCurrentUsername),
      ).called(1);

      verify(
        () => repository.readLastUser(),
      ).called(1);
    });

    test('should return null and clear storage if GetStoredUserUsecase fails',
        () async {
      // Arrange
      when(
        () => repository.readUser(username: tCurrentUsername),
      ).thenThrow(
        (_) async => Exception(),
      );

      when(
        () => repository.readLastUser(),
      ).thenAnswer(
        (_) async => tCurrentUsername,
      );

      when(
        () => clearStoredDataUsecase.call(tUsername),
      ).thenAnswer((_) => Future.value());

      // Act
      final result = await getStoredUserUsecase(tUsername);

      // Assert
      verify(
        () => repository.readUser(username: tCurrentUsername),
      ).called(1);

      verifyNever(
        () => repository.readLastUser(),
      );

      verify(
        () => clearStoredDataUsecase.call(tUsername),
      ).called(1);

      expect(result, null);
    });

    test(
        'should return null and clear storage if GetStoredUserUsecase fails without username',
        () async {
      // Arrange
      when(
        () => repository.readUser(username: ''),
      ).thenThrow(
        (_) async => Exception(),
      );

      when(
        () => repository.readLastUser(),
      ).thenAnswer(
        (_) async => '',
      );

      when(
        () => clearStoredDataUsecase.call(tUsernameNull),
      ).thenAnswer((_) => Future.value());

      // Act
      final result = await getStoredUserUsecase(tUsernameNull);

      // Assert
      verify(
        () => repository.readUser(username: ''),
      ).called(1);

      verify(
        () => repository.readLastUser(),
      ).called(1);

      verify(
        () => clearStoredDataUsecase.call(tUsernameNull),
      ).called(1);

      expect(result, null);
    });

    test('should return null if clear storage fails', () async {
      // Arrange
      when(
        () => repository.readUser(username: tCurrentUsername),
      ).thenThrow(
        (_) async => Exception(),
      );

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
      final result = await getStoredUserUsecase(tUsername);

      // Assert
      verify(
        () => repository.readUser(username: tCurrentUsername),
      ).called(1);

      verifyNever(
        () => repository.readLastUser(),
      );

      verify(
        () => clearStoredDataUsecase.call(tUsername),
      ).called(1);

      expect(result, null);
    });
  });
}
