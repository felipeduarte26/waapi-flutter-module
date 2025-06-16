import '../repositories/get_clocking_configuration_repository.dart';
import '../types/clocking_configuration_domain_types.dart';

abstract class GetClockingConfigurationUsecase {
  GetClockingConfigurationCallback call({required String key});
}

class GetClockingConfigurationUsecaseImpl implements GetClockingConfigurationUsecase {
  final GetClockingConfigurationRepository _getClockingConfigurationRepository;

  const GetClockingConfigurationUsecaseImpl({
    required GetClockingConfigurationRepository getClockingConfigurationRepository,
  }) : _getClockingConfigurationRepository = getClockingConfigurationRepository;

  @override
  GetClockingConfigurationCallback call({required String key}) {
    return _getClockingConfigurationRepository.call(key: key);
  }
}
