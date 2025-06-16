part of 'mfa_authentication_code_cubit.dart';

enum MFAAuthenticationStatus {
  unknown,
  notConfigured,
  configured,
  changedByADM,
  emailSended,
  biometryFlow
}

class MFAAuthenticationState extends Equatable {
  final MFAAuthenticationStatus mfaStatus;
  final MFAInfo mfaInfo;
  final NetworkStatus status;
  final String email;
  final ErrorType? errorType;
  final AuthenticationResponse? authenticationResponse;
  final String? username;

  const MFAAuthenticationState({
    required this.mfaStatus,
    required this.status,
    required this.mfaInfo,
    required this.email,
    this.errorType,
    this.authenticationResponse,
    this.username,
  });

  factory MFAAuthenticationState.initial() {
    return const MFAAuthenticationState(
      mfaStatus: MFAAuthenticationStatus.unknown,
      status: NetworkStatus.idle,
      mfaInfo: MFAInfo(),
      email: '',
      username: '',
    );
  }

  MFAAuthenticationState copyWith({
    MFAAuthenticationStatus? mfaStatus,
    NetworkStatus? status,
    MFAInfo? mfaInfo,
    String? email,
    ErrorType? errorType,
    AuthenticationResponse? authenticationResponse,
    String? username,
  }) {
    return MFAAuthenticationState(
      mfaStatus: mfaStatus ?? this.mfaStatus,
      status: status ?? this.status,
      mfaInfo: mfaInfo ?? this.mfaInfo,
      email: email ?? this.email,
      errorType: errorType,
      authenticationResponse:
          authenticationResponse ?? this.authenticationResponse,
          username: username ?? this.username,
    );
  }

  @override
  List<Object?> get props => [
        mfaStatus,
        status,
        mfaInfo,
        email,
        errorType,
        authenticationResponse,
        username
      ];
}
