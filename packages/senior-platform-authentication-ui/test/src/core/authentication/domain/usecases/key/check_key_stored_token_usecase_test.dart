import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../../mocks/encryption_key_mock.dart';
import '../../../../../../mocks/login_with_key_mock.dart';
import '../../../../../../mocks/token_mock.dart';

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

class MockAuthenticateKeyUsecase extends Mock
    implements AuthenticateKeyUsecase {}

class MockCheckStatusConnectionUsecase extends Mock
    implements CheckStatusConnectionUsecase {}

void main() {
  late CheckKeyStoredTokenUsecase checkKeyStoredTokenUsecase;
  late SecureStorageRepository repository;
  late AuthenticateKeyUsecase authenticateKeyUsecase;
  late CheckStatusConnectionUsecase checkStatusConnectionUsecase;
  const tAccessKey = 'tAccessKey';

  setUpAll(() {
    SeniorAuthentication.initialize(
      encryptionKey: encryptionKeyMock,
    );
  });

  setUp(() {
    repository = MockSecureStorageRepository();
    authenticateKeyUsecase = MockAuthenticateKeyUsecase();
    checkStatusConnectionUsecase = MockCheckStatusConnectionUsecase();

    checkKeyStoredTokenUsecase = CheckKeyStoredTokenUsecase(
      secureStorageRepository: repository,
      authenticateKeyUsecase: authenticateKeyUsecase,
      checkStatusConnectionUsecase: checkStatusConnectionUsecase,
    );

    when(() => repository.readKey(accessKey: tAccessKey)).thenAnswer((_) async {
      return loginWithKeyMock;
    });

    when(() => checkStatusConnectionUsecase.call(NoParams()))
        .thenAnswer((_) async {
      return true;
    });

    when(
      () => authenticateKeyUsecase.call(),
    ).thenAnswer((_) async => authenticationResponseMock);
  });

  group('checkKeyStoredTokenUsecase', () {
    DateTime tKeyTokenExpirationDate =
        DateTime.now().add(const Duration(minutes: 10));

    test('should catch exception when repository throws', () async {
      // Arrange
      when(() => repository.readKeyToken(accessKey: tAccessKey))
          .thenThrow(Exception('oops'));

      // Act
      final result = await checkKeyStoredTokenUsecase(tAccessKey);

      // Assert
      verify(
        () => repository.readKeyToken(accessKey: tAccessKey),
      ).called(1);

      expect(result, false);
    });

    test('should execute successfully token check', () async {
      // Arrange
      when(() => repository.readKeyToken(accessKey: tAccessKey))
          .thenAnswer((_) async {
        return tokenMock;
      });

      when(() => repository.readKeyTokenExpirationDate(accessKey: tAccessKey))
          .thenAnswer((_) async {
        return tKeyTokenExpirationDate;
      });

      // Act
      final result = await checkKeyStoredTokenUsecase(tAccessKey);

      // Assert
      verify(
        () => repository.readKeyToken(accessKey: tAccessKey),
      ).called(1);

      verify(
        () => repository.readKeyTokenExpirationDate(accessKey: tAccessKey),
      ).called(1);

      expect(result, true);
    });

    test('should execute successfully last token check', () async {
      // Arrange
      when(() => repository.readKeyToken(accessKey: tAccessKey))
          .thenAnswer((_) async {
        return tokenMock;
      });

      when(() => repository.readKeyTokenExpirationDate(accessKey: tAccessKey))
          .thenAnswer((_) async {
        return tKeyTokenExpirationDate;
      });

      when(() => repository.readLastKey()).thenAnswer((_) async {
        return tAccessKey;
      });

      // Act
      final result = await checkKeyStoredTokenUsecase(null);

      // Assert
      verify(
        () => repository.readKeyToken(accessKey: tAccessKey),
      ).called(1);

      verify(
        () => repository.readKeyTokenExpirationDate(accessKey: tAccessKey),
      ).called(1);

      verify(
        () => repository.readLastKey(),
      ).called(1);

      expect(result, true);
    });

    test('should verify if token is valid', () async {
      // Arrange
      when(() => repository.readKeyToken(accessKey: tAccessKey))
          .thenAnswer((_) async {
        return null;
      });

      when(() => repository.readKeyTokenExpirationDate(accessKey: tAccessKey))
          .thenAnswer((_) async {
        return tKeyTokenExpirationDate;
      });

      // Act
      final result = await checkKeyStoredTokenUsecase(tAccessKey);

      // Assert
      verify(
        () => repository.readKeyToken(accessKey: tAccessKey),
      ).called(1);

      verify(
        () => repository.readKeyTokenExpirationDate(accessKey: tAccessKey),
      ).called(1);

      expect(result, false);
    });

    test('should verify if accessToken is valid', () async {
      // Arrange
      when(() => repository.readKeyToken(accessKey: tAccessKey))
          .thenAnswer((_) async {
        return tokenMock.copyWith(accessToken: '');
      });

      when(() => repository.readKeyTokenExpirationDate(accessKey: tAccessKey))
          .thenAnswer((_) async {
        return tKeyTokenExpirationDate;
      });

      // Act
      final result = await checkKeyStoredTokenUsecase(tAccessKey);

      // Assert
      verify(
        () => repository.readKeyToken(accessKey: tAccessKey),
      ).called(1);

      verify(
        () => repository.readKeyTokenExpirationDate(accessKey: tAccessKey),
      ).called(1);

      expect(result, false);
    });

    test('should verify if refreshToken is valid', () async {
      // Arrange
      when(() => repository.readKeyToken(accessKey: tAccessKey))
          .thenAnswer((_) async {
        return tokenMock.copyWith(refreshToken: '');
      });

      when(() => repository.readKeyTokenExpirationDate(accessKey: tAccessKey))
          .thenAnswer((_) async {
        return tKeyTokenExpirationDate;
      });

      // Act
      final result = await checkKeyStoredTokenUsecase(tAccessKey);

      // Assert
      verify(
        () => repository.readKeyToken(accessKey: tAccessKey),
      ).called(1);

      verify(
        () => repository.readKeyTokenExpirationDate(accessKey: tAccessKey),
      ).called(1);

      expect(result, false);
    });

    test('should verify if tokenExpirationDate is valid', () async {
      // Arrange
      when(() => repository.readKeyToken(accessKey: tAccessKey))
          .thenAnswer((_) async {
        return tokenMock;
      });

      when(() => repository.readKeyTokenExpirationDate(accessKey: tAccessKey))
          .thenAnswer((_) async {
        return null;
      });

      // Act
      final result = await checkKeyStoredTokenUsecase(tAccessKey);

      // Assert
      verify(
        () => repository.readKeyToken(accessKey: tAccessKey),
      ).called(1);

      verify(
        () => repository.readKeyTokenExpirationDate(accessKey: tAccessKey),
      ).called(1);

      expect(result, false);
    });

    test('should verify if tokenExpirationDate is not valid', () async {
      // Arrange
      when(() => repository.readKeyToken(accessKey: tAccessKey))
          .thenAnswer((_) async {
        return tokenMock;
      });

      when(() => repository.readKeyTokenExpirationDate(accessKey: tAccessKey))
          .thenAnswer((_) async {
        return DateTime.fromMillisecondsSinceEpoch(1);
      });

      // Act
      final result = await checkKeyStoredTokenUsecase(tAccessKey);

      // Assert
      verify(
        () => repository.readKeyToken(accessKey: tAccessKey),
      ).called(1);

      verify(
        () => repository.readKeyTokenExpirationDate(accessKey: tAccessKey),
      ).called(1);

      expect(result, false);
    });
  });
}
