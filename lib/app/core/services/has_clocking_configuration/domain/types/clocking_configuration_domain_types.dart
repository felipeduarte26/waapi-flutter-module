import '../../../../types/either.dart';
import '../failures/clocking_configuration_failure.dart';

typedef GetClockingConfigurationCallback = Future<Either<ClockingConfigurationFailure, bool>>;
typedef SaveClockingConfigurationCallback = Future<Either<ClockingConfigurationFailure, Unit>>;
