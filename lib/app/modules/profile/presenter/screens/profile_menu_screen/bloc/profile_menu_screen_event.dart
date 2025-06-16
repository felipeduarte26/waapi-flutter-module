import 'package:equatable/equatable.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/contract_employee_bloc/contract_employee_state.dart';
import '../../../blocs/person_bloc/person_state.dart';
import '../../../blocs/profile_bloc/profile_state.dart';

abstract class ProfileMenuScreenEvent extends Equatable {}

class ChangeProfileStateEvent extends ProfileMenuScreenEvent {
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

class ChangeContractEmployeeEvent extends ProfileMenuScreenEvent {
  final ContractEmployeeState contractEmployeeState;

  ChangeContractEmployeeEvent({
    required this.contractEmployeeState,
  });

  @override
  List<Object?> get props {
    return [
      contractEmployeeState,
    ];
  }
}

class ChangePersonStateEvent extends ProfileMenuScreenEvent {
  final PersonState personState;

  ChangePersonStateEvent({
    required this.personState,
  });

  @override
  List<Object?> get props {
    return [
      personState,
    ];
  }
}

class ChangeAuthorizationStateEvent extends ProfileMenuScreenEvent {
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
