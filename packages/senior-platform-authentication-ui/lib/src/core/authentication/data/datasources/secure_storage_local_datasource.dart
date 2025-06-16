import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../domain/entities/secure_storage_keys.dart';

abstract class SecureStorageDatasource {
  Future<void> deleteUser({required String username});
  Future<void> deleteToken({required String username});
  Future<void> deleteTokenExpirationDate({required String username});
  Future<UserModel?> readUser({required String username});
  Future<TokenModel?> readToken({required String username});
  Future<DateTime?> readTokenExpirationDate({required String username});
  Future<String?> readLastUser();
  Future<void> writeUser(UserModel user);
  Future<void> writeToken(TokenModel token);
  Future<void> writeTokenExpirationDate(
      String username, String tenantDomain, DateTime tokenExpirationDate);
  Future<void> writeLastUser(
    String username,
    String tenantDomain,
  );
  Future<void> deleteLastUser();
  Future<void> writeKey({required LoginWithKeyModel loginWithKeyModel});
  Future<void> writeKeyToken({
    required String accessKey,
    required TokenModel token,
  });
  Future<void> writeKeyTokenExpirationDate({
    required String accessKey,
    required DateTime tokenExpirationDate,
  });
  Future<void> writeLastKey({required String accessKey});
  Future<void> deleteKey({required String accessKey});
  Future<void> deleteKeyToken({required String accessKey});
  Future<void> deleteKeyTokenExpirationDate({required String accessKey});
  Future<void> deleteLastKey();
  Future<LoginWithKeyModel?> readKey({required String accessKey});
  Future<TokenModel?> readKeyToken({required String accessKey});
  Future<DateTime?> readKeyTokenExpirationDate({required String accessKey});
  Future<String?> readLastKey();
  String encryptString(String data);
  String decryptString(String encryptedData);
}

class SecureStorageLocalDatasource implements SecureStorageDatasource {
  late final FlutterSecureStorage _storage;
  late final encrypt.Encrypter _encrypter;
  final _encryptionKey = encrypt.Key.fromUtf8(SeniorAuthentication.encryptionKey);

  SecureStorageLocalDatasource({
    FlutterSecureStorage? storage,
  }) {
    _storage = storage ?? const FlutterSecureStorage();
    _encrypter = encrypt.Encrypter(encrypt.AES( _encryptionKey),
    );
  }

  @override
  String encryptString(String data) {
    final iv = encrypt.IV.fromLength(16);
    final encrypted = _encrypter.encrypt(data, iv: iv);
    return iv.base64 + encrypted.base64;
  }

  @override
  String decryptString(String encryptedData) {
    final iv = encrypt.IV.fromBase64(encryptedData.substring(0, 24));
    final encryptedText = encryptedData.substring(24);
    final decrypted = _encrypter.decrypt(encrypt.Encrypted.fromBase64(encryptedText), iv: iv);
    return decrypted;
  }

  @override
  Future<UserModel?> readUser({required String username}) async {
    final jsonStr =
        await _storage.read(key: '$username-${SecureStorageKeys.user}');

    if (jsonStr != null) {
      final decryptedJson = decryptString(jsonStr);
      return UserModel.fromJson(decryptedJson);
    }

    return null;
  }

  @override
  Future<TokenModel?> readToken({required String username}) async {
    final jsonStr =
        await _storage.read(key: '$username-${SecureStorageKeys.token}');

    if (jsonStr != null) {
      final decryptedJson = decryptString(jsonStr);
      return TokenModel.fromJson(decryptedJson);
    }

    return null;
  }

  @override
  Future<DateTime?> readTokenExpirationDate({required String username}) async {
    final jsonStr = await _storage.read(
        key: '$username-${SecureStorageKeys.tokenExpirationDate}');

    if (jsonStr != null) {
      return DateTime.tryParse(jsonStr);
    }

    return null;
  }

  @override
  Future<void> writeUser(UserModel user) async {
    String keyUser = user.username;
    if (!keyUser.contains('@')) {
      keyUser += '@${user.tenantDomain}';
    }

    final encryptedJson = encryptString(user.toJson());

    await _storage.write(
      key: '$keyUser-${SecureStorageKeys.user}',
      value: encryptedJson,
    );
  }

  @override
  Future<void> writeToken(TokenModel token) async {
    final encryptedJson = encryptString(token.toJson());

    await _storage.write(key: '${token.username}-${SecureStorageKeys.token}', value: encryptedJson);
  }

  @override
  Future<void> writeTokenExpirationDate(String username, String tenantDomain, DateTime tokenExpirationDate) async {
    String keyUser = username;
    if (!keyUser.contains('@')) {
      keyUser += '@$tenantDomain';
    }
    await _storage.write(
        key: '$keyUser-${SecureStorageKeys.tokenExpirationDate}', value: tokenExpirationDate.toIso8601String());
  }

  @override
  Future<void> deleteUser({required String username}) async {
    await _storage.delete(key: '$username-${SecureStorageKeys.user}');
  }

  @override
  Future<void> deleteToken({required String username}) async {
    await _storage.delete(key: '$username-${SecureStorageKeys.token}');
  }

  @override
  Future<void> deleteTokenExpirationDate({required String username}) async {
    await _storage.delete(key: '$username-${SecureStorageKeys.tokenExpirationDate}');
  }

  @override
  Future<String?> readLastUser() async {
    final jsonStr = await _storage.read(key: SecureStorageKeys.lastUser);

    if (jsonStr != null) {
      final decryptedJson = decryptString(jsonStr);
      return decryptedJson;
    }

    return null;
  }

  @override
  Future<void> writeLastUser(String username, String tenantDomain) async {
    String keyUser = username;
    if (!keyUser.contains('@') && tenantDomain.isNotEmpty) {
      keyUser += '@$tenantDomain';
    }
    final encryptedString = encryptString(keyUser);

    await _storage.write(key: SecureStorageKeys.lastUser, value: encryptedString);
  }

  @override
  Future<void> deleteLastUser() async {
    await _storage.delete(key: SecureStorageKeys.lastUser);
  }

  @override
  Future<void> writeKey({required loginWithKeyModel}) async {
    final encryptedJson = encryptString(loginWithKeyModel.toJson());

    await _storage.write(
        key: '${loginWithKeyModel.accessKey}-${SecureStorageKeys.key}', value: encryptedJson);
  }

  @override
  Future<void> writeKeyToken({
    required String accessKey,
    required TokenModel token,
  }) async {
    final encryptedJson = encryptString(token.toJson());

    await _storage.write(key: '$accessKey-${SecureStorageKeys.keyToken}', value: encryptedJson);
  }

  @override
  Future<void> writeKeyTokenExpirationDate({
    required String accessKey,
    required DateTime tokenExpirationDate,
  }) async {
    await _storage.write(
        key: '$accessKey-${SecureStorageKeys.keyTokenExpirationDate}',
        value: tokenExpirationDate.toIso8601String());
  }

  @override
  Future<void> writeLastKey({required String accessKey}) async {
    final encryptedString = encryptString(accessKey);
    
    await _storage.write(key: SecureStorageKeys.lastKey, value: encryptedString);
  }

  @override
  Future<void> deleteKey({required String accessKey}) async {
    await _storage.delete(key: '$accessKey-${SecureStorageKeys.key}');
  }

  @override
  Future<void> deleteKeyToken({required String accessKey}) async {
    await _storage.delete(key: '$accessKey-${SecureStorageKeys.keyToken}');
  }

  @override
  Future<void> deleteKeyTokenExpirationDate({required String accessKey}) async {
    await _storage.delete(
        key: '$accessKey-${SecureStorageKeys.keyTokenExpirationDate}');
  }

  @override
  Future<void> deleteLastKey() async {
    await _storage.delete(key: SecureStorageKeys.lastKey);
  }

  @override
  Future<LoginWithKeyModel?> readKey({required String accessKey}) async {
    final jsonStr =
        await _storage.read(key: '$accessKey-${SecureStorageKeys.key}');

    if (jsonStr != null) {
      final decryptedJson = decryptString(jsonStr);
      return LoginWithKeyModel.fromJson(decryptedJson);
    }

    return null;
  }

  @override
  Future<TokenModel?> readKeyToken({required String accessKey}) async {
    final jsonStr =
        await _storage.read(key: '$accessKey-${SecureStorageKeys.keyToken}');

    if (jsonStr != null) {
      final decryptedJson = decryptString(jsonStr);
      return TokenModel.fromJson(decryptedJson);
    }

    return null;
  }

  @override
  Future<DateTime?> readKeyTokenExpirationDate(
      {required String accessKey}) async {
    final jsonStr = await _storage.read(
        key: '$accessKey-${SecureStorageKeys.keyTokenExpirationDate}');

    if (jsonStr != null) {
      return DateTime.tryParse(jsonStr);
    }

    return null;
  }

  @override
  Future<String?> readLastKey() async {
    final jsonStr = await _storage.read(key: SecureStorageKeys.lastKey);

    if (jsonStr != null) {
      final decryptedJson = decryptString(jsonStr);
      return decryptedJson;
    }

    return null;
  }
}
