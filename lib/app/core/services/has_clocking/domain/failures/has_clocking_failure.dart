import '../../../../failures/failure.dart';

abstract class HasClockingFailure extends Failure {
  const HasClockingFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class HasClockingDriverFailure extends HasClockingFailure {
  const HasClockingDriverFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
