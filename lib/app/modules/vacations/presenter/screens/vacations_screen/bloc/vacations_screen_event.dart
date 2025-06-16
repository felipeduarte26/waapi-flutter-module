import 'package:equatable/equatable.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/vacations_bloc/vacations_state.dart';

abstract class VacationsScreenEvent extends Equatable {}

class ChangeVacationsStateEvent extends VacationsScreenEvent {
  final VacationsState vacationsState;

  ChangeVacationsStateEvent({
    required this.vacationsState,
  });

  @override
  List<Object?> get props {
    return [
      vacationsState,
    ];
  }
}

class ChangeAuthorizationStateEvent extends VacationsScreenEvent {
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
