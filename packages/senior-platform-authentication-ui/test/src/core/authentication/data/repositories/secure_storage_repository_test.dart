import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';
import 'package:senior_platform_authentication_ui/src/core/authentication/data/datasources/secure_storage_local_datasource.dart';
import 'package:senior_platform_authentication_ui/src/core/authentication/data/repositories/secure_storage_repository.dart';

import '../../../../../mocks/encryption_key_mock.dart';
import '../../../../../mocks/login_with_key_mock.dart';
import '../../../../../mocks/token_mock.dart';
import '../../../../../mocks/user_mock.dart';

class MockSecureStorageDatasource extends Mock
    implements SecureStorageDatasource {}

void main() {
  late final SecureStorageDatasource datasource;
  late final SecureStorageRepository repository;
  const String username = 'Teste@senior.com.br';
  String tenantDomain = 'senior.com.br';
  String accessKey = 'accessKey';

  setUpAll(() {
    datasource = MockSecureStorageDatasource();

    repository = SecureStorageRepositoryImpl(
      datasource: datasource,
    );

    SeniorAuthentication.initialize(
      encryptionKey: encryptionKeyMock,
    );

    registerFallbackValue(userModelMock);
    registerFallbackValue(tokenModelMock);
    registerFallbackValue(loginWithKeyModelMock);
    registerFallbackValue(encryptionKeyMock);
  });

  group('readUser', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.readUser(username: username.toLowerCase()),
      ).thenAnswer((_) async {
        return userModelMock;
      });

      verifyNever(
        () => datasource.readUser(username: username.toLowerCase()),
      );

      // Act
      final result = await repository.readUser(username: username);

      // Assert
      verify(
        () => datasource.readUser(username: username.toLowerCase()),
      ).called(1);

      expect(result, isA<User>());
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.readUser(username: username.toLowerCase()),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => datasource.readUser(username: username.toLowerCase()),
      );

      // Act
      final action = repository.readUser(username: username);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      // Assert
      verify(
        () => datasource.readUser(username: username.toLowerCase()),
      ).called(1);
    });
  });

  group('writeUser', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.writeUser(any()),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => datasource.writeUser(any()),
      );

      // Act
      await repository.writeUser(userMock);

      // Assert
      verify(
        () => datasource.writeUser(any()),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.writeUser(any()),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => datasource.writeUser(any()),
      );

      // Act
      final action = repository.writeUser(userMock);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      // Assert
      verify(
        () => datasource.writeUser(any()),
      ).called(1);
    });
  });

  group('readToken', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.readToken(username: username.toLowerCase()),
      ).thenAnswer((_) async {
        return tokenModelMock;
      });

      verifyNever(
        () => datasource.readToken(username: username.toLowerCase()),
      );

      // Act
      final result = await repository.readToken(username: username);

      // Assert
      verify(
        () => datasource.readToken(username: username.toLowerCase()),
      ).called(1);

      expect(result, isA<Token?>());
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.readToken(username: username.toLowerCase()),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => datasource.readToken(username: username.toLowerCase()),
      );

      // Act
      final action = repository.readToken(username: username);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      // Assert
      verify(
        () => datasource.readToken(username: username.toLowerCase()),
      ).called(1);
    });
  });

  group('readTokenExpirationDate', () {
    DateTime tTokenExpirationDate = DateTime.now();
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.readTokenExpirationDate(
            username: username.toLowerCase()),
      ).thenAnswer((_) async {
        return tTokenExpirationDate;
      });

      verifyNever(
        () => datasource.readTokenExpirationDate(
            username: username.toLowerCase()),
      );

      // Act
      final result =
          await repository.readTokenExpirationDate(username: username);

      // Assert
      verify(
        () => datasource.readTokenExpirationDate(
            username: username.toLowerCase()),
      ).called(1);

      expect(result, isA<DateTime?>());
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.readTokenExpirationDate(
            username: username.toLowerCase()),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => datasource.readTokenExpirationDate(
            username: username.toLowerCase()),
      );

      // Act
      final action = repository.readTokenExpirationDate(username: username);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      // Assert
      verify(
        () => datasource.readTokenExpirationDate(
            username: username.toLowerCase()),
      ).called(1);
    });
  });

  group('readLastUser', () {
    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.readLastUser(),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => datasource.readLastUser(),
      );

      // Act
      final action = repository.readLastUser();

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      // Assert
      verify(
        () => datasource.readLastUser(),
      ).called(1);
    });
  });

  group('writeToken', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.writeToken(any()),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => datasource.writeToken(any()),
      );

      // Act
      await repository.writeToken(tokenMock);

      // Assert
      verify(
        () => datasource.writeToken(any()),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.writeToken(any()),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => datasource.writeToken(any()),
      );

      // Act
      final action = repository.writeToken(tokenMock);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      // Assert
      verify(
        () => datasource.writeToken(any()),
      ).called(1);
    });
  });

  group('writeTokenExpirationDate', () {
    DateTime tTokenExpirationDate = DateTime.now();
    String username = 'xpto';
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.writeTokenExpirationDate(any(), any(), any()),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => datasource.writeTokenExpirationDate(any(), any(), any()),
      );

      // Act
      await repository.writeTokenExpirationDate(
          username, tenantDomain, tTokenExpirationDate);

      // Assert
      verify(
        () => datasource.writeTokenExpirationDate(any(), any(), any()),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.writeTokenExpirationDate(any(), any(), any()),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => datasource.writeTokenExpirationDate(any(), any(), any()),
      );

      // Act
      final action = repository.writeTokenExpirationDate(
          username, tenantDomain, tTokenExpirationDate);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      // Assert
      verify(
        () => datasource.writeTokenExpirationDate(any(), any(), any()),
      ).called(1);
    });
  });

  group('writeLastUser', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.writeLastUser(username.toLowerCase(), tenantDomain),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => datasource.writeLastUser(username.toLowerCase(), tenantDomain),
      );

      // Act
      await repository.writeLastUser(username, tenantDomain);

      // Assert
      verify(
        () => datasource.writeLastUser(username.toLowerCase(), tenantDomain),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.writeLastUser(username.toLowerCase(), tenantDomain),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => datasource.writeLastUser(username.toLowerCase(), tenantDomain),
      );

      // Act
      final action = repository.writeLastUser(username, tenantDomain);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      // Assert
      verify(
        () => datasource.writeLastUser(username.toLowerCase(), tenantDomain),
      ).called(1);
    });
  });

  group('deleteUser', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.deleteUser(username: username.toLowerCase()),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => datasource.deleteUser(username: username.toLowerCase()),
      );

      // Act
      await repository.deleteUser(username: username);

      // Assert
      verify(
        () => datasource.deleteUser(username: username.toLowerCase()),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.deleteUser(username: username.toLowerCase()),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => datasource.deleteUser(username: username.toLowerCase()),
      );

      // Act
      final action = repository.deleteUser(username: username);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.deleteUser(username: username.toLowerCase()),
      ).called(1);
    });
  });

  group('deleteToken', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.deleteToken(username: username.toLowerCase()),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => datasource.deleteToken(username: username.toLowerCase()),
      );

      // Act
      await repository.deleteToken(username: username);

      // Assert
      verify(
        () => datasource.deleteToken(username: username.toLowerCase()),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.deleteToken(username: username.toLowerCase()),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => datasource.deleteToken(username: username.toLowerCase()),
      );

      // Act
      final action = repository.deleteToken(username: username);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.deleteToken(username: username.toLowerCase()),
      ).called(1);
    });
  });

  group('deleteTokenExpirationDate', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.deleteTokenExpirationDate(
            username: username.toLowerCase()),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => datasource.deleteTokenExpirationDate(
            username: username.toLowerCase()),
      );

      // Act
      await repository.deleteTokenExpirationDate(username: username);

      // Assert
      verify(
        () => datasource.deleteTokenExpirationDate(
            username: username.toLowerCase()),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.deleteTokenExpirationDate(
            username: username.toLowerCase()),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => datasource.deleteTokenExpirationDate(
            username: username.toLowerCase()),
      );

      // Act
      final action = repository.deleteTokenExpirationDate(username: username);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.deleteTokenExpirationDate(
            username: username.toLowerCase()),
      ).called(1);
    });
  });

  group('deleteLastUser', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.deleteLastUser(),
      ).thenAnswer((_) async {
        return;
      });

      verifyNever(
        () => datasource.deleteLastUser(),
      );

      // Act
      await repository.deleteLastUser();

      // Assert
      verify(
        () => datasource.deleteLastUser(),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.deleteLastUser(),
      ).thenThrow(Exception('oops'));

      verifyNever(
        () => datasource.deleteLastUser(),
      );

      // Act
      final action = repository.deleteLastUser();

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.deleteLastUser(),
      ).called(1);
    });
  });

  // ------------- KEY -------------
  group('readKey', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.readKey(accessKey: any(named: 'accessKey')),
      ).thenAnswer((_) async {
        return loginWithKeyModelMock;
      });

      // Act
      final result = await repository.readKey(accessKey: accessKey);

      // Assert
      expect(result, isA<LoginWithKey>());

      verify(
        () => datasource.readKey(accessKey: any(named: 'accessKey')),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.readKey(accessKey: any(named: 'accessKey')),
      ).thenThrow(Exception('oops'));

      // Act
      final action = repository.readKey(accessKey: accessKey);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.readKey(accessKey: any(named: 'accessKey')),
      ).called(1);
    });
  });

  group('readKeyToken', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.readKeyToken(accessKey: any(named: 'accessKey')),
      ).thenAnswer((_) async {
        return tokenModelMock;
      });

      // Act
      final result = await repository.readKeyToken(accessKey: accessKey);

      // Assert
      expect(result, isA<Token>());

      verify(
        () => datasource.readKeyToken(accessKey: any(named: 'accessKey')),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.readKeyToken(accessKey: any(named: 'accessKey')),
      ).thenThrow(Exception('oops'));

      // Act
      final action = repository.readKeyToken(accessKey: accessKey);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.readKeyToken(accessKey: any(named: 'accessKey')),
      ).called(1);
    });
  });

  group('readKeyTokenExpirationDate', () {
    DateTime tTokenExpirationDate = DateTime.now();

    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.readKeyTokenExpirationDate(
            accessKey: any(named: 'accessKey')),
      ).thenAnswer((_) async {
        return tTokenExpirationDate;
      });

      // Act
      final result =
          await repository.readKeyTokenExpirationDate(accessKey: accessKey);

      // Assert
      expect(result, isA<DateTime?>());

      verify(
        () => datasource.readKeyTokenExpirationDate(
            accessKey: any(named: 'accessKey')),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.readKeyTokenExpirationDate(
            accessKey: any(named: 'accessKey')),
      ).thenThrow(Exception('oops'));

      // Act
      final action =
          repository.readKeyTokenExpirationDate(accessKey: accessKey);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.readKeyTokenExpirationDate(
            accessKey: any(named: 'accessKey')),
      ).called(1);
    });
  });

  group('readLastKey', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.readLastKey(),
      ).thenAnswer((_) async {
        return tokenModelJson;
      });

      // Act
      final result = await repository.readLastKey();

      // Assert
      expect(result, isA<String?>());

      verify(
        () => datasource.readLastKey(),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.readLastKey(),
      ).thenThrow(Exception('oops'));

      // Act
      final action = repository.readLastKey();

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.readLastKey(),
      ).called(1);
    });
  });

  group('writeKey', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.writeKey(
            loginWithKeyModel: any(named: 'loginWithKeyModel')),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await repository.writeKey(loginWithKey: loginWithKeyMock);

      // Assert
      verify(
        () => datasource.writeKey(
            loginWithKeyModel: any(named: 'loginWithKeyModel')),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.writeKey(
            loginWithKeyModel: any(named: 'loginWithKeyModel')),
      ).thenThrow(Exception('oops'));

      // Act
      final action = repository.writeKey(loginWithKey: loginWithKeyMock);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.writeKey(
            loginWithKeyModel: any(named: 'loginWithKeyModel')),
      ).called(1);
    });
  });

  group('writeKeyToken', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.writeKeyToken(
          accessKey: any(named: 'accessKey'),
          token: any(named: 'token'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await repository.writeKeyToken(
        accessKey: accessKey,
        token: tokenMock,
      );

      // Assert
      verify(
        () => datasource.writeKeyToken(
          accessKey: any(named: 'accessKey'),
          token: any(named: 'token'),
        ),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.writeKeyToken(
          accessKey: any(named: 'accessKey'),
          token: any(named: 'token'),
        ),
      ).thenThrow(Exception('oops'));

      // Act
      final action = repository.writeKeyToken(
        accessKey: accessKey,
        token: tokenMock,
      );

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.writeKeyToken(
          accessKey: any(named: 'accessKey'),
          token: any(named: 'token'),
        ),
      ).called(1);
    });
  });

  group('writeKeyTokenExpirationDate', () {
    DateTime tTokenExpirationDate = DateTime.now();
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.writeKeyTokenExpirationDate(
          accessKey: any(named: 'accessKey'),
          tokenExpirationDate: any(named: 'tokenExpirationDate'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await repository.writeKeyTokenExpirationDate(
        accessKey: accessKey,
        tokenExpirationDate: tTokenExpirationDate,
      );

      // Assert
      verify(
        () => datasource.writeKeyTokenExpirationDate(
          accessKey: any(named: 'accessKey'),
          tokenExpirationDate: any(named: 'tokenExpirationDate'),
        ),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.writeKeyTokenExpirationDate(
          accessKey: any(named: 'accessKey'),
          tokenExpirationDate: any(named: 'tokenExpirationDate'),
        ),
      ).thenThrow(Exception('oops'));

      // Act
      final action = repository.writeKeyTokenExpirationDate(
        accessKey: accessKey,
        tokenExpirationDate: tTokenExpirationDate,
      );

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.writeKeyTokenExpirationDate(
          accessKey: any(named: 'accessKey'),
          tokenExpirationDate: any(named: 'tokenExpirationDate'),
        ),
      ).called(1);
    });
  });

  group('writeLastKey', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.writeLastKey(accessKey: any(named: 'accessKey')),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await repository.writeLastKey(accessKey);

      // Assert
      verify(
        () => datasource.writeLastKey(accessKey: any(named: 'accessKey')),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.writeLastKey(accessKey: any(named: 'accessKey')),
      ).thenThrow(Exception('oops'));

      // Act
      final action = repository.writeLastKey(accessKey);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.writeLastKey(accessKey: any(named: 'accessKey')),
      ).called(1);
    });
  });

  group('deleteKey', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.deleteKey(accessKey: any(named: 'accessKey')),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await repository.deleteKey(accessKey: accessKey);

      // Assert
      verify(
        () => datasource.deleteKey(accessKey: any(named: 'accessKey')),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.deleteKey(accessKey: any(named: 'accessKey')),
      ).thenThrow(Exception('oops'));

      // Act
      final action = repository.deleteKey(accessKey: accessKey);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.deleteKey(accessKey: any(named: 'accessKey')),
      ).called(1);
    });
  });

  group('deleteKeyToken', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.deleteKeyToken(accessKey: any(named: 'accessKey')),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await repository.deleteKeyToken(accessKey: accessKey);

      // Assert
      verify(
        () => datasource.deleteKeyToken(accessKey: any(named: 'accessKey')),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.deleteKeyToken(accessKey: any(named: 'accessKey')),
      ).thenThrow(Exception('oops'));

      // Act
      final action = repository.deleteKeyToken(accessKey: accessKey);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.deleteKeyToken(accessKey: any(named: 'accessKey')),
      ).called(1);
    });
  });

  group('deleteKeyTokenExpirationDate', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.deleteKeyTokenExpirationDate(
            accessKey: any(named: 'accessKey')),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await repository.deleteKeyTokenExpirationDate(accessKey: accessKey);

      // Assert
      verify(
        () => datasource.deleteKeyTokenExpirationDate(
            accessKey: any(named: 'accessKey')),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.deleteKeyTokenExpirationDate(
            accessKey: any(named: 'accessKey')),
      ).thenThrow(Exception('oops'));

      // Act
      final action =
          repository.deleteKeyTokenExpirationDate(accessKey: accessKey);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.deleteKeyTokenExpirationDate(
            accessKey: any(named: 'accessKey')),
      ).called(1);
    });
  });

  group('deleteLastKey', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => datasource.deleteLastKey(),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await repository.deleteLastKey();

      // Assert
      verify(
        () => datasource.deleteLastKey(),
      ).called(1);
    });

    test('should throw exception when datasource throws', () async {
      // Arrange
      when(
        () => datasource.deleteLastKey(),
      ).thenThrow(Exception('oops'));

      // Act
      final action = repository.deleteLastKey();

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => datasource.deleteLastKey(),
      ).called(1);
    });
  });
}
