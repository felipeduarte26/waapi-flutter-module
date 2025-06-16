import 'package:senior_platform_authentication/senior_platform_authentication.dart';
import '../../../data/repositories/secure_storage_repository.dart';
import '../../entities/key_authentication_data.dart';

class StoreKeyAuthenticationDataUsecase
    implements BaseUsecase<bool, KeyAuthenticationData> {
  late final SecureStorageRepository _secureStorageRepository;

  StoreKeyAuthenticationDataUsecase({
    SecureStorageRepository? secureStorageRepository,
  }) {
    _secureStorageRepository =
        secureStorageRepository ?? SecureStorageRepositoryImpl();
  }

  @override
  Future<bool> call(KeyAuthenticationData appData) async {
    try {
      if (appData.loginWithKey != null && appData.token != null) {
        final now = DateTime.now();
        final tokenExpirationDate =
            now.add(Duration(seconds: appData.token!.expiresIn));

        await _secureStorageRepository.writeKey(
          loginWithKey: appData.loginWithKey!,
        );

        await _secureStorageRepository.writeKeyToken(
          accessKey: appData.loginWithKey!.accessKey,
          token: appData.token!,
        );

        await _secureStorageRepository.writeKeyTokenExpirationDate(
          accessKey: appData.loginWithKey!.accessKey,
          tokenExpirationDate: tokenExpirationDate,
        );

        await _secureStorageRepository
            .writeLastKey(appData.loginWithKey!.accessKey);

        return true;
      }

      return false;
    } catch (_) {
      return false;
    }
  }
}
