import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../blocs/contract_employee_bloc/contract_employee_bloc.dart';
import '../../../blocs/person_bloc/person_bloc.dart';
import '../../../blocs/profile_bloc/profile_bloc.dart';
import 'profile_menu_screen_event.dart';
import 'profile_menu_screen_state.dart';

class ProfileMenuScreenBloc extends Bloc<ProfileMenuScreenEvent, ProfileMenuScreenState> {
  final ProfileBloc profileBloc;
  final ContractEmployeeBloc contractEmployeeBloc;
  final PersonBloc personBloc;
  final AuthorizationBloc authorizationBloc;

  late StreamSubscription profileSubscription;
  late StreamSubscription contractEmployeeSubscription;
  late StreamSubscription personSubscription;
  late StreamSubscription authorizationSubscription;

  ProfileMenuScreenBloc({
    required this.profileBloc,
    required this.contractEmployeeBloc,
    required this.personBloc,
    required this.authorizationBloc,
  }) : super(
          CurrentProfileMenuScreenState(
            profileState: profileBloc.state,
            contractEmployeeState: contractEmployeeBloc.state,
            personState: personBloc.state,
            authorizationState: authorizationBloc.state,
          ),
        ) {
    on<ChangeProfileStateEvent>(_changeProfileStateEvent);
    on<ChangeContractEmployeeEvent>(_changeContractEmployeeEvent);
    on<ChangePersonStateEvent>(_changePersonStateEvent);
    on<ChangeAuthorizationStateEvent>(_changeAuthorizationEvent);

    profileSubscription = profileBloc.stream.listen(
      (profileState) {
        add(
          ChangeProfileStateEvent(
            profileState: profileState,
          ),
        );
      },
    );

    contractEmployeeSubscription = contractEmployeeBloc.stream.listen(
      (contractEmployeeState) {
        add(
          ChangeContractEmployeeEvent(
            contractEmployeeState: contractEmployeeState,
          ),
        );
      },
    );

    personSubscription = personBloc.stream.listen(
      (personState) {
        add(
          ChangePersonStateEvent(
            personState: personState,
          ),
        );
      },
    );

    authorizationSubscription = authorizationBloc.stream.listen(
      (authorizationState) {
        add(
          ChangeAuthorizationStateEvent(
            authorizationState: authorizationState,
          ),
        );
      },
    );
  }

  Future<void> _changeProfileStateEvent(
    ChangeProfileStateEvent event,
    Emitter<ProfileMenuScreenState> emit,
  ) async {
    emit(
      state.currentState(
        profileState: event.profileState,
      ),
    );
  }

  Future<void> _changeContractEmployeeEvent(
    ChangeContractEmployeeEvent event,
    Emitter<ProfileMenuScreenState> emit,
  ) async {
    emit(
      state.currentState(
        contractEmployeeState: event.contractEmployeeState,
      ),
    );
  }

  Future<void> _changePersonStateEvent(
    ChangePersonStateEvent event,
    Emitter<ProfileMenuScreenState> emit,
  ) async {
    emit(
      state.currentState(
        personState: event.personState,
      ),
    );
  }

  Future<void> _changeAuthorizationEvent(
    ChangeAuthorizationStateEvent event,
    Emitter<ProfileMenuScreenState> emit,
  ) async {
    emit(
      state.currentState(
        authorizationState: event.authorizationState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await profileSubscription.cancel();
    await contractEmployeeSubscription.cancel();
    await personSubscription.cancel();
    await authorizationSubscription.cancel();
    return super.close();
  }
}
