import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../data/repositories/secure_storage_repository.dart';
import '../entities/user_name.dart';

/// Clear all local storage data on device.
///
/// This usecase clears user and token data.
class ClearStoredDataUsecase implements BaseUsecase<void, UserName> {
  late final SecureStorageRepository _secureStorageRepository;

  ClearStoredDataUsecase({
    SecureStorageRepository? secureStorageRepository,
  }) {
    _secureStorageRepository =
        secureStorageRepository ?? SecureStorageRepositoryImpl();
  }

  @override
  Future<void> call(UserName username, {bool onlyLastUser = false}) async {
    if (!onlyLastUser) {
      final currentUsername = username.currentUsername ?? '';

      await _secureStorageRepository.deleteUser(username: currentUsername);
      await _secureStorageRepository.deleteToken(username: currentUsername);
      await _secureStorageRepository.deleteTokenExpirationDate(
          username: currentUsername);
    }
    await _secureStorageRepository.deleteLastUser();
  }
}
