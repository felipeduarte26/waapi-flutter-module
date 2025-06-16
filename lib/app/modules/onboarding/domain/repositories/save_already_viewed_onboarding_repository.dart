import '../enums/onboarding_view_key_enum.dart';
import '../types/onboarding_domain_types.dart';

abstract class SaveAlreadyViewedOnboardingRepository {
  SaveAlreadyViewedOnboardingUsecaseCallback call({
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
    required bool visualized,
  });
}
