import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../blocs/dependent_bloc/dependent_bloc.dart';
import '../../../blocs/profile_bloc/profile_bloc.dart';
import 'personal_dependents_screen_event.dart';
import 'personal_dependents_screen_state.dart';

class PersonalDependentsScreenBloc extends Bloc<PersonalDependentsScreenEvent, PersonalDependentsScreenState> {
  final AuthorizationBloc authorizationBloc;
  final DependentBloc dependentBloc;
  final ProfileBloc profileBloc;

  late StreamSubscription dependentSubscription;
  late StreamSubscription authorizationSubscription;
  late StreamSubscription profileSubscription;

  PersonalDependentsScreenBloc({
    required this.authorizationBloc,
    required this.dependentBloc,
    required this.profileBloc,
  }) : super(
          CurrentPersonalDependentsScreenState(
            authorizationState: authorizationBloc.state,
            dependentState: dependentBloc.state,
            profileState: profileBloc.state,
          ),
        ) {
    on<ChangeProfileStateEvent>(_changeProfileMenuStateEvent);
    on<ChangeDependentBlocEvent>(_changeDependentBlocEvent);
    on<ChangeAuthorizationStateEvent>(_changeAuthorizationBlocEvent);

    dependentSubscription = dependentBloc.stream.listen((dependentState) {
      add(
        ChangeDependentBlocEvent(
          dependentState: dependentState,
        ),
      );
    });

    authorizationSubscription = authorizationBloc.stream.listen((authorizationState) {
      add(
        ChangeAuthorizationStateEvent(
          authorizationState: authorizationState,
        ),
      );
    });

    profileSubscription = profileBloc.stream.listen((profileState) {
      add(
        ChangeProfileStateEvent(
          profileState: profileState,
        ),
      );
    });
  }

  Future<void> _changeAuthorizationBlocEvent(
    ChangeAuthorizationStateEvent event,
    Emitter<PersonalDependentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        authorizationState: event.authorizationState,
      ),
    );
  }

  Future<void> _changeProfileMenuStateEvent(
    ChangeProfileStateEvent event,
    Emitter<PersonalDependentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        profileState: event.profileState,
      ),
    );
  }

  Future<void> _changeDependentBlocEvent(
    ChangeDependentBlocEvent event,
    Emitter<PersonalDependentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        dependentState: event.dependentState,
      ),
    );
  }
}
