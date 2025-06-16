import '../../../../core/failures/failure.dart';

abstract class FeedbackFailure extends Failure {
  const FeedbackFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class NoPermissionToViewMyFeedbacksFailure extends FeedbackFailure {
  const NoPermissionToViewMyFeedbacksFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class InvalidFeedbackIdFailure extends FeedbackFailure {
  const InvalidFeedbackIdFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class NoPermissionToToggleInternalFeedbackSharingFailure extends FeedbackFailure {
  const NoPermissionToToggleInternalFeedbackSharingFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class FeedbackDatasourceFailure extends FeedbackFailure {
  const FeedbackDatasourceFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class FeedbackProficiencyFailure extends FeedbackFailure {
  const FeedbackProficiencyFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class UserInfoFailure extends FeedbackFailure {
  const UserInfoFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class SendFeedbackRequirementsFailure extends FeedbackFailure {
  const SendFeedbackRequirementsFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class RequestFeedbackDetailsRequirementsFailure extends FeedbackFailure {
  const RequestFeedbackDetailsRequirementsFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class FeedbackNotFoundFailure extends FeedbackFailure {
  const FeedbackNotFoundFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
