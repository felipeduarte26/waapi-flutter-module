import 'package:equatable/equatable.dart';

import '../../../../../authentication/presenter/blocs/sign_out/sign_out_state.dart';
import '../../../../../onboarding/presenter/blocs/onboarding_bloc/onboarding_state.dart';
import '../../../blocs/get_current_version/get_current_version_state.dart';

abstract class SettingsScreenState extends Equatable {
  final GetCurrentVersionState getCurrentVersionState;
  final SignOutState signOutState;
  final OnboardingState onboardingState;

  const SettingsScreenState({
    required this.getCurrentVersionState,
    required this.signOutState,
    required this.onboardingState,
  });

  CurrentSettingsScreenState currentState({
    GetCurrentVersionState? getCurrentVersionState,
    SignOutState? signOutState,
    OnboardingState? onboardingState,
  }) {
    return CurrentSettingsScreenState(
      getCurrentVersionState: getCurrentVersionState ?? this.getCurrentVersionState,
      signOutState: signOutState ?? this.signOutState,
      onboardingState: onboardingState ?? this.onboardingState,
    );
  }

  @override
  List<Object?> get props {
    return [
      getCurrentVersionState,
      signOutState,
      onboardingState,
    ];
  }
}

class CurrentSettingsScreenState extends SettingsScreenState {
  const CurrentSettingsScreenState({
    required GetCurrentVersionState getCurrentVersionState,
    required SignOutState signOutState,
    required OnboardingState onboardingState,
  }) : super(
          getCurrentVersionState: getCurrentVersionState,
          signOutState: signOutState,
          onboardingState: onboardingState,
        );
}
