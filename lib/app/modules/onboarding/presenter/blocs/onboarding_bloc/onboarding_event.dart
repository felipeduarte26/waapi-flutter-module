import 'package:equatable/equatable.dart';

import '../../../../../core/enums/analytics/analytics_event_enum.dart';
import '../../../domain/enums/onboarding_view_key_enum.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props {
    return [];
  }
}

class SaveAlreadyViewedOnboardingEvent extends OnboardingEvent {
  final OnboardingViewKeyEnum onboardingViewKeyEnum;
  final bool visualized;

  const SaveAlreadyViewedOnboardingEvent({
    required this.onboardingViewKeyEnum,
    required this.visualized,
  });

  @override
  List<Object> get props {
    return [
      onboardingViewKeyEnum,
      visualized,
    ];
  }
}

class GetAlreadyViewedOnboardingEvent extends OnboardingEvent {
  final OnboardingViewKeyEnum onboardingViewKeyEnum;
  final bool isReview;

  const GetAlreadyViewedOnboardingEvent({
    required this.onboardingViewKeyEnum,
    required this.isReview,
  });

  @override
  List<Object> get props {
    return [
      onboardingViewKeyEnum,
      isReview,
    ];
  }
}

class SetOnboardingJumpEvent extends OnboardingEvent {
  final int step;
  final OnboardingViewKeyEnum onboardingViewKeyEnum;
  final Map<String, dynamic>? additionalParameters;
  final AnalyticsEventEnum analyticsEventEnum;

  const SetOnboardingJumpEvent({
    required this.step,
    required this.onboardingViewKeyEnum,
    this.additionalParameters,
    required this.analyticsEventEnum,
  });

  @override
  List<Object?> get props {
    return [
      step,
      onboardingViewKeyEnum,
      additionalParameters,
      analyticsEventEnum,
    ];
  }
}

class NextPageOnboardingEvent extends OnboardingEvent {
  final int step;
  final AnalyticsEventEnum analyticsEventEnum;
  final int maxSteps;
  final Map<String, dynamic>? additionalParameters;

  const NextPageOnboardingEvent({
    required this.step,
    required this.analyticsEventEnum,
    required this.maxSteps,
    this.additionalParameters,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      step,
      analyticsEventEnum,
      maxSteps,
      additionalParameters,
    ];
  }
}

class OpenExternalUrlEvent extends OnboardingEvent {
  final String externalUrl;

  const OpenExternalUrlEvent({
    required this.externalUrl,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      externalUrl,
    ];
  }
}
