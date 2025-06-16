import '../enums/onboarding_view_key_enum.dart';
import '../types/onboarding_domain_types.dart';

abstract class GetAlreadyViewedOnboardingRepository {
  GetAlreadyViewedOnboardingUsecaseCallback call({
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
  });
}
