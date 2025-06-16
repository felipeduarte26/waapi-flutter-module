import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../core/services/has_clocking/presenter/bloc/has_clocking_bloc.dart';
import '../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_bloc.dart';
import '../../../../authentication/presenter/blocs/sign_out/sign_out_bloc.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../happiness_index/presenter/blocs/happiness_index/happiness_index_bloc.dart';
import '../../../../notification/presenter/blocs/counter_notifications_bloc/counter_notifications_bloc.dart';
import '../../../../notification/presenter/blocs/permission_notification_bloc/permission_notification_bloc.dart';
import '../../../../moods/presenter/blocs/moods_bloc/moods_bloc.dart';
import '../../../../onboarding/presenter/blocs/onboarding_bloc/onboarding_bloc.dart';
import '../../../../personalization/presenter/bloc/personalization_bloc/personalization_bloc.dart';
import '../connectivity_bloc/connectivity_bloc.dart';
import 'home_screen_event.dart';
import 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final AuthenticationBloc authenticationBloc;
  final AuthorizationBloc authorizationBloc;
  final ConnectivityBloc connectivityBloc;
  final ActiveContractBloc activeContractBloc;
  final PermissionNotificationBloc? permissionNotificationBloc;
  final CounterNotificationsBloc? counterNotificationsBloc;
  final OnboardingBloc onboardingBloc;
  final SignOutBloc signOutBloc;
  final PersonalizationBloc personalizationBloc;
  final HasClockingBloc hasClockingBloc;
  final HappinessIndexBloc happinessIndexBloc;
  final MoodsBloc moodsBloc;

  late StreamSubscription authorizationSubscription;
  late StreamSubscription connectivitySubscription;
  late StreamSubscription authenticationSubscription;
  late StreamSubscription activeContractSubscription;
  late StreamSubscription counterNotificationsSubscription;
  late StreamSubscription permissionNotificationSubscription;
  late StreamSubscription onboardingSubscription;
  late StreamSubscription signOutSubscription;
  late StreamSubscription personalizationSubscription;
  late StreamSubscription hasClockingSubscription;
  late StreamSubscription happinessIndexSubscription;
  late StreamSubscription moodsSubscription;

  HomeScreenBloc({
    required this.authorizationBloc,
    required this.connectivityBloc,
    this.counterNotificationsBloc,
    required this.authenticationBloc,
    required this.activeContractBloc,
    this.permissionNotificationBloc,
    required this.onboardingBloc,
    required this.signOutBloc,
    required this.personalizationBloc,
    required this.hasClockingBloc,
    required this.happinessIndexBloc,
    required this.moodsBloc,
  }) : super(
          CurrentHomeScreenState(
            authorizationState: authorizationBloc.state,
            connectivityState: connectivityBloc.state,
            authenticationState: authenticationBloc.state,
            activeContractState: activeContractBloc.state,
            onboardingState: onboardingBloc.state,
            signOutState: signOutBloc.state,
            personalizationState: personalizationBloc.state,
            hasClockingState: hasClockingBloc.state,
            happinessIndexState: happinessIndexBloc.state,
            moodsState: moodsBloc.state,
          ),
        ) {
    on<ChangeAuthorizationStateEvent>(_changeAuthorizationStateEvent);
    on<ChangeConnectivityStateEvent>(_changeConnectivityStateEvent);
    on<ChangeAuthenticationStateEvent>(_changeAuthenticationStateEvent);
    on<ChangeActiveContractStateEvent>(_changeActiveContractStateEvent);
    on<ChangeOnboardingStateEvent>(_changeOnboardingStateEvent);
    on<ChangeSignOutStateEvent>(_changeSignOutStateEvent);
    on<ChangePersonalizationStateEvent>(_changePersonalizationStateEvent);
    on<ChangeHasClockingStateEvent>(_changeHasClockingStateEvent);
    on<ChangeHappinessIndexStateEvent>(_changeHappinessIndexStateEvent);
    on<ChangeMoodsStateEvent>(_changeMoodsStateEvent);

    authorizationSubscription = authorizationBloc.stream.listen(
      (authorizationBlocState) {
        add(
          ChangeAuthorizationStateEvent(
            authorizationState: authorizationBlocState,
          ),
        );
      },
    );

    connectivitySubscription = connectivityBloc.stream.listen(
      (connectivityState) {
        add(
          ChangeConnectivityStateEvent(
            connectivityState: connectivityState,
          ),
        );
      },
    );

    authenticationSubscription = authenticationBloc.stream.listen(
      (authenticationBlocState) {
        add(
          ChangeAuthenticationStateEvent(
            authenticationState: authenticationBlocState,
          ),
        );
      },
    );

    activeContractSubscription = activeContractBloc.stream.listen(
      (activeContractState) {
        add(
          ChangeActiveContractStateEvent(
            activeContractState: activeContractState,
          ),
        );
      },
    );

    onboardingSubscription = onboardingBloc.stream.listen(
      (onboardingState) {
        add(
          ChangeOnboardingStateEvent(
            onboardingState: onboardingState,
          ),
        );
      },
    );

    signOutSubscription = signOutBloc.stream.listen(
      (signOutState) {
        add(
          ChangeSignOutStateEvent(
            signOutState: signOutState,
          ),
        );
      },
    );

    personalizationSubscription = personalizationBloc.stream.listen(
      (personalizationState) {
        add(
          ChangePersonalizationStateEvent(
            personalizationState: personalizationState,
          ),
        );
      },
    );

    hasClockingSubscription = hasClockingBloc.stream.listen(
      (hasClockingState) {
        add(
          ChangeHasClockingStateEvent(
            hasClockingState: hasClockingState,
          ),
        );
      },
    );

    happinessIndexSubscription = happinessIndexBloc.stream.listen(
      (happinessIndexState) {
        add(
          ChangeHappinessIndexStateEvent(
            happinessIndexState: happinessIndexState,
          ),
        );
      },
    );

    moodsSubscription = moodsBloc.stream.listen(
      (moodsState) {
        add(
          ChangeMoodsStateEvent(
            moodsState: moodsState,
          ),
        );
      },
    );
  }

  Future<void> _changeAuthorizationStateEvent(
    ChangeAuthorizationStateEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(
      state.currentState(
        authorizationState: event.authorizationState,
      ),
    );
  }

  Future<void> _changeConnectivityStateEvent(
    ChangeConnectivityStateEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(
      state.currentState(
        connectivityState: event.connectivityState,
      ),
    );
  }

  Future<void> _changeAuthenticationStateEvent(
    ChangeAuthenticationStateEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(
      state.currentState(
        authenticationState: event.authenticationState,
      ),
    );
  }

  Future<void> _changeActiveContractStateEvent(
    ChangeActiveContractStateEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(
      state.currentState(
        activeContractState: event.activeContractState,
      ),
    );
  }

  Future<void> _changeOnboardingStateEvent(
    ChangeOnboardingStateEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(
      state.currentState(
        onboardingState: event.onboardingState,
      ),
    );
  }

  Future<void> _changeSignOutStateEvent(
    ChangeSignOutStateEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(
      state.currentState(
        signOutState: event.signOutState,
      ),
    );
  }

  Future<void> _changePersonalizationStateEvent(
    ChangePersonalizationStateEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(
      state.currentState(
        personalizationState: event.personalizationState,
      ),
    );
  }

  Future<void> _changeHasClockingStateEvent(
    ChangeHasClockingStateEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(
      state.currentState(
        hasClockingState: event.hasClockingState,
      ),
    );
  }

  Future<void> _changeHappinessIndexStateEvent(
    ChangeHappinessIndexStateEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(
      state.currentState(
        happinessIndexState: event.happinessIndexState,
      ),
    );
  }

  Future<void> _changeMoodsStateEvent(
    ChangeMoodsStateEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(
      state.currentState(
        moodsState: event.moodsState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await authorizationSubscription.cancel();
    await connectivitySubscription.cancel();
    await authenticationSubscription.cancel();
    await activeContractSubscription.cancel();
    await permissionNotificationSubscription.cancel();
    await counterNotificationsSubscription.cancel();
    await onboardingSubscription.cancel();
    await signOutSubscription.cancel();
    await personalizationSubscription.cancel();
    await happinessIndexSubscription.cancel();
    await moodsSubscription.cancel();
    await hasClockingSubscription.cancel();
    return super.close();
  }
}
