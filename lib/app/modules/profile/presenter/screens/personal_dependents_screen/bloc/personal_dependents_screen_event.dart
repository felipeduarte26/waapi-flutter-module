import 'package:equatable/equatable.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/dependent_bloc/dependent_state.dart';
import '../../../blocs/profile_bloc/profile_state.dart';

abstract class PersonalDependentsScreenEvent extends Equatable {}

class ChangeDependentBlocEvent extends PersonalDependentsScreenEvent {
  final DependentState dependentState;

  ChangeDependentBlocEvent({
    required this.dependentState,
  });

  @override
  List<Object?> get props {
    return [
      dependentState,
    ];
  }
}

class ChangeAuthorizationStateEvent extends PersonalDependentsScreenEvent {
  final AuthorizationState authorizationState;

  ChangeAuthorizationStateEvent({
    required this.authorizationState,
  });

  @override
  List<Object?> get props {
    return [
      authorizationState,
    ];
  }
}

class ChangeProfileStateEvent extends PersonalDependentsScreenEvent {
  final ProfileState profileState;

  ChangeProfileStateEvent({
    required this.profileState,
  });

  @override
  List<Object?> get props {
    return [
      profileState,
    ];
  }
}
