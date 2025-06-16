import '../types/clocking_configuration_domain_types.dart';

abstract class GetClockingConfigurationRepository {
  GetClockingConfigurationCallback call({
    required String key,
  });
}
