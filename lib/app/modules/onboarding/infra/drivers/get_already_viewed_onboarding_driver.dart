import '../../domain/enums/onboarding_view_key_enum.dart';

abstract class GetAlreadyViewedOnboardingDriver {
  bool call({
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
  });
}
