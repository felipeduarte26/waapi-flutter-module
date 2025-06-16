import 'package:equatable/equatable.dart';

import '../../../blocs/onboarding_bloc/onboarding_state.dart';

abstract class OnboardingScreenState extends Equatable {
  final OnboardingState onboardingState;

  const OnboardingScreenState({
    required this.onboardingState,
  });

  CurrentOnboardingScreenState currentState({
    required OnboardingState onboardingState,
  }) {
    return CurrentOnboardingScreenState(
      onboardingState: onboardingState,
    );
  }

  @override
  List<Object?> get props {
    return [
      onboardingState,
    ];
  }
}

class CurrentOnboardingScreenState extends OnboardingScreenState {
  const CurrentOnboardingScreenState({
    required OnboardingState onboardingState,
  }) : super(onboardingState: onboardingState);
}
