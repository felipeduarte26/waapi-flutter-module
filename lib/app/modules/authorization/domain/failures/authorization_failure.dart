import '../../../../core/failures/failure.dart';

abstract class AuthorizationFailure extends Failure {
  const AuthorizationFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class UnknownAuthorizationFailure extends AuthorizationFailure {
  const UnknownAuthorizationFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
