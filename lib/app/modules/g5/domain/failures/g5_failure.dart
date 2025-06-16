import '../../../../core/failures/failure.dart';

abstract class G5Failure extends Failure {
  const G5Failure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class G5DatasourceFailure extends G5Failure {
  const G5DatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
