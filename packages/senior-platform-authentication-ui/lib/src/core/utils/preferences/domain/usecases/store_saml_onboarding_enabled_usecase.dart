import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../data/repositories/preferences_storage_repository.dart';

class StoreSAMLOnboardingEnabledUsecase implements BaseUsecase<void, bool> {
  late final PreferencesStorageRepository _preferencesStorageRepository;

  StoreSAMLOnboardingEnabledUsecase({
    PreferencesStorageRepository? preferencesStorageRepository,
  }) {
    _preferencesStorageRepository =
        preferencesStorageRepository ?? PreferencesStorageRepositoryImpl();
  }

  @override
  Future<void> call(bool value) async {
    return await _preferencesStorageRepository
        .writeSAMLOnboardingEnabled(value);
  }
}
