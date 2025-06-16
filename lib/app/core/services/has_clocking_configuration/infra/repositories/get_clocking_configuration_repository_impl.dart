import '../../../../types/either.dart';

import '../../domain/failures/clocking_configuration_failure.dart';
import '../../domain/repositories/get_clocking_configuration_repository.dart';
import '../../domain/types/clocking_configuration_domain_types.dart';
import '../drivers/get_clocking_configuration_driver.dart';

class GetClockingConfigurationRepositoryImpl implements GetClockingConfigurationRepository {
  final GetClockingConfigurationDriver _getClockingConfigurationDriver;

  const GetClockingConfigurationRepositoryImpl({
    required GetClockingConfigurationDriver getClockingConfigurationDriver,
  }) : _getClockingConfigurationDriver = getClockingConfigurationDriver;

  @override
  GetClockingConfigurationCallback call({
    required String key,
  }) async {
    try {
      final allowGpoOnApp = _getClockingConfigurationDriver.call(key: key) ?? false;
      return right(allowGpoOnApp);
    } catch (error) {
      return left(const ClockingConfigurationDriverFailure());
    }
  }
}
