import '../../../../core/failures/failure.dart';

abstract class SearchPersonFailure extends Failure {
  const SearchPersonFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class SearchPersonDatasourceFailure extends SearchPersonFailure {
  const SearchPersonDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
