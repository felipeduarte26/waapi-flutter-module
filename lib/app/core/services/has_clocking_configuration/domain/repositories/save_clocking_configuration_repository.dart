import '../types/clocking_configuration_domain_types.dart';

abstract class SaveClockingConfigurationRepository {
  SaveClockingConfigurationCallback call({
    required bool? allowGpoOnApp,
    required String key,
  });
}
