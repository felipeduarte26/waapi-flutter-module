import '../entities/configuration.dart';
import '../repositories/database/iconfiguration_repository.dart';

abstract class GetAllowGpoOnAppUsecase {
  Future<bool> call({required String username});
}

class GetAllowGpoOnAppUsecaseimpl implements GetAllowGpoOnAppUsecase {
  final IConfigurationRepository _configurationRepository;

  const GetAllowGpoOnAppUsecaseimpl({
    required IConfigurationRepository configurationRepository,
  }) : _configurationRepository = configurationRepository;

  @override
  Future<bool> call({required String username}) async {
    Configuration? entity =
        await _configurationRepository.findByUsername(username: username);

    return entity != null &&
        entity.allowGpoOnApp != null &&
        entity.allowGpoOnApp!;
  }
}
