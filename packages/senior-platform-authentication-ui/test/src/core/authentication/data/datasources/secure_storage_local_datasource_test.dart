import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';
import 'package:senior_platform_authentication_ui/src/core/authentication/data/datasources/secure_storage_local_datasource.dart';
import 'package:senior_platform_authentication_ui/src/core/authentication/domain/entities/secure_storage_keys.dart';

import '../../../../../mocks/encryption_key_mock.dart';
import '../../../../../mocks/login_with_key_mock.dart';
import '../../../../../mocks/token_mock.dart';
import '../../../../../mocks/user_mock.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late final FlutterSecureStorage storage;
  late final SecureStorageDatasource datasource;
  const String username = 'teste@senior.com.br';
  const String accessKey = 'accessKey';

  setUpAll(() {
    SeniorAuthentication.initialize(
      encryptionKey: encryptionKeyMock,
    );

    storage = MockFlutterSecureStorage();
    datasource = SecureStorageLocalDatasource(storage: storage);

    registerFallbackValue(encryptionKeyMock);
  });

  group('readUser', () {
    test('should execute successfully', () async {
      final encryptedData = datasource.encryptString(userModelMock.toJson());

      // Arrange
      when(
        () => storage.read(
          key: '$username-${SecureStorageKeys.user}',
        ),
      ).thenAnswer((_) async {
        return encryptedData;
      });

      // Act
      final result = await datasource.readUser(username: username);

      // Assert
      expect(result, isA<UserModel?>());

      verify(
        () => storage.read(key: '$username-${SecureStorageKeys.user}'),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.read(key: '$username-${SecureStorageKeys.user}'),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.readUser(username: username);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.read(key: '$username-${SecureStorageKeys.user}'),
      ).called(1);
    });
  });

  group('readToken', () {
    test('should execute successfully', () async {
      final encryptedData = datasource.encryptString(tokenModelJson);
      // Arrange
      when(
        () => storage.read(
          key: '$username-${SecureStorageKeys.token}',
        ),
      ).thenAnswer((_) async {
        return encryptedData;
      });

      // Act
      final result = await datasource.readToken(username: username);

      // Assert
      expect(result, isA<TokenModel?>());

      verify(
        () => storage.read(key: '$username-${SecureStorageKeys.token}'),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.read(key: '$username-${SecureStorageKeys.token}'),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.readToken(username: username);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.read(key: '$username-${SecureStorageKeys.token}'),
      ).called(1);
    });
  });

  group('readTokenExpirationDate', () {
    DateTime tTokenExpirationDate = DateTime.now();
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.read(
          key: '$username-${SecureStorageKeys.tokenExpirationDate}',
        ),
      ).thenAnswer((_) async {
        return tTokenExpirationDate.toIso8601String();
      });

      // Act
      final result =
          await datasource.readTokenExpirationDate(username: username);

      // Assert
      expect(result, isA<DateTime?>());

      verify(
        () => storage.read(
            key: '$username-${SecureStorageKeys.tokenExpirationDate}'),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.read(
            key: '$username-${SecureStorageKeys.tokenExpirationDate}'),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.readTokenExpirationDate(username: username);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.read(
            key: '$username-${SecureStorageKeys.tokenExpirationDate}'),
      ).called(1);
    });
  });

  group('readLastUser', () {
    test('should execute successfully', () async {
      final encryptedData = datasource.encryptString(username);
      // Arrange
      when(
        () => storage.read(
          key: SecureStorageKeys.lastUser,
        ),
      ).thenAnswer((_) async {
        return encryptedData;
      });

      // Act
      final result = await datasource.readLastUser();

      // Assert
      expect(result, isA<String?>());

      verify(
        () => storage.read(key: SecureStorageKeys.lastUser),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.read(key: SecureStorageKeys.lastUser),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.readLastUser();

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.read(key: SecureStorageKeys.lastUser),
      ).called(1);
    });
  });

  group('writeUser', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.writeUser(userModelMock);

      // Assert
      verify(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.writeUser(userModelMock);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).called(1);
    });
  });

  group('writeToken', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.writeToken(tokenModelMock);

      // Assert
      verify(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.writeToken(tokenModelMock);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).called(1);
    });
  });

  group('writeTokenExpirationDate', () {
    DateTime tTokenExpirationDate = DateTime.now();
    String username = 'xpto';
    String tenantDomain = 'senior.com.br';
    test('should execute successfully', () async {
      // Arrange
      String keyUser = username;
      if (!keyUser.contains('@')) {
        keyUser += '@$tenantDomain';
      }

      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.writeTokenExpirationDate(
        username,
        tenantDomain,
        tTokenExpirationDate,
      );

      // Assert
      verify(
        () => storage.write(
          key: '$keyUser-${SecureStorageKeys.tokenExpirationDate}',
          value: tTokenExpirationDate.toIso8601String(),
        ),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      String keyUser = username;
      if (!keyUser.contains('@')) {
        keyUser += '@$tenantDomain';
      }

      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.writeTokenExpirationDate(
        username,
        tenantDomain,
        tTokenExpirationDate,
      );

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.write(
          key: '$keyUser-${SecureStorageKeys.tokenExpirationDate}',
          value: tTokenExpirationDate.toIso8601String(),
        ),
      ).called(1);
    });
  });

  group('writeLastUser', () {
    String username = 'xpto';
    String tenantDomain = 'senior.com.br';
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.writeLastUser(username, tenantDomain);

      // Assert
      verify(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.writeLastUser(username, tenantDomain);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).called(1);
    });
  });

  group('deleteUser', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.deleteUser(username: username);

      // Assert
      verify(
        () => storage.delete(key: '$username-${SecureStorageKeys.user}'),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.deleteUser(username: username);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.delete(key: '$username-${SecureStorageKeys.user}'),
      ).called(1);
    });
  });

  group('deleteToken', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.deleteToken(username: username);

      // Assert
      verify(
        () => storage.delete(key: '$username-${SecureStorageKeys.token}'),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.deleteToken(username: username);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.delete(key: '$username-${SecureStorageKeys.token}'),
      ).called(1);
    });
  });

  group('deleteTokenExpirationDate', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.deleteTokenExpirationDate(username: username);

      // Assert
      verify(
        () => storage.delete(
            key: '$username-${SecureStorageKeys.tokenExpirationDate}'),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.deleteTokenExpirationDate(username: username);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.delete(
            key: '$username-${SecureStorageKeys.tokenExpirationDate}'),
      ).called(1);
    });
  });

  group('deleteLastUser', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.deleteLastUser();

      // Assert
      verify(
        () => storage.delete(key: SecureStorageKeys.lastUser),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.deleteLastUser();

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.delete(key: SecureStorageKeys.lastUser),
      ).called(1);
    });
  });

// ------------- KEY -------------
  group('readKey', () {
    test('should execute successfully', () async {
      final encryptedData = datasource.encryptString(loginWithKeyModelJsonMock);
      // Arrange
      when(
        () => storage.read(key: '$accessKey-${SecureStorageKeys.key}'),
      ).thenAnswer((_) async {
        return encryptedData;
      });

      // Act
      final result = await datasource.readKey(accessKey: accessKey);

      // Assert
      expect(result, isA<LoginWithKeyModel?>());

      verify(
        () => storage.read(key: '$accessKey-${SecureStorageKeys.key}'),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.read(key: '$accessKey-${SecureStorageKeys.key}'),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.readKey(accessKey: accessKey);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.read(key: '$accessKey-${SecureStorageKeys.key}'),
      ).called(1);
    });
  });

  group('readKeyToken', () {
    test('should execute successfully', () async {
      final encryptedData = datasource.encryptString(tokenModelJson);
      // Arrange
      when(
        () => storage.read(key: '$accessKey-${SecureStorageKeys.keyToken}'),
      ).thenAnswer((_) async {
        return encryptedData;
      });

      // Act
      final result = await datasource.readKeyToken(accessKey: accessKey);

      // Assert
      expect(result, isA<TokenModel?>());

      verify(
        () => storage.read(key: '$accessKey-${SecureStorageKeys.keyToken}'),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.read(key: '$accessKey-${SecureStorageKeys.keyToken}'),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.readKeyToken(accessKey: accessKey);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.read(key: '$accessKey-${SecureStorageKeys.keyToken}'),
      ).called(1);
    });
  });

  group('readKeyTokenExpirationDate', () {
    DateTime tTokenExpirationDate = DateTime.now();

    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.read(
            key: '$accessKey-${SecureStorageKeys.keyTokenExpirationDate}'),
      ).thenAnswer((_) async {
        return tTokenExpirationDate.toIso8601String();
      });

      // Act
      final result =
          await datasource.readKeyTokenExpirationDate(accessKey: accessKey);

      // Assert
      expect(result, isA<DateTime?>());

      verify(
        () => storage.read(
            key: '$accessKey-${SecureStorageKeys.keyTokenExpirationDate}'),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.read(
            key: '$accessKey-${SecureStorageKeys.keyTokenExpirationDate}'),
      ).thenThrow(Exception('oops'));

      // Act
      final action =
          datasource.readKeyTokenExpirationDate(accessKey: accessKey);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.read(
            key: '$accessKey-${SecureStorageKeys.keyTokenExpirationDate}'),
      ).called(1);
    });
  });

  group('readLastKey', () {
    test('should execute successfully', () async {
      final encryptedData = datasource.encryptString(tokenModelJson);
      // Arrange
      when(
        () => storage.read(key: SecureStorageKeys.lastKey),
      ).thenAnswer((_) async {
        return encryptedData;
      });

      // Act
      final result = await datasource.readLastKey();

      // Assert
      expect(result, isA<String?>());

      verify(
        () => storage.read(key: SecureStorageKeys.lastKey),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.read(key: SecureStorageKeys.lastKey),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.readLastKey();

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.read(key: SecureStorageKeys.lastKey),
      ).called(1);
    });
  });

  group('writeKey', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.writeKey(loginWithKeyModel: loginWithKeyModelMock);

      // Assert
      verify(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenThrow(Exception('oops'));

      // Act
      final action =
          datasource.writeKey(loginWithKeyModel: loginWithKeyModelMock);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).called(1);
    });
  });

  group('writeKeyToken', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.writeKeyToken(
        accessKey: accessKey,
        token: tokenModelMock,
      );

      // Assert
      verify(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.writeKeyToken(
        accessKey: accessKey,
        token: tokenModelMock,
      );

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).called(1);
    });
  });

  group('writeKeyTokenExpirationDate', () {
    DateTime tTokenExpirationDate = DateTime.now();
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.writeKeyTokenExpirationDate(
        accessKey: accessKey,
        tokenExpirationDate: tTokenExpirationDate,
      );

      // Assert
      verify(
        () => storage.write(
          key: '$accessKey-${SecureStorageKeys.keyTokenExpirationDate}',
          value: tTokenExpirationDate.toIso8601String(),
        ),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.writeKeyTokenExpirationDate(
        accessKey: accessKey,
        tokenExpirationDate: tTokenExpirationDate,
      );

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.write(
          key: '$accessKey-${SecureStorageKeys.keyTokenExpirationDate}',
          value: tTokenExpirationDate.toIso8601String(),
        ),
      ).called(1);
    });
  });

  group('writeLastKey', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.writeLastKey(
        accessKey: accessKey,
      );

      // Assert
      verify(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.writeLastKey(
        accessKey: accessKey,
      );

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).called(1);
    });
  });

  group('deleteKey', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.deleteKey(accessKey: accessKey);

      // Assert
      verify(
        () => storage.delete(key: '$accessKey-${SecureStorageKeys.key}'),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.deleteKey(accessKey: accessKey);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.delete(key: '$accessKey-${SecureStorageKeys.key}'),
      ).called(1);
    });
  });

  group('deleteKeyToken', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.deleteKeyToken(accessKey: accessKey);

      // Assert
      verify(
        () => storage.delete(key: '$accessKey-${SecureStorageKeys.keyToken}'),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.deleteKeyToken(accessKey: accessKey);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.delete(key: '$accessKey-${SecureStorageKeys.keyToken}'),
      ).called(1);
    });
  });

  group('deleteKeyTokenExpirationDate', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.deleteKeyTokenExpirationDate(accessKey: accessKey);

      // Assert
      verify(
        () => storage.delete(
            key: '$accessKey-${SecureStorageKeys.keyTokenExpirationDate}'),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenThrow(Exception('oops'));

      // Act
      final action =
          datasource.deleteKeyTokenExpirationDate(accessKey: accessKey);

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.delete(
            key: '$accessKey-${SecureStorageKeys.keyTokenExpirationDate}'),
      ).called(1);
    });
  });

  group('deleteLastKey', () {
    test('should execute successfully', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {
        return;
      });

      // Act
      await datasource.deleteLastKey();

      // Assert
      verify(
        () => storage.delete(key: SecureStorageKeys.lastKey),
      ).called(1);
    });

    test('storage throws', () async {
      // Arrange
      when(
        () => storage.delete(key: any(named: 'key')),
      ).thenThrow(Exception('oops'));

      // Act
      final action = datasource.deleteLastKey();

      // Assert
      expect(
        () async => await action,
        throwsA(isA<Exception>()),
      );

      verify(
        () => storage.delete(key: SecureStorageKeys.lastKey),
      ).called(1);
    });
  });

  group('encryptString', () {
    test('should encrypt a string', () {
      const data = 'test string';
      final encryptedData = datasource.encryptString(data);

      expect(encryptedData, isNotEmpty);
      expect(encryptedData, isNot(equals(data)));
    });
  });

  group('decryptString', () {
    test('should decrypt an encrypted string', () {
      const data = 'test string';
      final encryptedData = datasource.encryptString(data);
      final decryptedData = datasource.decryptString(encryptedData);

      expect(decryptedData, equals(data));
    });
  });
}
