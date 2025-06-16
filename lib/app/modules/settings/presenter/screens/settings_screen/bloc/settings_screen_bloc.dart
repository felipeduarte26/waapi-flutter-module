import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../authentication/presenter/blocs/sign_out/sign_out_bloc.dart';
import '../../../../../onboarding/presenter/blocs/onboarding_bloc/onboarding_bloc.dart';
import '../../../blocs/get_current_version/get_current_version_bloc.dart';
import 'settings_screen_event.dart';
import 'settings_screen_state.dart';

class SettingsScreenBloc extends Bloc<SettingsScreenEvent, SettingsScreenState> {
  final GetCurrentVersionBloc getCurrentVersionBloc;
  final SignOutBloc signOutBloc;
  final OnboardingBloc onboardingBloc;

  late StreamSubscription getCurrentVersionSubscription;
  late StreamSubscription signOutSubscription;
  late StreamSubscription onboardingSubscription;
  late StreamSubscription settingsBiometricSubscription;

  SettingsScreenBloc({
    required this.getCurrentVersionBloc,
    required this.signOutBloc,
    required this.onboardingBloc,
  }) : super(
          CurrentSettingsScreenState(
            getCurrentVersionState: getCurrentVersionBloc.state,
            signOutState: signOutBloc.state,
            onboardingState: onboardingBloc.state,
          ),
        ) {
    on<ChangeGetCurrentVersionEvent>(_changeGetCurrentVersionEvent);
    on<ChangeSignOutStateEvent>(_changeSignOutStateEvent);
    on<ChangeOnboardingStateEvent>(_changeOnboardingStateEvent);

    getCurrentVersionSubscription = getCurrentVersionBloc.stream.listen(
      (getCurrentVersionBlocState) {
        add(
          ChangeGetCurrentVersionEvent(
            getCurrentVersionState: getCurrentVersionBlocState,
          ),
        );
      },
    );

    signOutSubscription = signOutBloc.stream.listen(
      (signOutBlocState) {
        add(
          ChangeSignOutStateEvent(
            signOutState: signOutBloc.state,
          ),
        );
      },
    );

    onboardingSubscription = onboardingBloc.stream.listen(
      (onboardingBlocState) {
        add(
          ChangeOnboardingStateEvent(
            onboardingState: onboardingBlocState,
          ),
        );
      },
    );
  }

  Future<void> _changeGetCurrentVersionEvent(
    ChangeGetCurrentVersionEvent event,
    Emitter<SettingsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        getCurrentVersionState: event.getCurrentVersionState,
      ),
    );
  }

  Future<void> _changeSignOutStateEvent(
    ChangeSignOutStateEvent event,
    Emitter<SettingsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        signOutState: event.signOutState,
      ),
    );
  }

  Future<void> _changeOnboardingStateEvent(
    ChangeOnboardingStateEvent event,
    Emitter<SettingsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        onboardingState: event.onboardingState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await getCurrentVersionSubscription.cancel();
    await signOutSubscription.cancel();
    await onboardingSubscription.cancel();
    await settingsBiometricSubscription.cancel();

    return super.close();
  }
}
