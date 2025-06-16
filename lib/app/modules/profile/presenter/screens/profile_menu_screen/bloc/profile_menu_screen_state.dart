import 'package:equatable/equatable.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/contract_employee_bloc/contract_employee_state.dart';
import '../../../blocs/person_bloc/person_state.dart';
import '../../../blocs/profile_bloc/profile_state.dart';

abstract class ProfileMenuScreenState extends Equatable {
  final ProfileState profileState;
  final ContractEmployeeState contractEmployeeState;
  final PersonState personState;
  final AuthorizationState authorizationState;

  const ProfileMenuScreenState({
    required this.profileState,
    required this.contractEmployeeState,
    required this.personState,
    required this.authorizationState,
  });

  CurrentProfileMenuScreenState currentState({
    ProfileState? profileState,
    ContractEmployeeState? contractEmployeeState,
    PersonState? personState,
    AuthorizationState? authorizationState,
  }) {
    return CurrentProfileMenuScreenState(
      profileState: profileState ?? this.profileState,
      contractEmployeeState: contractEmployeeState ?? this.contractEmployeeState,
      personState: personState ?? this.personState,
      authorizationState: authorizationState ?? this.authorizationState,
    );
  }

  @override
  List<Object?> get props {
    return [
      profileState,
      contractEmployeeState,
      personState,
      authorizationState,
    ];
  }
}

class CurrentProfileMenuScreenState extends ProfileMenuScreenState {
  const CurrentProfileMenuScreenState({
    required ProfileState profileState,
    required ContractEmployeeState contractEmployeeState,
    required PersonState personState,
    required AuthorizationState authorizationState,
  }) : super(
          profileState: profileState,
          contractEmployeeState: contractEmployeeState,
          personState: personState,
          authorizationState: authorizationState,
        );
}
