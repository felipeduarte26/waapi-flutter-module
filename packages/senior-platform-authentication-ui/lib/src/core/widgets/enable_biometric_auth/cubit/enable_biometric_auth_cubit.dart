import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../senior_platform_authentication_ui.dart';

part 'enable_biometric_auth_state.dart';

class EnableBiometricAuthCubit extends Cubit<EnableBiometricAuthState> {
  final BiometricAvailableUsecase _biometricAuthAvailableUseCase;
  final BiometricCanCheckUseCase _biometricAuthCanCheckUseCase;
  final AuthenticationBloc _authenticationBloc;

  EnableBiometricAuthCubit({
    required AuthenticationBloc authenticationBloc,
    required BiometricAvailableUsecase biometricAuthAvailableUseCase,
    required BiometricAuthenticateUsecase biometricAuthenticateUseCase,
    required BiometricCanCheckUseCase biometricAuthCanCheckUseCase,
  })  : _biometricAuthAvailableUseCase = biometricAuthAvailableUseCase,
        _biometricAuthCanCheckUseCase = biometricAuthCanCheckUseCase,
        _authenticationBloc = authenticationBloc,
        super(EnableBiometricAuthState.initial());

  void initialize() async {
    emit(
      state.copyWith(enableBiometricAuthStatus: BiometricAuthInfo.unknown),
    );
    if (SeniorAuthentication.enableBiometryOnly) {
      return emit(
        state.copyWith(
            enableBiometricAuthStatus: BiometricAuthInfo.getAvailableBiometrics,
            biometricsAreRegistered:
                (await _biometricAuthCanCheckUseCase(NoParams()) &&
                    await _biometricAuthAvailableUseCase(NoParams()))),
      );
    }
    return emit(
      state.copyWith(
        enableBiometricAuthStatus: BiometricAuthInfo.getAvailableBiometrics,
        biometricsAreRegistered: true,
      ),
    );
  }

  Future<void> biometricAuth({
    required AuthenticationResponse authenticationResponse,
  }) async {
    BiometryStatus biometryStatus = BiometryStatus.unknown;
    emit(
      state.copyWith(
        biometryStatus: BiometryStatus.authenticating,
      ),
    );
    biometryStatus =
        await _authenticationBloc.onAuthenticationBiometricAuthRequested();
    return emit(
      state.copyWith(
        biometryStatus: biometryStatus,
        enableBiometricAuthStatus: biometryStatus != BiometryStatus.success
            ? BiometricAuthInfo.biometricsNotRegistered
            : BiometricAuthInfo.getAvailableBiometrics,
      ),
    );
  }

  void biometricsAreRegistered() {
    return emit(
      state.copyWith(
        enableBiometricAuthStatus: BiometricAuthInfo.biometricsNotRegistered,
        biometricsAreRegistered: false,
      ),
    );
  }

  void authentication(
      {required AuthenticationResponse authenticationResponse,
      required BiometryStatus biometryStatus}) {
    _authenticationBloc.add(
      AuthenticationStatusChanged(
        AuthenticationStatus.authenticated,
        biometryStatus: biometryStatus,
        authenticationResponse: authenticationResponse,
      ),
    );
  }
}
