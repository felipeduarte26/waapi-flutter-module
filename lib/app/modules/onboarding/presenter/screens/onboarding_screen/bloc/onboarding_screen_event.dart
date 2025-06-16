import 'package:equatable/equatable.dart';

import '../../../blocs/onboarding_bloc/onboarding_state.dart';

abstract class OnboardingScreenEvent extends Equatable {}

class ChangeOnboardingScreenEvent extends OnboardingScreenEvent {
  final OnboardingState onboardingState;

  ChangeOnboardingScreenEvent({
    required this.onboardingState,
  });

  @override
  List<Object?> get props {
    return [
      onboardingState,
    ];
  }
}
