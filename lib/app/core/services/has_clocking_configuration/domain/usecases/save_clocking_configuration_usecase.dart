import '../repositories/save_clocking_configuration_repository.dart';
import '../types/clocking_configuration_domain_types.dart';

abstract class SaveClockingConfigurationUsecase {
  SaveClockingConfigurationCallback call({required bool? allowGpoOnApp, required String key});
}

class SaveClockingConfigurationUsecaseImpl implements SaveClockingConfigurationUsecase {
  final SaveClockingConfigurationRepository _saveClockingConfigurationRepository;

  const SaveClockingConfigurationUsecaseImpl({
    required SaveClockingConfigurationRepository saveClockingConfigurationRepository,
  }) : _saveClockingConfigurationRepository = saveClockingConfigurationRepository;

  @override
  SaveClockingConfigurationCallback call({
    required bool? allowGpoOnApp,
    required String key,
  }) {
    return _saveClockingConfigurationRepository.call(
      allowGpoOnApp: allowGpoOnApp,
      key: key,
    );
  }
}
