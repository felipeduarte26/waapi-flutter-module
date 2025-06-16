import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../blocs/vacations_bloc/vacations_bloc.dart';
import 'vacations_screen_event.dart';
import 'vacations_screen_state.dart';

class VacationsScreenBloc extends Bloc<VacationsScreenEvent, VacationsScreenState> {
  final VacationsBloc vacationsBloc;
  final AuthorizationBloc authorizationBloc;

  late StreamSubscription vacationsSubscription;
  late StreamSubscription authorizationSubscription;

  VacationsScreenBloc({
    required this.vacationsBloc,
    required this.authorizationBloc,
  }) : super(
          CurrentVacationsScreenState(
            vacationsState: vacationsBloc.state,
            authorizationState: authorizationBloc.state,
          ),
        ) {
    on<ChangeVacationsStateEvent>(_changeVacationsStateEvent);
    on<ChangeAuthorizationStateEvent>(_changeAuthorizationStateEvent);

    vacationsSubscription = vacationsBloc.stream.listen(
      (vacationsState) {
        add(
          ChangeVacationsStateEvent(
            vacationsState: vacationsState,
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

  Future<void> _changeVacationsStateEvent(
    ChangeVacationsStateEvent event,
    Emitter<VacationsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        vacationsState: event.vacationsState,
      ),
    );
  }

  Future<void> _changeAuthorizationStateEvent(
    ChangeAuthorizationStateEvent event,
    Emitter<VacationsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        authorizationState: event.authorizationState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await vacationsSubscription.cancel();
    await authorizationSubscription.cancel();
    return super.close();
  }
}
