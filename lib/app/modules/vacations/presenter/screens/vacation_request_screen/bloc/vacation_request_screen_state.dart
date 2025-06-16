import 'package:equatable/equatable.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/vacation_request/vacation_request_bloc.dart';
import '../../../blocs/vacations_bloc/vacations_state.dart';

abstract class VacationRequestScreenState extends Equatable {
  final VacationsState vacationsState;
  final VacationRequestState vacationRequestState;
  final AuthorizationState authorizationState;

  const VacationRequestScreenState({
    required this.vacationsState,
    required this.vacationRequestState,
    required this.authorizationState,
  });

  CurrentVacationRequestScreenState currentState({
    VacationsState? vacationsState,
    VacationRequestState? vacationRequestState,
    AuthorizationState? authorizationState,
  }) {
    return CurrentVacationRequestScreenState(
      vacationsState: vacationsState ?? this.vacationsState,
      vacationRequestState: vacationRequestState ?? this.vacationRequestState,
      authorizationState: authorizationState ?? this.authorizationState,
    );
  }

  @override
  List<Object?> get props {
    return [
      vacationsState,
      vacationRequestState,
      authorizationState,
    ];
  }
}

class CurrentVacationRequestScreenState extends VacationRequestScreenState {
  const CurrentVacationRequestScreenState({
    required VacationsState vacationsState,
    required VacationRequestState vacationRequestState,
    required AuthorizationState authorizationState,
  }) : super(
          vacationsState: vacationsState,
          vacationRequestState: vacationRequestState,
          authorizationState: authorizationState,
        );
}
