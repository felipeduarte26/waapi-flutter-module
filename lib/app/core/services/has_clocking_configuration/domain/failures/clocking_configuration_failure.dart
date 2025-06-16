import '../../../../failures/failure.dart';

abstract class ClockingConfigurationFailure extends Failure {
  const ClockingConfigurationFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class ClockingConfigurationDriverFailure extends ClockingConfigurationFailure {
  const ClockingConfigurationDriverFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
