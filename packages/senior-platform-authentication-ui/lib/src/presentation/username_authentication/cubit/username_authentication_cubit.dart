import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../senior_platform_authentication_ui.dart';

part 'username_authentication_state.dart';

class UserNameAuthenticationCubit extends Cubit<UserNameAuthenticationState> {
  final GetTenantLoginSettingsUsecase _getTenantLoginSettingsUsecase;
  final LoginUsecase _loginUsecase;
  final AuthenticationBloc _authenticationBloc;
  final GetStoredTokenUsecase _getStoredTokenUsecase;
  final CheckStoredTokenUsecase _checkStoredTokenUsecase;
  final CheckStatusConnectionUsecase _checkStatusConnectionUsecase;
  final LoginOfflineUsecase _loginOfflineUsecase;
  final SecureStorageRepository _secureStorageRepository;
  final bool requestBiometry;

  UserNameAuthenticationCubit({
    required getTenantLoginSettingsUsecase,
    required loginUsecase,
    required authenticationBloc,
    required getStoredTokenUsecase,
    required checkStatusConnectionUsecase,
    required loginOfflineUsecase,
    required secureStorageRepository,
    required checkStoredTokenUsecase,
    this.requestBiometry = true,
  })  : _getTenantLoginSettingsUsecase = getTenantLoginSettingsUsecase,
        _loginUsecase = loginUsecase,
        _authenticationBloc = authenticationBloc,
        _getStoredTokenUsecase = getStoredTokenUsecase,
        _checkStatusConnectionUsecase = checkStatusConnectionUsecase,
        _loginOfflineUsecase = loginOfflineUsecase,
        _secureStorageRepository = secureStorageRepository,
        _checkStoredTokenUsecase = checkStoredTokenUsecase,
        super(UserNameAuthenticationState.initial());

  void onUserNameChanged(String text) {
    emit(state.copyWith(username: text));
  }

  void onPasswordChanged(String text) {
    emit(state.copyWith(password: text));
  }

  FutureOr<void> login() async {
    emit(state.copyWith(status: NetworkStatus.loading, errorType: null));

    final isOnline = await _checkStatusConnectionUsecase.call(NoParams());

    if (!isOnline) {
      if (!SeniorAuthentication.enableLoginOffline) {
        return emit(
          state.copyWith(
            status: NetworkStatus.idle,
            errorType: ErrorType.disableLoginOffline,
          ),
        );
      }

      final isTokenValid = await _checkStoredTokenUsecase(
          UserName(currentUsername: state.username));
      if (isTokenValid) {
        final tokenResult = await _getStoredTokenUsecase.call(
          UserName(currentUsername: state.username),
        );

        final token = tokenResult.token;

        final validateOfflineLogin = await _loginOfflineUsecase.call(
          HashInfo(
            password: state.password,
            hash: token?.hash ?? [],
            salt: token?.salt ?? [],
          ),
        );

        if (validateOfflineLogin) {
          final response = AuthenticationResponse(token: token);

          if (response.token != null) {
            await _secureStorageRepository.writeLastUser(
              state.username,
              '',
            );

            _authenticationBloc.add(
              AuthenticationStatusChanged(
                AuthenticationStatus.offline,
                authenticationResponse: response,
              ),
            );

            return emit(state.copyWith(
              errorType: null,
              authenticationResponse: response,
              status: NetworkStatus.idle,
            ));
          }
        }
      }

      return emit(state.copyWith(
        errorType: ErrorType.loginOfflineUnauthorized,
        status: NetworkStatus.idle,
      ));
    }

    try {
      final userLogin = UserLogin(
        username: state.username,
        password: state.password,
      );

      final result = await _loginUsecase(userLogin);

      // MFA flow
      if (result.mfaInfo != null) {
        emit(
          state.copyWith(
            mfaInfo: result.mfaInfo,
            authenticationFlow: AuthenticationFlow.mfa,
            username: state.username,
          ),
        );

        return emit(
          state.copyWith(
            authenticationFlow: AuthenticationFlow.password,
            mfaInfo: state.mfaInfo,
            username: state.username,
          ),
        );
      }

      // Reset password flow
      if (result.resetPasswordInfo != null) {
        emit(
          state.copyWith(
            authenticationFlow: AuthenticationFlow.resetPassword,
            authenticationResponse: result,
          ),
        );

        return emit(
          state.copyWith(
            authenticationFlow: AuthenticationFlow.password,
          ),
        );
      }
      // Password flow
      if (result.token != null) {
        if (requestBiometry && SeniorAuthentication.enableBiometry) {
          return emit(
            state.copyWith(
              biometryFlow: true,
              authenticationResponse: result,
              authenticationFlow: AuthenticationFlow.biometryFlow,
            ),
          );
        }

        _authenticationBloc.add(
          AuthenticationStatusChanged(
            AuthenticationStatus.authenticated,
            authenticationResponse: result,
          ),
        );

        return emit(state.copyWith(
          errorType: null,
          biometryFlow: SeniorAuthentication.enableBiometry,
        ));
      }

      return emit(
        state.copyWith(
          status: NetworkStatus.idle,
          errorType: ErrorType.unknown,
        ),
      );
    } on UnauthorizedException catch (_) {
      emit(state.copyWith(
        status: NetworkStatus.idle,
        tenantLoginSettings: null,
        errorType: ErrorType.unauthorized,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: NetworkStatus.idle,
        tenantLoginSettings: null,
        errorType: ErrorType.unknown,
      ));
    } finally {
      if (state.biometryFlow == false) {
        emit(state.copyWith(
          status: NetworkStatus.idle,
          errorType: null,
          mfaInfo: state.mfaInfo,
        ));
      }
    }
  }

  FutureOr<void> getTenantLoginSettings() async {
    if (state.username.isEmpty) {
      return;
    }

    final isOnline = await _checkStatusConnectionUsecase.call(NoParams());

    if (!isOnline) {
      return emit(
          state.copyWith(authenticationFlow: AuthenticationFlow.offline));
    }

    emit(
      state.copyWith(
        status: NetworkStatus.loading,
        errorType: null,
        authenticationFlow: AuthenticationFlow.unknown,
      ),
    );

    try {
      final tenantLogin = TenantLogin(
        tenantDomain: state.username.split('@')[1],
        userName: state.username,
      );
      final result = await _getTenantLoginSettingsUsecase(tenantLogin);

      final authenticationFlow = result.loginProviders.saml?.url != null
          ? AuthenticationFlow.saml
          : AuthenticationFlow.password;

      emit(state.copyWith(
        status: NetworkStatus.idle,
        tenantLoginSettings: result,
        errorType: null,
        authenticationFlow: authenticationFlow,
      ));
    } on TenantNotFoundException catch (_) {
      emit(state.copyWith(
        status: NetworkStatus.idle,
        tenantLoginSettings: null,
        errorType: ErrorType.tenantNotFound,
        authenticationFlow: AuthenticationFlow.unknown,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: NetworkStatus.idle,
        tenantLoginSettings: null,
        errorType: ErrorType.unknown,
        authenticationFlow: AuthenticationFlow.unknown,
      ));
    } finally {
      emit(state.copyWith(
        errorType: null,
      ));
    }
  }
}
