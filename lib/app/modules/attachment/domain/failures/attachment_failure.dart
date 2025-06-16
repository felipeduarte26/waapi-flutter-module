import '../../../../core/failures/failure.dart';

abstract class AttachmentFailure extends Failure {
  const AttachmentFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class AttachmentDatasourceFailure extends AttachmentFailure {
  const AttachmentDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class AttachmentUploadFailure extends AttachmentFailure {
  const AttachmentUploadFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class AttachmentDeleteFailure extends AttachmentFailure {
  const AttachmentDeleteFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class AttachmentDriverFailure extends AttachmentFailure {
  const AttachmentDriverFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
