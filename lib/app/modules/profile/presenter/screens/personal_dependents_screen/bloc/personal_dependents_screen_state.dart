import 'package:equatable/equatable.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/dependent_bloc/dependent_state.dart';
import '../../../blocs/profile_bloc/profile_state.dart';

abstract class PersonalDependentsScreenState extends Equatable {
  final ProfileState profileState;
  final AuthorizationState authorizationState;
  final DependentState dependentState;

  const PersonalDependentsScreenState({
    required this.profileState,
    required this.dependentState,
    required this.authorizationState,
  });

  CurrentPersonalDependentsScreenState currentState({
    ProfileState? profileState,
    DependentState? dependentState,
    AuthorizationState? authorizationState,
  }) {
    return CurrentPersonalDependentsScreenState(
      authorizationState: authorizationState ?? this.authorizationState,
      dependentState: dependentState ?? this.dependentState,
      profileState: profileState ?? this.profileState,
    );
  }

  @override
  List<Object?> get props {
    return [
      profileState,
      dependentState,
      authorizationState,
    ];
  }
}

class CurrentPersonalDependentsScreenState extends PersonalDependentsScreenState {
  const CurrentPersonalDependentsScreenState({
    required final AuthorizationState authorizationState,
    required final DependentState dependentState,
    required final ProfileState profileState,
  }) : super(
          dependentState: dependentState,
          authorizationState: authorizationState,
          profileState: profileState,
        );
}
