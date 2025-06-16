part of 'authentication_bloc.dart';

/// Base authentication event class.
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthenticateKey extends AuthenticationEvent {
  final AuthenticationResponse authenticationResponse;

  const AuthenticateKey({required this.authenticationResponse});

  @override
  List<Object?> get props => [
        authenticationResponse,
      ];
}

class AuthenticationBiometricAuthRequested extends AuthenticationEvent {
  /// Flag that indicates if biometric authentication is enabled.
  final bool? biometricEnabled;

  final AuthenticationStatus status;

  const AuthenticationBiometricAuthRequested({
    this.biometricEnabled = false,
    this.status = AuthenticationStatus.authenticated,
  });

  @override
  List<Object?> get props => [
        biometricEnabled,
        status,
      ];
}

/// Fired everytime user's authentication status changes.
class AuthenticationStatusChanged extends AuthenticationEvent {
  /// Current user's authentication status.
  final AuthenticationStatus status;

  /// Authentication response must be passed when the status is
  /// [AuthenticationStatus.authenticated].
  final AuthenticationResponse? authenticationResponse;

  final BiometryStatus biometryStatus;

  final bool isKeyTokenAuthentication;

  const AuthenticationStatusChanged(
    this.status, {
    this.authenticationResponse,
    this.biometryStatus = BiometryStatus.unknown,
    this.isKeyTokenAuthentication = false,
  });

  @override
  List<Object?> get props => [
        status,
        authenticationResponse,
        biometryStatus,
      ];
}

/// Calls logout when login offline is disabled.
class LogoutOnlineRequested extends AuthenticationEvent {
  final bool eraseUserToken;
  final bool eraseKeyToken;

  const LogoutOnlineRequested({
    this.eraseUserToken = true,
    this.eraseKeyToken = false,
  });

  @override
  List<Object?> get props => [];
}

/// Calls logout when login offline is enabled.
class LogoutOfflineRequested extends AuthenticationEvent {
  /// Current username saved on storage.
  final String username;

  /// Flag that erase token from sotrage.
  final bool eraseUserToken;

  final bool eraseKeyToken;

  const LogoutOfflineRequested({
    required this.username,
    this.eraseUserToken = true,
    this.eraseKeyToken = false,
  });

  @override
  List<Object?> get props => [
        username,
        eraseUserToken,
        eraseKeyToken,
      ];
}

/// Check if the user has a valid authentication.
///
/// You must call this event as soon as you instantiate the authentication bloc
/// for the provider. See the documentation with examples for more details.
class CheckAuthenticationRequested extends AuthenticationEvent {
  /// Current username saved on storage.
  final String? username;
  final String? accesskey;
  final bool checkOnline;
  final bool checkKeyToken;

  final int? timestamp;

  const CheckAuthenticationRequested({
    this.username,
    this.accesskey,
    this.checkKeyToken = false,
    this.timestamp,
    this.checkOnline = true,
  });

  @override
  List<Object?> get props => [
        username,
        accesskey,
      ];
}

class CheckBiometricAuthenticationRequested extends AuthenticationEvent {
  final String? username;
  const CheckBiometricAuthenticationRequested({
     this.username,
  });

  @override
  List<Object?> get props => [
        username,
      ];
}

class ChangeAccessTokenAuthenticationRequested extends AuthenticationEvent {
  /// Current accesskey to save on bloc.
  final Token token;

  const ChangeAccessTokenAuthenticationRequested({
    required this.token,
  });

  @override
  List<Object?> get props => [
        token,
      ];
}

class ErrorAuthentication extends AuthenticationEvent {
  const ErrorAuthentication();

  @override
  List<Object?> get props => [];
}
