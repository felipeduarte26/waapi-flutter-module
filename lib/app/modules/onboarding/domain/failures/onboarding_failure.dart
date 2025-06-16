import '../../../../core/failures/failure.dart';

abstract class OnboardingFailure extends Failure {
  const OnboardingFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class OnboardingDriverFailure extends OnboardingFailure {
  const OnboardingDriverFailure({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
