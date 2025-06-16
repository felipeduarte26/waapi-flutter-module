import '../../../../core/failures/failure.dart';

abstract class CorporateMuralFailure extends Failure {
  const CorporateMuralFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class CorporateMuralDatasourceFailure extends CorporateMuralFailure {
  const CorporateMuralDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class NoBirthdayEmployeesFoundFailure extends CorporateMuralFailure {
  const NoBirthdayEmployeesFoundFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
