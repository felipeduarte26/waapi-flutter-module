import '../../../../core/enums/analytics/analytics_event_enum.dart';

import '../../../../core/types/either.dart';
import '../../domain/enums/onboarding_view_key_enum.dart';
import '../../domain/failures/onboarding_failure.dart';
import '../../domain/repositories/set_onboarding_jump_repository.dart';
import '../../domain/types/onboarding_domain_types.dart';
import '../drivers/save_already_viewed_onboarding_driver.dart';

class SetOnboardingJumpRepositoryImpl implements SetOnboardingJumpRepository {
  final SaveAlreadyViewedOnboardingDriver _saveAlreadyViewedOnboardingDriver;

  const SetOnboardingJumpRepositoryImpl({
    required SaveAlreadyViewedOnboardingDriver saveAlreadyViewedOnboardingDriver,
  }) : _saveAlreadyViewedOnboardingDriver = saveAlreadyViewedOnboardingDriver;

  @override
  SetOnboardingJumpUsecaseCallback call({
    required int step,
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
    required Map<String, dynamic>? additionalParameters,
    required AnalyticsEventEnum analyticsEventEnum,
  }) async {
    try {
      final parameters = <String, dynamic>{
        'step': step.toString(),
      };

      if (additionalParameters != null) {
        parameters.addAll(additionalParameters);
      }

      final isSaved = await _saveAlreadyViewedOnboardingDriver.call(
        onboardingViewKeyEnum: onboardingViewKeyEnum,
        visualized: true,
      );

      if (isSaved) {
        return right(unit);
      }

      return left(const OnboardingDriverFailure());
    } catch (error) {
      return left(const OnboardingDriverFailure());
    }
  }
}
