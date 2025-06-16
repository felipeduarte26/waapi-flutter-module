import '../../../../core/failures/failure.dart';

abstract class HyperlinkFailure extends Failure {
  const HyperlinkFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class HyperlinkDatasourceFailure extends HyperlinkFailure {
  const HyperlinkDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
