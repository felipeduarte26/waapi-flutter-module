import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../senior_platform_authentication_ui.dart';

part 'mfa_authentication_code_state.dart';

class MFAAuthenticationCubit extends Cubit<MFAAuthenticationState> {
  final SendMFAConfigEmailUsecase _sendMfaConfigEmailUsecase;
  final LoginMFAUsecase _loginMFAUsecase;
  final AuthenticationBloc _authenticationBloc;

  MFAAuthenticationCubit({
    required SendMFAConfigEmailUsecase sendMfaConfigEmailUsecase,
    required LoginMFAUsecase loginMFAUsecase,
    required AuthenticationBloc authenticationBloc,
  })  : _sendMfaConfigEmailUsecase = sendMfaConfigEmailUsecase,
        _loginMFAUsecase = loginMFAUsecase,
        _authenticationBloc = authenticationBloc,
        super(MFAAuthenticationState.initial());

  void initialize(MFAInfo mfaInfo, String username) {
    MFAAuthenticationStatus mfaStatus = MFAAuthenticationStatus.notConfigured;

    if (mfaInfo.mfaStatus == 'CONFIGURED') {
      mfaStatus = MFAAuthenticationStatus.configured;
    }

    if (mfaInfo.mfaStatus == 'RESETTED') {
      mfaStatus = MFAAuthenticationStatus.changedByADM;
    }

    emit(state.copyWith(
      mfaStatus: mfaStatus,
      mfaInfo: mfaInfo,
      username: username,
    ));
  }

  Future<bool> login({
    required String validationCode,
    required String tenant,
    required String temporaryToken,
  }) async {
    emit(state.copyWith(
      status: NetworkStatus.loading,
      errorType: null,
    ));
    try {
      final result = await _loginMFAUsecase(
        LoginMFA(
          temporaryToken: temporaryToken,
          tenant: tenant,
          validationCode: validationCode,
        ),
      );

      if (result.resetPasswordInfo != null && result.resetPasswordInfo?.tenant != null) {
        _authenticationBloc.add(
          AuthenticationStatusChanged(
            AuthenticationStatus.authenticated,
            authenticationResponse: result,
          ),
        );

        emit(state.copyWith(
          errorType: null,
          authenticationResponse: result,
        ));
        return true;
      }

      if (result.token != null) {
        // If whoever implemented the package, has enabled biometrics will enter the if, it will go up a modal asking if the user, who enables biometrics for the application.
        if (SeniorAuthentication.enableBiometry) {
          emit(
            state.copyWith(
              status: NetworkStatus.loading,
              authenticationResponse: result,
              mfaStatus: MFAAuthenticationStatus.biometryFlow,
            ),
          );
        } else {
          _authenticationBloc.add(
            AuthenticationStatusChanged(
              AuthenticationStatus.authenticated,
              authenticationResponse: result,
            ),
          );
        }

        emit(
          state.copyWith(
            errorType: null,
          ),
        );

        return true;
      }
    } on UnauthorizedException catch (_) {
      emit(
        state.copyWith(
          status: NetworkStatus.idle,
          errorType: ErrorType.unauthorized,
        ),
      );
    } catch (_) {
      emit(state.copyWith(
        status: NetworkStatus.idle,
        errorType: ErrorType.unknown,
      ));
    }
    return false;
  }

  FutureOr<void> sendMFAConfigEmail({
    required String temporaryToken,
    required String tenant,
  }) async {
    emit(state.copyWith(
      status: NetworkStatus.loading,
      errorType: null,
    ));

    try {
      final SendMFAConfigEmail send = SendMFAConfigEmail(
        temporaryToken: temporaryToken,
        tenant: tenant,
      );

      final result = await _sendMfaConfigEmailUsecase(send);

      emit(state.copyWith(
        mfaStatus: MFAAuthenticationStatus.emailSended,
        status: NetworkStatus.idle,
        errorType: null,
        email: result.email,
      ));
    } on UnauthorizedException catch (_) {
      emit(state.copyWith(
        status: NetworkStatus.idle,
        errorType: ErrorType.unauthorized,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: NetworkStatus.idle,
        errorType: ErrorType.unknown,
      ));
    } finally {
      emit(state.copyWith(errorType: null));
    }
  }
}
