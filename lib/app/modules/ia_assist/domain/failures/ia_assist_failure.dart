import '../../../../core/failures/failure.dart';

abstract class IAAssistFailure extends Failure {
  const IAAssistFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class IAAssistDatasourceFailure extends IAAssistFailure {
  const IAAssistDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
