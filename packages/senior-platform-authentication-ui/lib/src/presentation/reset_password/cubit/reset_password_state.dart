part of 'reset_password_cubit.dart';

class ResetPasswordState extends Equatable {
  final bool biometricFlow;
  final NetworkStatus networkStatus;
  final String username;
  final String temporaryToken;
  final PasswordPolicySettings? passwordPolicySettings;
  final ErrorType? errorType;
  final AuthenticationResponse? authenticationResponse;

  const ResetPasswordState({
    required this.networkStatus,
    required this.username,
    required this.temporaryToken,
    this.passwordPolicySettings,
    this.errorType,
    this.biometricFlow = false,
    this.authenticationResponse,
  });

  factory ResetPasswordState.initial() {
    return const ResetPasswordState(
      networkStatus: NetworkStatus.idle,
      username: '',
      temporaryToken: '',
      biometricFlow: false,
    );
  }

  ResetPasswordState copyWith({
    NetworkStatus? networkStatus,
    String? username,
    String? temporaryToken,
    PasswordPolicySettings? passwordPolicySettings,
    ErrorType? errorType,
    bool biometricFlow = false,
    AuthenticationResponse? authenticationResponse,
  }) {
    return ResetPasswordState(
      networkStatus: networkStatus ?? this.networkStatus,
      username: username ?? this.username,
      temporaryToken: temporaryToken ?? this.temporaryToken,
      passwordPolicySettings:
          passwordPolicySettings ?? this.passwordPolicySettings,
      errorType: errorType,
      biometricFlow: biometricFlow,
      authenticationResponse:
          authenticationResponse ?? this.authenticationResponse,
    );
  }

  @override
  List<Object?> get props => [
        networkStatus,
        username,
        temporaryToken,
        passwordPolicySettings,
        errorType,
        biometricFlow,
        authenticationResponse
      ];
}
