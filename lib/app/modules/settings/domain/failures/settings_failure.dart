import '../../../../core/failures/failure.dart';

abstract class SettingsFailure extends Failure {
  const SettingsFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class SettingsDriverFailure extends SettingsFailure {
  const SettingsDriverFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
