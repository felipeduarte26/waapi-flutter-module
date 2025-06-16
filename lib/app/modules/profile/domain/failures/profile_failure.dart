import '../../../../core/failures/failure.dart';

abstract class ProfileFailure extends Failure {
  const ProfileFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class ProfileDatasourceFailure extends ProfileFailure {
  const ProfileDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class SendEmergencialContactDatasourceFailure extends ProfileFailure {
  const SendEmergencialContactDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class SendUpdateEmergencialContactDatasourceFailure extends ProfileFailure {
  const SendUpdateEmergencialContactDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class SendDeletionEmergencialContactDatasourceFailure extends ProfileFailure {
  const SendDeletionEmergencialContactDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class UpdateDependentsDatasourceFailure extends ProfileFailure {
  const UpdateDependentsDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
