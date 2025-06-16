import 'dart:developer';

import '../../../../../../senior_platform_authentication_ui.dart';
import '../../entities/key_authentication_data.dart';

class RefreshKeyStoredTokenUsecase implements BaseUsecase<Token?, String?> {
  late final SecureStorageRepository _secureStorageRepository;
  late final RefreshTokenUsecase _refreshTokenUsecase;
  late final StoreKeyAuthenticationDataUsecase
      _storeKeyAuthenticationDataUsecase;
  late final ClearKeyStoredDataUsecase _clearKeyStoredDataUsecase;
  late final AuthenticateKeyUsecase _authenticateKeyUsecase;

  RefreshKeyStoredTokenUsecase({
    SecureStorageRepository? secureStorageRepository,
    RefreshTokenUsecase? refreshTokenUsecase,
    GetUserUsecase? getUserUsecase,
    StoreKeyAuthenticationDataUsecase? storeAuthenticationDataUsecase,
    ClearKeyStoredDataUsecase? clearKeyStoredDataUsecase,
    AuthenticateKeyUsecase? authenticateKeyUsecase,
  }) {
    _secureStorageRepository =
        secureStorageRepository ?? SecureStorageRepositoryImpl();
    _refreshTokenUsecase = refreshTokenUsecase ?? RefreshTokenUsecase();
    _storeKeyAuthenticationDataUsecase =
        storeAuthenticationDataUsecase ?? StoreKeyAuthenticationDataUsecase();
    _clearKeyStoredDataUsecase =
        clearKeyStoredDataUsecase ?? ClearKeyStoredDataUsecase();
    _authenticateKeyUsecase =
        authenticateKeyUsecase ?? AuthenticateKeyUsecase();
  }

  @override
  Future<Token?> call([String? accessKey]) async {
    String? currentAccessKey = accessKey?.isEmpty ?? true
        ? await _secureStorageRepository.readLastKey() ?? ''
        : accessKey;

    if (currentAccessKey == null) return null;

    try {
      var storedToken = await _secureStorageRepository.readKeyToken(
          accessKey: currentAccessKey);
      final storedKey =
          await _secureStorageRepository.readKey(accessKey: currentAccessKey);

      final tenant = storedKey?.tenantName ?? '';

      // Invalid token
      if ((storedToken?.refreshToken.isEmpty ?? true) ||
          (storedToken?.accessToken.isEmpty ?? true)) {
        await _clearKeyStoredDataUsecase(currentAccessKey);
        return null;
      }

      final refreshToken = RefreshToken(
        token: storedToken!.refreshToken,
        scope: '',
        tenant: tenant,
      );

      final refreshResponse = await _refreshTokenUsecase(refreshToken);

      bool stored = false;

      if (refreshResponse.token == null) {
        final authenticationResponse =
            await _authenticateKeyUsecase.call(currentAccessKey);
        if (authenticationResponse != null &&
            authenticationResponse.token != null) {
          stored = true;
        }
      } else {
        stored = await _storeKeyAuthenticationDataUsecase.call(
          KeyAuthenticationData(
            loginWithKey: storedKey,
            token: refreshResponse.token,
          ),
        );

        if (!stored) {
          await _clearKeyStoredDataUsecase.call(currentAccessKey);
          return null;
        }
      }

      return refreshResponse.token;
    } catch (e) {
      log('REFRESH KEY TOKEN ERROR >>>> ${e.toString()}');
      await _clearKeyStoredDataUsecase.call(currentAccessKey);
      return null;
    }
  }
}
