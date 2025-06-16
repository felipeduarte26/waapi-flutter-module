import '../../../../core/enums/analytics/analytics_event_enum.dart';
import '../enums/onboarding_view_key_enum.dart';
import '../repositories/set_onboarding_jump_repository.dart';
import '../types/onboarding_domain_types.dart';

abstract class SetOnboardingJumpUsecase {
  SetOnboardingJumpUsecaseCallback call({
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
    required int step,
    required Map<String, dynamic>? additionalParameters,
    required AnalyticsEventEnum analyticsEventEnum,
  });
}

class SetOnboardingJumpUsecaseImpl implements SetOnboardingJumpUsecase {
  final SetOnboardingJumpRepository _setOnboardingJumpRepository;

  const SetOnboardingJumpUsecaseImpl({
    required SetOnboardingJumpRepository setOnboardingJumpRepository,
  }) : _setOnboardingJumpRepository = setOnboardingJumpRepository;

  @override
  SetOnboardingJumpUsecaseCallback call({
    required int step,
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
    required Map<String, dynamic>? additionalParameters,
    required AnalyticsEventEnum analyticsEventEnum,
  }) {
    return _setOnboardingJumpRepository.call(
      step: step,
      onboardingViewKeyEnum: onboardingViewKeyEnum,
      additionalParameters: additionalParameters,
      analyticsEventEnum: analyticsEventEnum,
    );
  }
}
