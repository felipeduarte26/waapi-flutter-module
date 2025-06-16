import 'package:equatable/equatable.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

abstract class AuthenticationAnalyticsState extends Equatable {
  final AuthenticationStatus authenticationStatus;

  const AuthenticationAnalyticsState({
    required this.authenticationStatus,
  });

  @override
  List<Object?> get props {
    return [
      authenticationStatus,
    ];
  }
}

class AuthenticationUnknown extends AuthenticationAnalyticsState {
  const AuthenticationUnknown() : super(authenticationStatus: AuthenticationStatus.unknown);
}

class AuthenticationAuthenticated extends AuthenticationAnalyticsState {
  const AuthenticationAuthenticated() : super(authenticationStatus: AuthenticationStatus.authenticated);
}

class AuthenticationUnauthenticated extends AuthenticationAnalyticsState {
  const AuthenticationUnauthenticated() : super(authenticationStatus: AuthenticationStatus.unauthenticated);
}
