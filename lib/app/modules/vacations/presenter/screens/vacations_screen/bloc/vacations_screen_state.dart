import 'package:equatable/equatable.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/vacations_bloc/vacations_state.dart';

abstract class VacationsScreenState extends Equatable {
  final VacationsState vacationsState;
  final AuthorizationState authorizationState;

  const VacationsScreenState({
    required this.vacationsState,
    required this.authorizationState,
  });

  CurrentVacationsScreenState currentState({
    VacationsState? vacationsState,
    AuthorizationState? authorizationState,
  }) {
    return CurrentVacationsScreenState(
      vacationsState: vacationsState ?? this.vacationsState,
      authorizationState: authorizationState ?? this.authorizationState,
    );
  }

  @override
  List<Object?> get props {
    return [
      vacationsState,
      authorizationState,
    ];
  }
}

class CurrentVacationsScreenState extends VacationsScreenState {
  const CurrentVacationsScreenState({
    required VacationsState vacationsState,
    required AuthorizationState authorizationState,
  }) : super(
          vacationsState: vacationsState,
          authorizationState: authorizationState,
        );
}
