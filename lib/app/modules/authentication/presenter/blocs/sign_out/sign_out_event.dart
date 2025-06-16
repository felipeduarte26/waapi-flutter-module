import 'package:equatable/equatable.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

abstract class SignOutEvent extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class RequestSignOutEvent extends SignOutEvent {}

class RequestSignOutOfflineEvent extends SignOutEvent {}

class ChangeAuthenticationStateEvent extends SignOutEvent {
  final AuthenticationState authenticationState;

  ChangeAuthenticationStateEvent({
    required this.authenticationState,
  });

  @override
  List<Object?> get props {
    return [
      authenticationState,
    ];
  }
}
