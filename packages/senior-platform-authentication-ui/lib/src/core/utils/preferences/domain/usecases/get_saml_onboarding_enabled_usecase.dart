import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../data/repositories/preferences_storage_repository.dart';

class GetSAMLOnboardingEnabledUsecase implements BaseUsecase<bool, NoParams> {
  late final PreferencesStorageRepository _preferencesStorageRepository;

  GetSAMLOnboardingEnabledUsecase({
    PreferencesStorageRepository? preferencesStorageRepository,
  }) {
    _preferencesStorageRepository =
        preferencesStorageRepository ?? PreferencesStorageRepositoryImpl();
  }

  @override
  Future<bool> call(NoParams params) async {
    return await _preferencesStorageRepository.readSAMLOnboardingEnabled();
  }
}
