import '../../../../types/either.dart';

import '../../domain/failures/clocking_configuration_failure.dart';
import '../../domain/repositories/save_clocking_configuration_repository.dart';
import '../../domain/types/clocking_configuration_domain_types.dart';
import '../drivers/save_clocking_configuration_driver.dart';

class SaveClockingConfigurationRepositoryImpl implements SaveClockingConfigurationRepository {
  final SaveClockingConfigurationDriver _saveClockingConfigurationDriver;

  const SaveClockingConfigurationRepositoryImpl({
    required SaveClockingConfigurationDriver saveClockingConfigurationDriver,
  }) : _saveClockingConfigurationDriver = saveClockingConfigurationDriver;

  @override
  SaveClockingConfigurationCallback call({
    required bool? allowGpoOnApp,
    required String key,
  }) async {
    try {
      await _saveClockingConfigurationDriver.call(
        allowGpoOnApp: allowGpoOnApp,
        key: key,
      );
      return right(unit);
    } catch (error) {
      return left(const ClockingConfigurationDriverFailure());
    }
  }
}
