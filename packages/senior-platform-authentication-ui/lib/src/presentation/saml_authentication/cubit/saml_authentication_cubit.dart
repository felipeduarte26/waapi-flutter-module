import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../senior_platform_authentication_ui.dart';
import '../../../core/utils/preferences/domain/usecases/get_saml_onboarding_enabled_usecase.dart';
import '../../../core/utils/preferences/domain/usecases/store_saml_onboarding_enabled_usecase.dart';

part 'saml_authentication_state.dart';

class SAMLAuthenticationCubit extends Cubit<SAMLAuthenticationState> {
  final AuthenticationBloc _authenticationBloc;
  final StoreSAMLOnboardingEnabledUsecase _storeSAMLOnboardingEnabledUsecase;
  final GetSAMLOnboardingEnabledUsecase _getSAMLOnboardingEnabledUsecase;
  final GetAuthenticationResponseByTokenJsonUsecase
      _getAuthenticationResponseByTokenJsonUsecase;

  SAMLAuthenticationCubit({
    required authenticationBloc,
    required storeSAMLOnboardingEnabledUsecase,
    required getSAMLOnboardingEnabledUsecase,
    required getAuthenticationResponseByTokenJsonUsecase,
  })  : _authenticationBloc = authenticationBloc,
        _storeSAMLOnboardingEnabledUsecase = storeSAMLOnboardingEnabledUsecase,
        _getSAMLOnboardingEnabledUsecase = getSAMLOnboardingEnabledUsecase,
        _getAuthenticationResponseByTokenJsonUsecase =
            getAuthenticationResponseByTokenJsonUsecase,
        super(SAMLAuthenticationState.initial());

  void onCheckBoxMessageChanged(bool value) {
    emit(state.copyWith(onboardingEnabled: !value));
  }

  FutureOr<void> storeOnboardingEnabled() async {
    await _storeSAMLOnboardingEnabledUsecase(state.onboardingEnabled);

    emit(state.copyWith(status: SAMLAuthenticationScreenStatus.webview));
  }

  FutureOr<void> checkOnboardingEnabled() async {
    final isEnabled = await _getSAMLOnboardingEnabledUsecase(NoParams());

    emit(state.copyWith(
        status: isEnabled
            ? SAMLAuthenticationScreenStatus.onboarding
            : SAMLAuthenticationScreenStatus.webview));
  }

  Future<void> onSAMLAuthenticated(String tokenJson) async {
    if (state.status == SAMLAuthenticationScreenStatus.loading) {
      return;
    }

    emit(state.copyWith(
      status: SAMLAuthenticationScreenStatus.loading,
    ));

    try {
      final authenticationResponse =
          _getAuthenticationResponseByTokenJsonUsecase(tokenJson);
      // If whoever implemented the package, has enabled biometrics will enter the if, it will go up a modal asking if the user, who enables biometrics for the application.
      if (SeniorAuthentication.enableBiometry) {
        emit(state.copyWith(
          status: SAMLAuthenticationScreenStatus.biometryFlow,
          authenticationResponse: authenticationResponse,
        ));
      } else {
        _authenticationBloc.add(AuthenticationStatusChanged(
          AuthenticationStatus.authenticated,
          authenticationResponse: authenticationResponse,
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        status: SAMLAuthenticationScreenStatus.error,
      ));
    }
  }

  bool verifySeniorXCookies(Object cookies) {
    if (cookies is! String || cookies.isEmpty) {
      return false;
    }

    try {
      final result = cookies.split(';').firstWhere(
          (element) => element.contains('com.senior.token'),
          orElse: () => '');

      if (result.isEmpty) {
        return false;
      }

      final tokenCookie = Uri.decodeFull(result.split('=')[1]);
      log('TOKEN_COOKIE >>>> $tokenCookie');

      onSAMLAuthenticated(tokenCookie);
      return true;
    } catch (error) {
      log('VERIFY SENIORX COOKIES FAILED >>>> ${error.toString()}');
      return false;
    }
  }
}
