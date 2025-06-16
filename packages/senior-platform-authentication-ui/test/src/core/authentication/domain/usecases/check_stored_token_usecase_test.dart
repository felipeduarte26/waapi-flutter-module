import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../mocks/encryption_key_mock.dart';
import '../../../../../mocks/get_user_input_mock.dart';
import '../../../../../mocks/token_mock.dart';
import '../../../../../mocks/user_mock.dart';

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

class MockGetUserUsecase extends Mock implements GetUserUsecase {}

class MockCheckStatusConnectionUsecase extends Mock
    implements CheckStatusConnectionUsecase {}

void main() {
  late CheckStoredTokenUsecase checkStoredTokenUsecase;
  late SecureStorageRepository repository;
  late GetUserUsecase getUserUsecase;
  late CheckStatusConnectionUsecase checkStatusConnectionUsecase;
  const tCurrentUsername = 'teste@senior.com.br';
  const tUsername = UserName(currentUsername: tCurrentUsername);

  setUpAll(() {
    SeniorAuthentication.initialize(
      encryptionKey: encryptionKeyMock,
    );
  });

  setUp(() {
    repository = MockSecureStorageRepository();
    getUserUsecase = MockGetUserUsecase();
    checkStatusConnectionUsecase = MockCheckStatusConnectionUsecase();
    checkStoredTokenUsecase = CheckStoredTokenUsecase(
      secureStorageRepository: repository,
      getUserUsecase: getUserUsecase,
      checkStatusConnectionUsecase: checkStatusConnectionUsecase,
    );
    registerFallbackValue(getUserInputMock);
    registerFallbackValue(encryptionKeyMock);
  });

  group('checkStoredTokenUsecase', () {
    DateTime tTokenExpirationDate =
        DateTime.now().add(const Duration(minutes: 10));
    test('should execute successfully online with login', () async {
      // Arrange
      when(() => checkStatusConnectionUsecase.call(NoParams())).thenAnswer(
        (_) async => true,
      );

      when(() => repository.readLastUser()).thenAnswer((_) async {
        return tCurrentUsername;
      });

      when(() => repository.readToken(username: tCurrentUsername))
          .thenAnswer((_) async {
        return tokenMock;
      });

      when(() => getUserUsecase.call(any())).thenAnswer((_) async {
        return userMock;
      });

      when(() => repository.readTokenExpirationDate(username: tCurrentUsername))
          .thenAnswer((_) async {
        return tTokenExpirationDate;
      });

      verifyNever(() => repository.readToken(username: tCurrentUsername));

      verifyNever(() => repository.readLastUser());

      // Act
      final result = await checkStoredTokenUsecase(tUsername);

      // Assert
      verify(
        () => repository.readToken(username: tCurrentUsername),
      ).called(1);

      expect(result, true);
    });

    test(
        'must be successfully run online with login with  checkOnline parameter true',
        () async {
      // Arrange
      when(() => checkStatusConnectionUsecase.call(NoParams())).thenAnswer(
        (_) async => true,
      );

      when(() => repository.readLastUser()).thenAnswer((_) async {
        return tCurrentUsername;
      });

      when(() => repository.readToken(username: tCurrentUsername))
          .thenAnswer((_) async {
        return tokenMock;
      });

      when(() => getUserUsecase.call(any())).thenAnswer((_) async {
        return userMock;
      });

      when(() => repository.readTokenExpirationDate(username: tCurrentUsername))
          .thenAnswer((_) async {
        return tTokenExpirationDate;
      });

      verifyNever(() => repository.readToken(username: tCurrentUsername));

      verifyNever(() => repository.readLastUser());

      // Act
      final result =
          await checkStoredTokenUsecase(tUsername, checkOnline: false);

      // Assert
      verify(
        () => repository.readToken(username: tCurrentUsername),
      ).called(1);

      expect(result, true);
    });

    test('should execute successfully online login with last user', () async {
      // Arrange
      when(() => checkStatusConnectionUsecase.call(NoParams())).thenAnswer(
        (_) async => true,
      );

      when(() => repository.readLastUser()).thenAnswer((_) async {
        return;
      });

      when(() => repository.readToken(username: '')).thenAnswer((_) async {
        return tokenMock;
      });

      when(() => getUserUsecase.call(any())).thenAnswer((_) async {
        return userMock;
      });

      when(() => repository.readTokenExpirationDate(username: ''))
          .thenAnswer((_) async {
        return tTokenExpirationDate;
      });

      verifyNever(() => repository.readToken(username: ''));

      verifyNever(() => repository.readLastUser());

      // Act
      final result = await checkStoredTokenUsecase(const UserName());

      // Assert
      verify(
        () => repository.readToken(username: ''),
      ).called(1);

      expect(result, true);
    });

    test('should execute successfully offline', () async {
      // Arrange
      when(() => checkStatusConnectionUsecase.call(NoParams())).thenAnswer(
        (_) async => false,
      );

      when(() => repository.readLastUser()).thenAnswer((_) async {
        return tCurrentUsername;
      });

      when(() => repository.readToken(username: tCurrentUsername))
          .thenAnswer((_) async {
        return tokenMock;
      });

      when(() => getUserUsecase.call(any())).thenAnswer((_) async {
        return userMock;
      });

      when(() => repository.readTokenExpirationDate(username: tCurrentUsername))
          .thenAnswer((_) async {
        return tTokenExpirationDate;
      });

      verifyNever(() => repository.readToken(username: tCurrentUsername));

      verifyNever(() => repository.readLastUser());

      verifyNever(() => getUserUsecase.call(any()));

      // Act
      final result = await checkStoredTokenUsecase(tUsername);

      // Assert
      verify(
        () => repository.readToken(username: tCurrentUsername),
      ).called(1);

      expect(result, true);
    });

    test('should catch exception when repository throws', () async {
      // Arrange
      when(() => repository.readToken(username: tCurrentUsername))
          .thenThrow(Exception('oops'));
      when(() => getUserUsecase.call(any())).thenAnswer((_) async {
        return userMock;
      });

      verifyNever(() => repository.readToken(username: tCurrentUsername));

      // Act
      final result = await checkStoredTokenUsecase(tUsername);

      // Assert
      expect(result, false);

      // Assert
      verify(
        () => repository.readToken(username: tCurrentUsername),
      ).called(1);
    });

    test('should verify if token is valid', () async {
      // Arrange
      when(() => repository.readToken(username: tCurrentUsername))
          .thenAnswer((_) async {
        return null;
      });

      when(() => getUserUsecase.call(any())).thenAnswer((_) async {
        return userMock;
      });

      verifyNever(
        () => repository.readToken(username: tCurrentUsername),
      );

      // Act
      final result = await checkStoredTokenUsecase(tUsername);

      // Assert
      verify(
        () => repository.readToken(username: tCurrentUsername),
      ).called(1);

      expect(result, false);
    });

    test('should verify if accessToken is valid', () async {
      // Arrange
      when(() => repository.readToken(username: tCurrentUsername))
          .thenAnswer((_) async {
        return tokenMock.copyWith(accessToken: '');
      });

      when(() => getUserUsecase.call(any())).thenAnswer((_) async {
        return userMock;
      });

      verifyNever(() => repository.readToken(username: tCurrentUsername));

      // Act
      final result = await checkStoredTokenUsecase(tUsername);

      // Assert
      verify(
        () => repository.readToken(username: tCurrentUsername),
      ).called(1);

      expect(result, false);
    });

    test('should verify if refreshToken is valid', () async {
      // Arrange
      when(() => repository.readToken(username: tCurrentUsername))
          .thenAnswer((_) async {
        return tokenMock.copyWith(refreshToken: '');
      });

      when(() => getUserUsecase.call(any())).thenAnswer((_) async {
        return userMock;
      });

      verifyNever(() => repository.readToken(username: tCurrentUsername));

      // Act
      final result = await checkStoredTokenUsecase(tUsername);

      // Assert
      verify(
        () => repository.readToken(username: tCurrentUsername),
      ).called(1);

      expect(result, false);
    });

    test('should verify if tokenExpirationDate is valid', () async {
      // Arrange
      when(() => repository.readTokenExpirationDate(username: tCurrentUsername))
          .thenAnswer((_) async {
        return DateTime.fromMillisecondsSinceEpoch(1);
      });

      when(() => getUserUsecase.call(any())).thenAnswer((_) async {
        return userMock;
      });

      verifyNever(
          () => repository.readTokenExpirationDate(username: tCurrentUsername));

      // Act
      final result = await checkStoredTokenUsecase(tUsername);

      // Assert
      verify(
        () => repository.readToken(username: tCurrentUsername),
      ).called(1);

      expect(result, false);
    });

    test('should return false when token is not valid', () async {
      // Arrange
      when(() => repository.readTokenExpirationDate(username: tCurrentUsername))
          .thenAnswer((_) async {
        return DateTime.fromMillisecondsSinceEpoch(1);
      });

      when(() => getUserUsecase.call(any())).thenThrow(UnauthorizedException());

      verifyNever(
          () => repository.readTokenExpirationDate(username: tCurrentUsername));

      // Act
      final result = await checkStoredTokenUsecase(tUsername);

      // Assert
      verify(
        () => repository.readToken(username: tCurrentUsername),
      ).called(1);

      expect(result, false);
    });
  });
}
