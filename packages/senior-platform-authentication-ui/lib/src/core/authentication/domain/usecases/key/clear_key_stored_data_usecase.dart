import 'package:senior_platform_authentication/senior_platform_authentication.dart';
import '../../../data/repositories/secure_storage_repository.dart';

class ClearKeyStoredDataUsecase implements BaseUsecase<void, String?> {
  late final SecureStorageRepository _secureStorageRepository;

  ClearKeyStoredDataUsecase({
    SecureStorageRepository? secureStorageRepository,
  }) {
    _secureStorageRepository =
        secureStorageRepository ?? SecureStorageRepositoryImpl();
  }

  @override
  Future<void> call(String? accessKey) async {
    final currentAccessKey = accessKey ?? '';

    await _secureStorageRepository.deleteKey(accessKey: currentAccessKey);
    await _secureStorageRepository.deleteKeyToken(accessKey: currentAccessKey);
    await _secureStorageRepository.deleteKeyTokenExpirationDate(
        accessKey: currentAccessKey);
    await _secureStorageRepository.deleteLastKey();
  }
}
