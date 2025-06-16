import 'package:equatable/equatable.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../core/services/has_clocking/presenter/bloc/has_clocking_state.dart';
import '../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_state.dart';
import '../../../../authentication/presenter/blocs/sign_out/sign_out_state.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../happiness_index/presenter/blocs/happiness_index/happiness_index_state.dart';
import '../../../../moods/presenter/blocs/moods_bloc/moods_state.dart';
import '../../../../onboarding/presenter/blocs/onboarding_bloc/onboarding_state.dart';
import '../../../../personalization/presenter/bloc/personalization_bloc/personalization_bloc.dart';
import '../connectivity_bloc/connectivity_state.dart';

abstract class HomeScreenEvent extends Equatable {}

class ChangeAuthenticationStateEvent extends HomeScreenEvent {
  final AuthenticationState authenticationState;

  ChangeAuthenticationStateEvent({
    required this.authenticationState,
  });

  @override
  List<Object?> get props {
    return [
      authenticationState,
    ];
  }
}

class ChangeAuthorizationStateEvent extends HomeScreenEvent {
  final AuthorizationState authorizationState;

  ChangeAuthorizationStateEvent({
    required this.authorizationState,
  });

  @override
  List<Object?> get props {
    return [
      authorizationState,
    ];
  }
}

class ChangeConnectivityStateEvent extends HomeScreenEvent {
  final ConnectivityState connectivityState;

  ChangeConnectivityStateEvent({
    required this.connectivityState,
  });

  @override
  List<Object?> get props {
    return [
      connectivityState,
    ];
  }
}

class ChangeActiveContractStateEvent extends HomeScreenEvent {
  final ActiveContractState activeContractState;

  ChangeActiveContractStateEvent({
    required this.activeContractState,
  });

  @override
  List<Object?> get props {
    return [
      activeContractState,
    ];
  }
}

class ChangeOnboardingStateEvent extends HomeScreenEvent {
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

class ChangeSignOutStateEvent extends HomeScreenEvent {
  final SignOutState signOutState;

  ChangeSignOutStateEvent({
    required this.signOutState,
  });

  @override
  List<Object?> get props {
    return [
      signOutState,
    ];
  }
}

class ChangePersonalizationStateEvent extends HomeScreenEvent {
  final PersonalizationState personalizationState;

  ChangePersonalizationStateEvent({
    required this.personalizationState,
  });

  @override
  List<Object?> get props {
    return [
      personalizationState,
    ];
  }
}

class ChangeHasClockingStateEvent extends HomeScreenEvent {
  final HasClockingState hasClockingState;

  ChangeHasClockingStateEvent({
    required this.hasClockingState,
  });

  @override
  List<Object?> get props {
    return [
      hasClockingState,
    ];
  }
}

class ChangeHappinessIndexStateEvent extends HomeScreenEvent {
  final HappinessIndexState happinessIndexState;

  ChangeHappinessIndexStateEvent({
    required this.happinessIndexState,
  });

  @override
  List<Object?> get props {
    return [
      happinessIndexState,
    ];
  }
}

class ChangeMoodsStateEvent extends HomeScreenEvent {
  final MoodsState moodsState;

  ChangeMoodsStateEvent({
    required this.moodsState,
  });

  @override
  List<Object?> get props {
    return [
      moodsState,
    ];
  }
}
