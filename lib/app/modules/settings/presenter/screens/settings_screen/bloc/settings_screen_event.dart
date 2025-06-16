import 'package:equatable/equatable.dart';

import '../../../../../authentication/presenter/blocs/sign_out/sign_out_state.dart';
import '../../../../../onboarding/presenter/blocs/onboarding_bloc/onboarding_state.dart';
import '../../../blocs/get_current_version/get_current_version_state.dart';

abstract class SettingsScreenEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class ChangeGetCurrentVersionEvent extends SettingsScreenEvent {
  final GetCurrentVersionState? getCurrentVersionState;

  ChangeGetCurrentVersionEvent({
    required this.getCurrentVersionState,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      getCurrentVersionState,
    ];
  }
}

class ChangeSignOutStateEvent extends SettingsScreenEvent {
  final SignOutState signOutState;

  ChangeSignOutStateEvent({
    required this.signOutState,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      signOutState,
    ];
  }
}

class ChangeOnboardingStateEvent extends SettingsScreenEvent {
  final OnboardingState onboardingState;

  ChangeOnboardingStateEvent({
    required this.onboardingState,
  });

  @override
  List<Object?> get props {
    return [
      onboardingState,
    ];
  }
}
