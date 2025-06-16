part of 'enable_biometric_auth_cubit.dart';

enum BiometricAuthInfo {
  unknown,
  biometricsNotRegistered,
  getAvailableBiometrics,
}

class EnableBiometricAuthState extends Equatable {
  final BiometricAuthInfo enableBiometricAuthStatus;
  final bool biometricsAreRegistered;
  final BiometryStatus biometryStatus;

  const EnableBiometricAuthState({
    required this.enableBiometricAuthStatus,
    this.biometricsAreRegistered = false,
    this.biometryStatus = BiometryStatus.unknown,
  });

  factory EnableBiometricAuthState.initial() {
    return const EnableBiometricAuthState(
      enableBiometricAuthStatus: BiometricAuthInfo.unknown,
      biometricsAreRegistered: false,
    );
  }

  EnableBiometricAuthState copyWith({
    BiometricAuthInfo? enableBiometricAuthStatus,
    bool? biometricsAreRegistered,
    BiometryStatus? biometryStatus,
  }) {
    return EnableBiometricAuthState(
      enableBiometricAuthStatus:
          enableBiometricAuthStatus ?? this.enableBiometricAuthStatus,
      biometricsAreRegistered:
          biometricsAreRegistered ?? this.biometricsAreRegistered,
      biometryStatus: biometryStatus ?? this.biometryStatus,
    );
  }

  @override
  List<Object> get props => [
        enableBiometricAuthStatus,
        biometricsAreRegistered,
        biometryStatus,
      ];
}
