part of 'saml_authentication_cubit.dart';

enum SAMLAuthenticationScreenStatus {
  onboarding,
  webview,
  loading,
  error,
  biometryFlow
}

class SAMLAuthenticationState extends Equatable {
  final SAMLAuthenticationScreenStatus status;
  final bool onboardingEnabled;
  final AuthenticationResponse? authenticationResponse;

  const SAMLAuthenticationState({
    required this.status,
    required this.onboardingEnabled,
    this.authenticationResponse,
  });

  factory SAMLAuthenticationState.initial() {
    return const SAMLAuthenticationState(
      status: SAMLAuthenticationScreenStatus.onboarding,
      onboardingEnabled: true,
    );
  }

  SAMLAuthenticationState copyWith({
    SAMLAuthenticationScreenStatus? status,
    bool? onboardingEnabled,
    AuthenticationResponse? authenticationResponse,
  }) {
    return SAMLAuthenticationState(
      status: status ?? this.status,
      onboardingEnabled: onboardingEnabled ?? this.onboardingEnabled,
      authenticationResponse:
          authenticationResponse ?? this.authenticationResponse,
    );
  }

  @override
  List<Object> get props => [
        status,
        onboardingEnabled,
      ];
}
