// Authentication library [senior_authentication] does not provide
// a state where is possible to identify the status of sign out process
// so this enum was created to be used in situations where the
// user will try to sign out and UI needs to indicate that the request is
// loading
import 'package:equatable/equatable.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

abstract class SignOutState extends Equatable {
  final AuthenticationState authenticationState;
  final SignOutStatusEnum signOutStatus;

  const SignOutState({
    required this.authenticationState,
    required this.signOutStatus,
  });

  CurrentSignOutState currentState({
    AuthenticationState? authenticationState,
    SignOutStatusEnum? signOutStatus,
  }) {
    return CurrentSignOutState(
      authenticationState: authenticationState ?? this.authenticationState,
      signOutStatus: signOutStatus ?? this.signOutStatus,
    );
  }

  @override
  List<Object?> get props {
    return [
      authenticationState,
      signOutStatus,
    ];
  }
}

class CurrentSignOutState extends SignOutState {
  const CurrentSignOutState({
    required AuthenticationState authenticationState,
    required SignOutStatusEnum signOutStatus,
  }) : super(
          authenticationState: authenticationState,
          signOutStatus: signOutStatus,
        );
}

enum SignOutStatusEnum {
  initial,
  loading,
  error,
  signOut,
}
