import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../../core/services/has_clocking/external/drivers/save_has_clocking_driver_impl.dart';
import '../../../../../core/services/has_clocking_configuration/external/drivers/save_clocking_configuration_driver_impl.dart';

import 'sign_out_event.dart';
import 'sign_out_state.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  final AuthenticationBloc authenticationBloc;

  late StreamSubscription authenticationSubscription;

  SignOutBloc({
    required this.authenticationBloc,
  }) : super(
          CurrentSignOutState(
            authenticationState: authenticationBloc.state,
            signOutStatus: SignOutStatusEnum.initial,
          ),
        ) {
    on<ChangeAuthenticationStateEvent>(_changeAuthenticationStateEvent);
    on<RequestSignOutEvent>(_requestSignOutEvent);
    on<RequestSignOutOfflineEvent>(_requestSignOutOfflineEvent);

    authenticationSubscription = authenticationBloc.stream.listen(
      (authenticationBlocState) {
        add(
          ChangeAuthenticationStateEvent(
            authenticationState: authenticationBlocState,
          ),
        );
      },
    );
  }

  Future<void> _changeAuthenticationStateEvent(
    ChangeAuthenticationStateEvent event,
    Emitter<SignOutState> emit,
  ) async {
    emit(
      state.currentState(
        authenticationState: event.authenticationState,
      ),
    );
  }

  Future<void> _requestSignOutEvent(
    RequestSignOutEvent _,
    Emitter<SignOutState> emit,
  ) async {
    final SaveClockingConfigurationDriverImpl saveClockingConfigurationDriverImpl =
        await Modular.getAsync<SaveClockingConfigurationDriverImpl>();

    final SaveHasClockingDriverImpl saveHasClockingConfigurationDriverImpl = Modular.get<SaveHasClockingDriverImpl>();

    saveClockingConfigurationDriverImpl.call(
      allowGpoOnApp: null,
      key: 'allowGpoOnApp',
    );

    saveHasClockingConfigurationDriverImpl.call(
      hasClocking: null,
    );

    try {
      emit(
        state.currentState(
          signOutStatus: SignOutStatusEnum.loading,
        ),
      );

      authenticationBloc.add(
        const LogoutOnlineRequested(),
      );

      emit(
        state.currentState(
          signOutStatus: SignOutStatusEnum.signOut,
        ),
      );
    } catch (_) {
      emit(
        state.currentState(
          signOutStatus: SignOutStatusEnum.error,
        ),
      );

      emit(
        state.currentState(
          signOutStatus: SignOutStatusEnum.initial,
        ),
      );
    }
  }

  Future<void> _requestSignOutOfflineEvent(
    RequestSignOutOfflineEvent _,
    Emitter<SignOutState> emit,
  ) async {
    emit(
      state.currentState(
        signOutStatus: SignOutStatusEnum.loading,
      ),
    );

    authenticationBloc.add(
      LogoutOfflineRequested(username: authenticationBloc.state.username ?? ''),
    );

    emit(
      state.currentState(
        signOutStatus: SignOutStatusEnum.initial,
      ),
    );
  }
}
