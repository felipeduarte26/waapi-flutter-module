import 'dart:developer';

import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../data/repositories/secure_storage_repository.dart';
import '../entities/authentication_data.dart';
import '../entities/user_name.dart';
import 'clear_stored_data_usecase.dart';
import 'store_authentication_data_usecase.dart';

/// Refresh current token that is stored on local storage.
///
/// Updates token and user data. If it fails, clear all storage on device to
/// unauthenticate the current user.
class RefreshStoredTokenUsecase implements BaseUsecase<Token?, UserName> {
  late final SecureStorageRepository _secureStorageRepository;
  late final RefreshTokenUsecase _refreshTokenUsecase;
  late final GetUserUsecase _getUserUsecase;
  late final StoreAuthenticationDataUsecase _storeAuthenticationDataUsecase;
  late final ClearStoredDataUsecase _clearStoredDataUsecase;

  RefreshStoredTokenUsecase({
    SecureStorageRepository? secureStorageRepository,
    RefreshTokenUsecase? refreshTokenUsecase,
    GetUserUsecase? getUserUsecase,
    StoreAuthenticationDataUsecase? storeAuthenticationDataUsecase,
    ClearStoredDataUsecase? clearStoredDataUsecase,
  }) {
    _secureStorageRepository =
        secureStorageRepository ?? SecureStorageRepositoryImpl();
    _refreshTokenUsecase = refreshTokenUsecase ?? RefreshTokenUsecase();
    _getUserUsecase = getUserUsecase ?? GetUserUsecase();
    _storeAuthenticationDataUsecase =
        storeAuthenticationDataUsecase ?? StoreAuthenticationDataUsecase();
    _clearStoredDataUsecase =
        clearStoredDataUsecase ?? ClearStoredDataUsecase();
  }

  @override
  Future<Token?> call(UserName username) async {
    final currentUsername = username.currentUsername?.isEmpty ?? true
        ? await _secureStorageRepository.readLastUser() ?? ''
        : username.currentUsername!;
    try {
      var storedToken =
          await _secureStorageRepository.readToken(username: currentUsername);
      final storedUser =
          await _secureStorageRepository.readUser(username: currentUsername);
      final tenant = storedUser?.tenantName ?? '';

      // Invalid token
      if ((storedToken?.refreshToken.isEmpty ?? true) ||
          (storedToken?.accessToken.isEmpty ?? true)) {
        await _clearStoredDataUsecase(username);
        return null;
      }

      final refreshToken = RefreshToken(
        token: storedToken!.refreshToken,
        scope: '',
        tenant: tenant,
      );

      final authenticationResponse = await _refreshTokenUsecase(refreshToken);

      bool stored = false;
      if (authenticationResponse.token != null) {
        final refreshedUser = await _getUserUsecase(
          GetUserInput(
            accessToken: authenticationResponse.token!.accessToken,
            includePhoto: SeniorAuthentication.includePhoto,
          ),
        );

        final refreshedUserUpdated = refreshedUser.copyWith(
            activeBiometry: storedUser?.activeBiometry ?? false);

        stored = await _storeAuthenticationDataUsecase(
          AuthenticationData(
            user: refreshedUserUpdated,
            token: authenticationResponse.token,
          ),
        );
      }

      if (!stored) {
        await _clearStoredDataUsecase(username);
        return null;
      }

      return authenticationResponse.token;
    } catch (e) {
      log('REFRESH TOKEN ERROR >>>> ${e.toString()}');
      await _clearStoredDataUsecase(username);
      return null;
    }
  }
}
