import '../../../../core/failures/failure.dart';

abstract class NotificationFailure extends Failure {
  const NotificationFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class NotificationDriverFailure extends NotificationFailure {
  const NotificationDriverFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class NotificationFirebaseFailure extends NotificationFailure {
  const NotificationFirebaseFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class NotificationDatasourceFailure extends NotificationFailure {
  const NotificationDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class MarkNotificationAsReadRequirementsFailure extends NotificationFailure {
  const MarkNotificationAsReadRequirementsFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
