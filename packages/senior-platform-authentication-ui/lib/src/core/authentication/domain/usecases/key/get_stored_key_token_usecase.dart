import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../../data/repositories/secure_storage_repository.dart';

class GetStoredKeyTokenUsecase implements BaseUsecase<Token?, String?> {
  late final SecureStorageRepository _secureStorageRepository;

  GetStoredKeyTokenUsecase({
    SecureStorageRepository? secureStorageRepository,
  }) {
    _secureStorageRepository =
        secureStorageRepository ?? SecureStorageRepositoryImpl();
  }

  @override
  Future<Token?> call(String? accessKey) async {
    final currentAccessKey = accessKey?.isEmpty ?? true
        ? await _secureStorageRepository.readLastKey() ?? ''
        : accessKey!;
    return await _secureStorageRepository.readKeyToken(
        accessKey: currentAccessKey);
  }
}
