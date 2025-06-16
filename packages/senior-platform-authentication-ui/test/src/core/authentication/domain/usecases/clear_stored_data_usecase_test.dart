import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

void main() {
  late final ClearStoredDataUsecase clearStoredDataUsecase;
  late final SecureStorageRepository repository;
  const tCurrentUsername = 'teste@senior.com.br';
  const tUsername = UserName(currentUsername: tCurrentUsername);

  setUpAll(() {
    repository = MockSecureStorageRepository();
    clearStoredDataUsecase =
        ClearStoredDataUsecase(secureStorageRepository: repository);
  });

  group('clearStoredDataUsecase', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => repository.deleteUser(username: tCurrentUsername),
      ).thenAnswer((_) async {
        return;
      });

      when(
        () => repository.deleteToken(username: tCurrentUsername),
      ).thenAnswer((_) async {
        return;
      });

      when(
        () => repository.deleteTokenExpirationDate(username: tCurrentUsername),
      ).thenAnswer((_) async {
        return;
      });

      when(
        () => repository.deleteLastUser(),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => repository.deleteUser(username: tCurrentUsername),
      );

      verifyNever(
        () => repository.deleteToken(username: tCurrentUsername),
      );

      verifyNever(
        () => repository.deleteTokenExpirationDate(username: tCurrentUsername),
      );

      verifyNever(
        () => repository.deleteLastUser(),
      );

      // Act
      await clearStoredDataUsecase(tUsername);

      // Assert
      verify(
        () => repository.deleteUser(username: tCurrentUsername),
      ).called(1);

      verify(
        () => repository.deleteToken(username: tCurrentUsername),
      ).called(1);

      verify(
        () => repository.deleteTokenExpirationDate(username: tCurrentUsername),
      ).called(1);

      verify(
        () => repository.deleteLastUser(),
      ).called(1);
    });

    test('should execute clear only Last Usersuccessfully', () async {
      // Arrange
      when(
        () => repository.deleteLastUser(),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await clearStoredDataUsecase(tUsername, onlyLastUser: true);

      // Assert
      verifyNever(
        () => repository.deleteUser(username: tCurrentUsername),
      );

      verifyNever(
        () => repository.deleteToken(username: tCurrentUsername),
      );

      verifyNever(
        () => repository.deleteTokenExpirationDate(username: tCurrentUsername),
      );

      verify(
        () => repository.deleteLastUser(),
      );
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      when(
        () => repository.deleteUser(username: tCurrentUsername),
      ).thenThrow(Exception('oops'));

      when(
        () => repository.deleteToken(username: tCurrentUsername),
      ).thenAnswer((_) async {
        return;
      });

      when(
        () => repository.deleteTokenExpirationDate(username: tCurrentUsername),
      ).thenAnswer((_) async {
        return;
      });

      when(
        () => repository.deleteLastUser(),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => repository.deleteUser(username: tCurrentUsername),
      );

      verifyNever(
        () => repository.deleteToken(username: tCurrentUsername),
      );

      verifyNever(
        () => repository.deleteTokenExpirationDate(username: tCurrentUsername),
      );

      verifyNever(
        () => repository.deleteLastUser(),
      );

      // Act
      final action = clearStoredDataUsecase(tUsername);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      // Assert
      verify(
        () => repository.deleteUser(username: tCurrentUsername),
      ).called(1);

      verifyNever(
        () => repository.deleteToken(username: tCurrentUsername),
      );

      verifyNever(
        () => repository.deleteTokenExpirationDate(username: tCurrentUsername),
      );

      verifyNever(
        () => repository.deleteLastUser(),
      );
    });
  });
}
