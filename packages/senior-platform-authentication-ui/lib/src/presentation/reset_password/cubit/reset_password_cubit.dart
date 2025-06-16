import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../senior_platform_authentication_ui.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final LoginWithResetPasswordUsecase _loginWithResetPasswordUsecase;
  final AuthenticationBloc _authenticationBloc;

  ResetPasswordCubit({
    required loginWithResetPasswordUsecase,
    required authenticationBloc,
  })  : _loginWithResetPasswordUsecase = loginWithResetPasswordUsecase,
        _authenticationBloc = authenticationBloc,
        super(ResetPasswordState.initial());

  Future<bool> loginWithResetPassword(String newPassword) async {
    final credentials = UserLoginResetPassword(
      newPassword: newPassword,
      temporaryToken: state.temporaryToken,
      username: state.username,
    );
    try {
      final result = await _loginWithResetPasswordUsecase(credentials);

      if (result.token != null) {
        if (SeniorAuthentication.enableBiometry) {
          emit(state.copyWith(
              biometricFlow: true, authenticationResponse: result));
        } else {
          _authenticationBloc.add(
            AuthenticationStatusChanged(
              AuthenticationStatus.authenticated,
              authenticationResponse: result,
            ),
          );
        }
        return true;
      }
    } catch (_) {
      return false;
    }
    return false;
  }

  FutureOr<void> initialize(
      ResetPasswordInfo resetPasswordInfo, String username) async {
    await _getPasswordPolicySettings(resetPasswordInfo);

    emit(state.copyWith(
      username: username,
      temporaryToken: resetPasswordInfo.temporaryToken,
    ));
  }

  FutureOr<void> _getPasswordPolicySettings(
      ResetPasswordInfo resetPasswordInfo) async {
    if (state.networkStatus == NetworkStatus.loading) {
      return;
    }

    emit(state.copyWith(
      networkStatus: NetworkStatus.loading,
    ));

      final passwordPolicySettings = PasswordPolicySettings(
        minimumPasswordLength: resetPasswordInfo.minimumPasswordLength ?? 6,
        maximumPasswordLength: resetPasswordInfo.maximumPasswordLength ?? 30,
        requireNumbers: true,
        requireLowercase: true,
        requireUppercase: true,
        requireSpecialCharacters: true,
      );
    
      emit(state.copyWith(
        passwordPolicySettings: passwordPolicySettings,
        networkStatus: NetworkStatus.idle,
      ));
    }
}
