import 'package:equatable/equatable.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../../core/utils/constants.dart';

class KeyAuthenticationState extends Equatable {
  final NetworkStatus status;
  final String tenantName;
  final String accessKey;
  final String secret;
  final bool domainOK;
  final bool accessKeyOK;
  final bool secretOK;
  final KeyAuthenticationFlow keyAuthenticationFlow;
  final AuthenticationResponse? authenticationResponse;
  final TenantLoginSettings? tenantLoginSettings;
  final ErrorType? errorType;

  const KeyAuthenticationState({
    required this.status,
    required this.tenantName,
    required this.accessKey,
    required this.secret,
    required this.keyAuthenticationFlow,
    this.authenticationResponse,
    this.tenantLoginSettings,
    this.errorType,
    this.accessKeyOK = false,
    this.domainOK = false,
    this.secretOK = false,
  });

  factory KeyAuthenticationState.initial() {
    return const KeyAuthenticationState(
      status: NetworkStatus.idle,
      accessKey: '',
      tenantName: '',
      secret: '',
      keyAuthenticationFlow: KeyAuthenticationFlow.unknown,
    );
  }

  KeyAuthenticationState copyWith({
    NetworkStatus? status,
    String? tenantName,
    String? accessKey,
    String? secret,
    KeyAuthenticationFlow? keyAuthenticationFlow,
    TenantLoginSettings? tenantLoginSettings,
    AuthenticationResponse? authenticationResponse,
    ErrorType? errorType,
    bool? domainOK,
    bool? accessKeyOK,
    bool? secretOK,
  }) {
    return KeyAuthenticationState(
      status: status ?? this.status,
      tenantName: tenantName ?? this.tenantName,
      accessKey: accessKey ?? this.accessKey,
      secret: secret ?? this.secret,
      keyAuthenticationFlow:
          keyAuthenticationFlow ?? this.keyAuthenticationFlow,
      tenantLoginSettings: tenantLoginSettings ?? this.tenantLoginSettings,
      authenticationResponse:
          authenticationResponse ?? this.authenticationResponse,
      errorType: errorType,
      domainOK: domainOK ?? this.domainOK,
      accessKeyOK: accessKeyOK ?? this.accessKeyOK,
      secretOK: secretOK ?? this.secretOK,
    );
  }

  @override
  List<Object?> get props => [
        status,
        tenantName,
        accessKey,
        secret,
        keyAuthenticationFlow,
        tenantLoginSettings,
        authenticationResponse,
        errorType,
        domainOK,
        secretOK,
        accessKeyOK,
      ];
}
