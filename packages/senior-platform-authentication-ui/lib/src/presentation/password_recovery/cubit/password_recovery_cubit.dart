import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../senior_platform_authentication_ui.dart';

part 'password_recovery_state.dart';

class PasswordRecoveryCubit extends Cubit<PasswordRecoveryState> {
  final GetRecaptchaUrlUsecase _getRecaptchaUrlUsecase;
  final ResetPasswordUsecase _resetPasswordUsecase;

  PasswordRecoveryCubit(
      {required getRecaptchaUrlUsecase, required resetPasswordUsecase})
      : _getRecaptchaUrlUsecase = getRecaptchaUrlUsecase,
        _resetPasswordUsecase = resetPasswordUsecase,
        super(PasswordRecoveryState.initial());

  void onUsernameChanged(String username) {
    emit(state.copyWith(
      username: username,
    ));
  }

  void onPasswordRecoveryStatusChanged(PasswordRecoveryStatus status) {
    emit(state.copyWith(passwordRecoveryStatus: status));
  }

  void onJavaScriptMessage(String message) {
    if (state.passwordRecoveryStatus == PasswordRecoveryStatus.finished) {
      return;
    }
    log('>>>>> RECAPTCHA_STATUS => $message');

    if (message.contains('recaptcha_success=')) {
      final captcha = message.replaceAll('recaptcha_success=', '');

      emit(state.copyWith(
        captcha: captcha,
        passwordRecoveryStatus: captcha.isNotEmpty
            ? PasswordRecoveryStatus.finished
            : PasswordRecoveryStatus.error,
      ));

      if (captcha.isNotEmpty) {
        resetPassword();
      }
    }
  }

  FutureOr<void> getRecaptchaUrl(
      ChangePasswordSettings changePasswordSettings) async {
    emit(state.copyWith(networkStatus: NetworkStatus.loading));
    final key = changePasswordSettings.customRecaptchaSiteKey ?? '';
    try {
      final url = await _getRecaptchaUrlUsecase(NoParams());
      log('$url${key.isNotEmpty ? '?siteKey=$key' : ''}');

      emit(state.copyWith(
        networkStatus: NetworkStatus.idle,
        passwordRecoveryStatus: url.isNotEmpty
            ? PasswordRecoveryStatus.recaptcha
            : PasswordRecoveryStatus.error,
        recaptchaUrl: url,
      ));
    } catch (_) {
      emit(state.copyWith(
        networkStatus: NetworkStatus.idle,
        passwordRecoveryStatus: PasswordRecoveryStatus.error,
        recaptchaUrl: '',
      ));
    }
  }

  FutureOr<void> resetPassword() async {
    if (state.networkStatus == NetworkStatus.loading) {
      return;
    }

    emit(state.copyWith(
      networkStatus: NetworkStatus.loading,
    ));

    final resetPassword = ResetPassword(
      username: state.username,
      captcha: state.captcha,
    );

    try {
      await _resetPasswordUsecase(resetPassword);
      emit(state.copyWith(
        networkStatus: NetworkStatus.idle,
      ));
    } catch (_) {
      emit(state.copyWith(
        networkStatus: NetworkStatus.idle,
        passwordRecoveryStatus: PasswordRecoveryStatus.error,
      ));
    }
  }
}
