import '../../../../core/failures/failure.dart';

abstract class ActiveContractFailure extends Failure {
  const ActiveContractFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class ActiveContractDatasourceFailure extends ActiveContractFailure {
  const ActiveContractDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class NoActiveContractFoundFailure extends ActiveContractFailure {
  const NoActiveContractFoundFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
