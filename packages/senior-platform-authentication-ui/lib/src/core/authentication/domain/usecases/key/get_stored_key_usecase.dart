import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../../data/repositories/secure_storage_repository.dart';

class GetStoredKeyUsecase implements BaseUsecase<ApplicationKey?, String?> {
  late final SecureStorageRepository _secureStorageRepository;

  GetStoredKeyUsecase({
    SecureStorageRepository? secureStorageRepository,
  }) {
    _secureStorageRepository =
        secureStorageRepository ?? SecureStorageRepositoryImpl();
  }

  @override
  Future<ApplicationKey?> call(String? accessKey) async {
    final currentAccessKey = accessKey?.isEmpty ?? true
        ? await _secureStorageRepository.readLastKey() ?? ''
        : accessKey!;

    LoginWithKey? key = await _secureStorageRepository.readKey(
      accessKey: currentAccessKey,
    );

    if (key == null) {
      return null;
    } else {
      return ApplicationKey(
        accessKey: key.accessKey,
        tenantName: key.tenantName,
      );
    }
  }
}
