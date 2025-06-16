import '../../../../core/types/either.dart';
import '../failures/onboarding_failure.dart';

typedef SaveAlreadyViewedOnboardingUsecaseCallback = Future<Either<OnboardingFailure, Unit>>;
typedef SetOnboardingJumpUsecaseCallback = Future<Either<OnboardingFailure, Unit>>;
typedef GetAlreadyViewedOnboardingUsecaseCallback = Future<Either<OnboardingFailure, bool>>;
typedef OpenExternalUrlUsecaseCallback = Future<Either<OnboardingFailure, Unit>>;
