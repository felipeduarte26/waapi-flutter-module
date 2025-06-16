import '../../../../core/failures/failure.dart';

abstract class HappinessIndexFailure extends Failure {
  const HappinessIndexFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class HappinessIndexDatasourceFailure extends HappinessIndexFailure {
  const HappinessIndexDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class NoHappinessIndexSelectedFailure extends HappinessIndexFailure {
  const NoHappinessIndexSelectedFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class RetrieveAllReasonsHappinessIndexFailure extends HappinessIndexFailure {
  const RetrieveAllReasonsHappinessIndexFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
