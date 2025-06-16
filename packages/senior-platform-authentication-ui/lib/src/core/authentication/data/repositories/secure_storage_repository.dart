import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../datasources/secure_storage_local_datasource.dart';

abstract class SecureStorageRepository {
  Future<void> deleteUser({required String username});
  Future<void> deleteToken({required String username});
  Future<void> deleteTokenExpirationDate({required String username});
  Future<void> deleteLastUser();
  Future<User?> readUser({required String username});
  Future<Token?> readToken({required String username});
  Future<DateTime?> readTokenExpirationDate({required String username});
  Future<String?> readLastUser();
  Future<void> writeUser(User user);
  Future<void> writeToken(Token user);
  Future<void> writeTokenExpirationDate(String username, String tenantDomain, DateTime tokenExpirationDate);
  Future<void> writeLastUser(String username, String tenantDomain);
  // Key
  Future<void> writeKey({required LoginWithKey loginWithKey});
  Future<void> writeKeyToken({required String accessKey, required Token token});
  Future<void> writeKeyTokenExpirationDate({
    required String accessKey,
    required DateTime tokenExpirationDate,
  });

  Future<LoginWithKey?> readKey({required String accessKey});
  Future<Token?> readKeyToken({required String accessKey});
  Future<DateTime?> readKeyTokenExpirationDate({required String accessKey});
  Future<String?> readLastKey();
  Future<void> deleteKey({required String accessKey});
  Future<void> deleteKeyToken({required String accessKey});
  Future<void> deleteKeyTokenExpirationDate({required String accessKey});
  Future<void> deleteLastKey();
  Future<void> writeLastKey(String accessKey);
}

class SecureStorageRepositoryImpl implements SecureStorageRepository {
  late final SecureStorageDatasource _datasource;

  SecureStorageRepositoryImpl({
    SecureStorageDatasource? datasource,
  }) {
    _datasource = datasource ?? SecureStorageLocalDatasource();
  }

  @override
  Future<User?> readUser({required String username}) async {
    final userModel = await _datasource.readUser(
      username: username.toLowerCase(),
    );

    if (userModel != null) {
      return User(
        changePassword: userModel.changePassword,
        admin: userModel.admin,
        allowedToChangePassword: userModel.allowedToChangePassword,
        id: userModel.id,
        username: userModel.username.toLowerCase(),
        fullName: userModel.fullName,
        email: userModel.email?.toLowerCase(),
        tenantDomain: userModel.tenantDomain,
        tenantName: userModel.tenantName,
        tenantLocale: userModel.tenantLocale,
        blocked: userModel.blocked,
        properties: userModel.properties,
        photoUrl: userModel.photoUrl,
        activeBiometry: userModel.activeBiometry,
        integration: userModel.integration != null ? Integration(integrationName: userModel.integration!.integrationName) : null,
      );
    }

    return null;
  }

  @override
  Future<Token?> readToken({required String username}) async {
    final tokenModel = await _datasource.readToken(
      username: username.toLowerCase(),
    );

    if (tokenModel != null) {
      return Token(
        version: tokenModel.version,
        expiresIn: tokenModel.expires_in,
        username: tokenModel.username?.toLowerCase(),
        tokenType: tokenModel.token_type,
        accessToken: tokenModel.access_token,
        refreshToken: tokenModel.refresh_token,
        type: tokenModel.type,
        email: tokenModel.email?.toLowerCase(),
        fullName: tokenModel.fullName,
        tenantName: tokenModel.tenantName,
        locale: tokenModel.locale,
        hash: tokenModel.hash,
        salt: tokenModel.salt,
      );
    }

    return null;
  }

  @override
  Future<DateTime?> readTokenExpirationDate({required String username}) async {
    return await _datasource.readTokenExpirationDate(
      username: username.toLowerCase(),
    );
  }

  @override
  Future<void> writeUser(User user) async {
    final userModel = UserModel(
      changePassword: user.changePassword,
      admin: user.admin,
      allowedToChangePassword: user.allowedToChangePassword,
      id: user.id,
      username: user.username.toLowerCase(),
      fullName: user.fullName,
      email: user.email?.toLowerCase(),
      tenantDomain: user.tenantDomain,
      tenantName: user.tenantName,
      tenantLocale: user.tenantLocale,
      blocked: user.blocked,
      properties: user.properties,
      photoUrl: user.photoUrl,
      activeBiometry: user.activeBiometry,
      integration: user.integration != null ? IntegrationModel(integrationName: user.integration?.integrationName) : null,
    );

    await _datasource.writeUser(userModel);
  }

  @override
  Future<void> writeToken(Token token) async {
    final tokenModel = TokenModel(
      version: token.version,
      expires_in: token.expiresIn,
      username: token.username?.toLowerCase(),
      token_type: token.tokenType,
      access_token: token.accessToken,
      refresh_token: token.refreshToken,
      type: token.type,
      email: token.email?.toLowerCase(),
      fullName: token.fullName,
      tenantName: token.tenantName,
      locale: token.locale,
      hash: token.hash,
      salt: token.salt,
    );

    await _datasource.writeToken(tokenModel);
  }

  @override
  Future<void> writeTokenExpirationDate(String username, String tenantDomain, DateTime tokenExpirationDate) async {
    await _datasource.writeTokenExpirationDate(username.toLowerCase(), tenantDomain, tokenExpirationDate);
  }

  @override
  Future<void> deleteUser({required String username}) async {
    await _datasource.deleteUser(username: username.toLowerCase());
  }

  @override
  Future<void> deleteToken({required String username}) async {
    await _datasource.deleteToken(username: username.toLowerCase());
  }

  @override
  Future<void> deleteTokenExpirationDate({required String username}) async {
    await _datasource.deleteTokenExpirationDate(username: username.toLowerCase());
  }

  @override
  Future<String?> readLastUser() async {
    if (SeniorAuthentication.automaticLogon) {
      return await _datasource.readLastUser();
    }
    return null;
  }

  @override
  Future<void> writeLastUser(String username, String tenantDomain) async {
    await _datasource.writeLastUser(username.toLowerCase(), tenantDomain);
  }

  @override
  Future<void> deleteLastUser() async {
    await _datasource.deleteLastUser();
  }

  // Key
  @override
  Future<void> writeKey({
    required LoginWithKey loginWithKey,
  }) async {
    final loginWithKeyModel = LoginWithKeyModel(
      accessKey: loginWithKey.accessKey,
      secret: loginWithKey.secret,
      tenantName: loginWithKey.tenantName,
    );

    await _datasource.writeKey(
      loginWithKeyModel: loginWithKeyModel,
    );
  }

  @override
  Future<void> writeKeyToken(
      {required String accessKey, required Token token}) async {
    final tokenModel = TokenModel(
      version: token.version,
      expires_in: token.expiresIn,
      username: token.username,
      token_type: token.tokenType,
      access_token: token.accessToken,
      refresh_token: token.refreshToken,
      type: token.type,
      email: token.email,
      fullName: token.fullName,
      tenantName: token.tenantName,
      locale: token.locale,
      hash: token.hash,
      salt: token.salt,
    );

    await _datasource.writeKeyToken(
      accessKey: accessKey,
      token: tokenModel,
    );
  }

  @override
  Future<void> writeKeyTokenExpirationDate({
    required String accessKey,
    required DateTime tokenExpirationDate,
  }) async {
    await _datasource.writeKeyTokenExpirationDate(
      accessKey: accessKey,
      tokenExpirationDate: tokenExpirationDate,
    );
  }

  @override
  Future<void> writeLastKey(String accessKey) async {
    await _datasource.writeLastKey(accessKey: accessKey);
  }

  @override
  Future<LoginWithKey?> readKey({required String accessKey}) async {
    final loginWithKeyModel = await _datasource.readKey(
      accessKey: accessKey,
    );

    if (loginWithKeyModel != null) {
      return LoginWithKey(
        accessKey: loginWithKeyModel.accessKey,
        secret: loginWithKeyModel.secret,
        tenantName: loginWithKeyModel.tenantName,
      );
    }

    return null;
  }

  @override
  Future<Token?> readKeyToken({required String accessKey}) async {
    final tokenModel = await _datasource.readKeyToken(
      accessKey: accessKey,
    );

    if (tokenModel != null) {
      return Token(
        version: tokenModel.version,
        expiresIn: tokenModel.expires_in,
        username: tokenModel.username,
        tokenType: tokenModel.token_type,
        accessToken: tokenModel.access_token,
        refreshToken: tokenModel.refresh_token,
        type: tokenModel.type,
        email: tokenModel.email,
        fullName: tokenModel.fullName,
        tenantName: tokenModel.tenantName,
        locale: tokenModel.locale,
        hash: tokenModel.hash,
        salt: tokenModel.salt,
      );
    }

    return null;
  }

  @override
  Future<DateTime?> readKeyTokenExpirationDate(
      {required String accessKey}) async {
    return await _datasource.readKeyTokenExpirationDate(
      accessKey: accessKey,
    );
  }

  @override
  Future<String?> readLastKey() async {
    if (SeniorAuthentication.automaticLogon) {
      return await _datasource.readLastKey();
    }
    return null;
  }

  @override
  Future<void> deleteKey({required String accessKey}) async {
    await _datasource.deleteKey(accessKey: accessKey);
  }

  @override
  Future<void> deleteKeyToken({required String accessKey}) async {
    await _datasource.deleteKeyToken(accessKey: accessKey);
  }

  @override
  Future<void> deleteKeyTokenExpirationDate({required String accessKey}) async {
    await _datasource.deleteKeyTokenExpirationDate(
      accessKey: accessKey,
    );
  }

  @override
  Future<void> deleteLastKey() async {
    await _datasource.deleteLastKey();
  }
}
