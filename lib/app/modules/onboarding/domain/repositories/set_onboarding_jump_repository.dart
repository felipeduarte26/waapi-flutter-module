import '../../../../core/enums/analytics/analytics_event_enum.dart';
import '../enums/onboarding_view_key_enum.dart';
import '../types/onboarding_domain_types.dart';

abstract class SetOnboardingJumpRepository {
  SetOnboardingJumpUsecaseCallback call({
    required int step,
    required OnboardingViewKeyEnum onboardingViewKeyEnum,
    required Map<String, dynamic>? additionalParameters,
    required AnalyticsEventEnum analyticsEventEnum,
  });
}
