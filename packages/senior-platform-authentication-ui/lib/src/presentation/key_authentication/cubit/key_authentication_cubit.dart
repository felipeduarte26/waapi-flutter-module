import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../senior_platform_authentication_ui.dart';

class KeyAuthenticationCubit extends Cubit<KeyAuthenticationState> {
  final GetTenantLoginSettingsUsecase _getTenantLoginSettingsUsecase;
  final AuthenticateKeyUsecase _authenticateKeyUsecase;
  final AuthenticationBloc _authenticationBloc;
  final CheckStatusConnectionUsecase _checkStatusConnectionUsecase;

  KeyAuthenticationCubit({
    required getTenantLoginSettingsUsecase,
    required authenticateKeyUsecase,
    required authenticationBloc,
    required checkStatusConnectionUsecase,
  })  : _getTenantLoginSettingsUsecase = getTenantLoginSettingsUsecase,
        _authenticateKeyUsecase = authenticateKeyUsecase,
        _authenticationBloc = authenticationBloc,
        _checkStatusConnectionUsecase = checkStatusConnectionUsecase,
        super(KeyAuthenticationState.initial());

  void onDomainChanged(String text) {
    emit(state.copyWith(
      tenantName: text,
      keyAuthenticationFlow: KeyAuthenticationFlow.domain,
    ));
  }

  void onAccessKeyChanged(String text) {
    emit(state.copyWith(
      accessKey: text,
      keyAuthenticationFlow: KeyAuthenticationFlow.accessKey,
    ));
  }

  void onSecretChanged(String text) {
    emit(state.copyWith(
      secret: text,
      keyAuthenticationFlow: KeyAuthenticationFlow.secret,
    ));
  }

  FutureOr<void> login() async {
    if (!state.domainOK || !state.accessKeyOK || !state.secretOK) {
      emit(state.copyWith(
        status: NetworkStatus.idle,
        errorType: ErrorType.unknown,
      ));
      return;
    }

    emit(state.copyWith(
      status: NetworkStatus.loading,
      errorType: null,
    ));

    final isOnline = await _checkStatusConnectionUsecase.call(NoParams());

    if (SeniorAuthentication.enableLoginWithKey && isOnline) {
      try {
        LoginWithKey loginWithKey = LoginWithKey(
          accessKey: state.accessKey,
          secret: state.secret,
          tenantName: state.tenantName,
        );

        final result = await _authenticateKeyUsecase.call(null, loginWithKey);

        if (result != null && result.token != null) {
          _authenticationBloc.add(
            AuthenticateKey(
              authenticationResponse: result,
            ),
          );

          return emit(state.copyWith(errorType: null));
        }
      } on BadRequestException catch (_) {
        emit(state.copyWith(
          status: NetworkStatus.idle,
          errorType: ErrorType.unauthorized,
        ));
      } catch (_) {
        emit(state.copyWith(
          status: NetworkStatus.idle,
          errorType: ErrorType.unknown,
        ));
      }
    } else {
      emit(state.copyWith(
        status: NetworkStatus.idle,
        errorType: null,
      ));
    }
  }

  set setDomainOK(bool value) {
    emit(state.copyWith(domainOK: value));
  }

  set setAccessKeyOk(bool value) {
    emit(state.copyWith(accessKeyOK: value));
  }

  set setSecretOk(bool value) {
    emit(state.copyWith(secretOK: value));
  }

  Future<TenantLoginSettings?> getTenantLoginSettings() async {
    if (state.tenantName.isEmpty) {
      return null;
    }

    final isOnline = await _checkStatusConnectionUsecase.call(NoParams());

    if (!isOnline) {
      emit(
          state.copyWith(keyAuthenticationFlow: KeyAuthenticationFlow.offline));
      return null;
    }

    emit(state.copyWith(
      status: NetworkStatus.loading,
      errorType: null,
      keyAuthenticationFlow: KeyAuthenticationFlow.domain,
    ));

    TenantLoginSettings? result;

    try {
      result = await _getTenantLoginSettingsUsecase(
          TenantLogin(tenantDomain: state.tenantName));

      emit(state.copyWith(
        status: NetworkStatus.idle,
        tenantLoginSettings: result,
        domainOK: true,
        errorType: null,
        keyAuthenticationFlow: KeyAuthenticationFlow.accessKey,
      ));
    } on TenantNotFoundException catch (_) {
      emit(state.copyWith(
        status: NetworkStatus.idle,
        tenantLoginSettings: null,
        domainOK: false,
        errorType: ErrorType.domainNotFound,
        keyAuthenticationFlow: KeyAuthenticationFlow.domain,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: NetworkStatus.idle,
        tenantLoginSettings: null,
        domainOK: false,
        errorType: ErrorType.unknown,
        keyAuthenticationFlow: KeyAuthenticationFlow.unknown,
      ));
    } finally {
      emit(state.copyWith(
        errorType: null,
      ));
    }

    return result;
  }
}
