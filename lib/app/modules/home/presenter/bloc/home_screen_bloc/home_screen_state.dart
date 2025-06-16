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

abstract class HomeScreenState extends Equatable {
  final AuthorizationState authorizationState;
  final ConnectivityState connectivityState;
  final AuthenticationState authenticationState;
  final ActiveContractState activeContractState;
  final OnboardingState onboardingState;
  final SignOutState signOutState;
  final PersonalizationState personalizationState;
  final HasClockingState hasClockingState;
  final HappinessIndexState happinessIndexState;
  final MoodsState moodsState;

  const HomeScreenState({
    required this.authorizationState,
    required this.connectivityState,
    required this.authenticationState,
    required this.activeContractState,
    required this.onboardingState,
    required this.signOutState,
    required this.personalizationState,
    required this.hasClockingState,
    required this.happinessIndexState,
    required this.moodsState,
  });

  CurrentHomeScreenState currentState({
    AuthorizationState? authorizationState,
    ConnectivityState? connectivityState,
    AuthenticationState? authenticationState,
    ActiveContractState? activeContractState,
    SignOutState? signOutState,
    OnboardingState? onboardingState,
    PersonalizationState? personalizationState,
    HasClockingState? hasClockingState,
    HappinessIndexState? happinessIndexState,
    MoodsState? moodsState,
  }) {
    return CurrentHomeScreenState(
      authorizationState: authorizationState ?? this.authorizationState,
      connectivityState: connectivityState ?? this.connectivityState,
      authenticationState: authenticationState ?? this.authenticationState,
      activeContractState: activeContractState ?? this.activeContractState,
      onboardingState: onboardingState ?? this.onboardingState,
      signOutState: signOutState ?? this.signOutState,
      personalizationState: personalizationState ?? this.personalizationState,
      hasClockingState: hasClockingState ?? this.hasClockingState,
      happinessIndexState: happinessIndexState ?? this.happinessIndexState,
      moodsState: moodsState ?? this.moodsState,
    );
  }

  @override
  List<Object> get props => [
        authorizationState,
        connectivityState,
        authenticationState,
        activeContractState,
        onboardingState,
        signOutState,
        personalizationState,
        hasClockingState,
        happinessIndexState,
        moodsState,
      ];
}

class CurrentHomeScreenState extends HomeScreenState {
  const CurrentHomeScreenState({
    required AuthorizationState authorizationState,
    required ConnectivityState connectivityState,
    required AuthenticationState authenticationState,
    required ActiveContractState activeContractState,
    required OnboardingState onboardingState,
    required SignOutState signOutState,
    required PersonalizationState personalizationState,
    required HasClockingState hasClockingState,
    required HappinessIndexState happinessIndexState,
    required MoodsState moodsState,
  }) : super(
          authorizationState: authorizationState,
          connectivityState: connectivityState,
          authenticationState: authenticationState,
          activeContractState: activeContractState,
          onboardingState: onboardingState,
          signOutState: signOutState,
          personalizationState: personalizationState,
          hasClockingState: hasClockingState,
          happinessIndexState: happinessIndexState,
          moodsState: moodsState,
        );
}
