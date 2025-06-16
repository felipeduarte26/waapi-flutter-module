import 'package:equatable/equatable.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/vacation_request/vacation_request_bloc.dart';
import '../../../blocs/vacations_bloc/vacations_state.dart';

abstract class VacationRequestScreenEvent extends Equatable {}

class ChangeVacationStateEvent extends VacationRequestScreenEvent {
  final VacationsState vacationsState;

  ChangeVacationStateEvent({
    required this.vacationsState,
  });

  @override
  List<Object?> get props {
    return [
      vacationsState,
    ];
  }
}

class ChangeVacationRequestStateEvent extends VacationRequestScreenEvent {
  final VacationRequestState vacationRequestState;

  ChangeVacationRequestStateEvent({
    required this.vacationRequestState,
  });

  @override
  List<Object?> get props {
    return [
      vacationRequestState,
    ];
  }
}

class ChangeAuthorizationStateEvent extends VacationRequestScreenEvent {
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
