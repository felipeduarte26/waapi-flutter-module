import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../data/repositories/secure_storage_repository.dart';
import '../entities/authentication_data.dart';

/// Stores authentication data into local storage.
class StoreAuthenticationDataUsecase
    implements BaseUsecase<bool, AuthenticationData> {
  late final SecureStorageRepository _secureStorageRepository;

  StoreAuthenticationDataUsecase({
    SecureStorageRepository? secureStorageRepository,
  }) {
    _secureStorageRepository =
        secureStorageRepository ?? SecureStorageRepositoryImpl();
  }

  @override
  Future<bool> call(AuthenticationData authenticationData) async {
    try {
      if (authenticationData.user != null && authenticationData.token != null) {
        final now = DateTime.now();
        final tokenExpirationDate =
            now.add(Duration(seconds: authenticationData.token!.expiresIn));

        await _secureStorageRepository.writeUser(authenticationData.user!);
        await _secureStorageRepository.writeToken(authenticationData.token!);
        await _secureStorageRepository.writeTokenExpirationDate(
          authenticationData.user!.username,
          authenticationData.user!.tenantDomain,
          tokenExpirationDate,
        );
        await _secureStorageRepository.writeLastUser(
          authenticationData.user!.username,
          authenticationData.user!.tenantDomain,
        );

        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
