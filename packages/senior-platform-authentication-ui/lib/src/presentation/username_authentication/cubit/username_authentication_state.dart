part of 'username_authentication_cubit.dart';

class UserNameAuthenticationState extends Equatable {
  final NetworkStatus status;
  final String username;
  final String password;
  final AuthenticationFlow authenticationFlow;
  final TenantLoginSettings? tenantLoginSettings;
  final AuthenticationResponse? authenticationResponse;
  final ErrorType? errorType;
  final MFAInfo? mfaInfo;
  final bool? biometryFlow;

  const UserNameAuthenticationState({
    required this.status,
    required this.username,
    required this.password,
    required this.authenticationFlow,
    this.tenantLoginSettings,
    this.authenticationResponse,
    this.mfaInfo,
    this.errorType,
    this.biometryFlow = false,
  });

  factory UserNameAuthenticationState.initial() {
    return const UserNameAuthenticationState(
      status: NetworkStatus.idle,
      username: '',
      password: '',
      authenticationFlow: AuthenticationFlow.unknown,
      biometryFlow: false,
    );
  }

  UserNameAuthenticationState copyWith({
    NetworkStatus? status,
    String? username,
    String? password,
    AuthenticationFlow? authenticationFlow,
    TenantLoginSettings? tenantLoginSettings,
    AuthenticationResponse? authenticationResponse,
    MFAInfo? mfaInfo,
    ErrorType? errorType,
    bool? biometryFlow,
  }) {
    return UserNameAuthenticationState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      authenticationFlow: authenticationFlow ?? this.authenticationFlow,
      tenantLoginSettings: tenantLoginSettings ?? this.tenantLoginSettings,
      authenticationResponse:
          authenticationResponse ?? this.authenticationResponse,
      mfaInfo: mfaInfo,
      errorType: errorType,
      biometryFlow: biometryFlow ?? this.biometryFlow,
    );
  }

  @override
  List<Object?> get props => [
        status,
        username,
        password,
        authenticationFlow,
        tenantLoginSettings,
        authenticationResponse,
        mfaInfo,
        errorType,
        biometryFlow,
      ];
}
