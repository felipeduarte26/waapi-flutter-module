import '../../domain/enums/onboarding_view_key_enum.dart';

abstract class SaveAlreadyViewedOnboardingDriver {
  Future<bool> call({
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
    required bool visualized,
  });
}
