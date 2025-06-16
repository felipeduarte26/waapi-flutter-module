part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  /// Current authentication status
  ///
  /// Default value is [AuthenticationStatus.unknown] when app is initializing.
  final AuthenticationStatus status;

  /// Current username saved on memory.
  final String? username;

  /// Current biometry status.
  final BiometryStatus biometryStatus;

  /// Current token for authentication.
  final Token? token;

  /// Current application key for authentication.
  final Token? keyToken;

  final int? timestamp;

  final String? integrationUser;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.username,
    this.biometryStatus = BiometryStatus.unknown,
    this.token,
    this.keyToken,
    this.timestamp,
    this.integrationUser,
  });

  /// Unkown authentication state.
  ///
  /// It means that the application doesn't know yet the status of authentication.
  const AuthenticationState.unknown() : this._();

  /// Authenticated authentication state.
  ///
  /// The state that is emitted when the authentication status changed to
  /// authenticated.
  const AuthenticationState.authenticated({
    String? username,
    BiometryStatus biometryStatus = BiometryStatus.unknown,
    Token? token,
    Token? keyToken,
    int? timestamp,
    String? integrationUser,
  }) : this._(
          status: AuthenticationStatus.authenticated,
          biometryStatus: biometryStatus,
          username: username,
          token: token,
          keyToken: keyToken,
          timestamp: timestamp,
          integrationUser: integrationUser,
        );

  /// Unauthenticated authentication state.
  ///
  /// The state that is emitted when the authentication status changed to
  /// unauthenticated.
  const AuthenticationState.unauthenticated({
    BiometryStatus biometryStatus = BiometryStatus.unknown,
    Token? keyToken,
    Token? token,
    int? timestamp,
    String? integrationUser,
  }) : this._(
          status: AuthenticationStatus.unauthenticated,
          username: null,
          biometryStatus: biometryStatus,
          token: token,
          keyToken: keyToken,
          timestamp: timestamp,
          integrationUser: integrationUser,
        );

  /// Offline authentication state.
  ///
  /// The state that is emitted when the connection to network is lost.
  const AuthenticationState.offline(
    String username, {
    Token? token,
    Token? keyToken,
    BiometryStatus biometryStatus = BiometryStatus.unknown,
    String? integrationUser,
  }) : this._(
          status: AuthenticationStatus.offline,
          username: username,
          token: token,
          keyToken: keyToken,
          biometryStatus: biometryStatus,
          integrationUser: integrationUser,
        );

  @override
  List<Object?> get props => [
        status,
        username,
        timestamp,
      ];
}
