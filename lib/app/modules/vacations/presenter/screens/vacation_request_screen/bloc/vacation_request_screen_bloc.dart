import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../blocs/vacation_request/vacation_request_bloc.dart';
import '../../../blocs/vacations_bloc/vacations_bloc.dart';
import 'vacation_request_screen_event.dart';
import 'vacation_request_screen_state.dart';

class VacationRequestScreenBloc extends Bloc<VacationRequestScreenEvent, VacationRequestScreenState> {
  final VacationsBloc vacationsBloc;
  final VacationRequestBloc vacationRequestBloc;
  final AuthorizationBloc authorizationBloc;

  late StreamSubscription vacationsSubscription;
  late StreamSubscription vacationRequestSubscription;
  late StreamSubscription authorizationSubscription;

  VacationRequestScreenBloc({
    required this.vacationsBloc,
    required this.vacationRequestBloc,
    required this.authorizationBloc,
  }) : super(
          CurrentVacationRequestScreenState(
            vacationsState: vacationsBloc.state,
            vacationRequestState: vacationRequestBloc.state,
            authorizationState: authorizationBloc.state,
          ),
        ) {
    on<ChangeVacationRequestStateEvent>(_changeVacationRequestStateEvent);
    on<ChangeVacationStateEvent>(_changeVacationsStateEvent);
    on<ChangeAuthorizationStateEvent>(_changeAuthorizationStateEvent);

    vacationsSubscription = vacationsBloc.stream.listen(
      (vacationsState) {
        add(
          ChangeVacationStateEvent(
            vacationsState: vacationsState,
          ),
        );
      },
    );

    vacationRequestSubscription = vacationRequestBloc.stream.listen(
      (vacationRequestState) {
        add(
          ChangeVacationRequestStateEvent(
            vacationRequestState: vacationRequestState,
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

  Future<void> _changeVacationRequestStateEvent(
    ChangeVacationRequestStateEvent event,
    Emitter<VacationRequestScreenState> emit,
  ) async {
    emit(
      state.currentState(
        vacationRequestState: event.vacationRequestState,
      ),
    );
  }

  Future<void> _changeVacationsStateEvent(
    ChangeVacationStateEvent event,
    Emitter<VacationRequestScreenState> emit,
  ) async {
    emit(
      state.currentState(
        vacationsState: event.vacationsState,
      ),
    );
  }

  Future<void> _changeAuthorizationStateEvent(
    ChangeAuthorizationStateEvent event,
    Emitter<VacationRequestScreenState> emit,
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
    await vacationRequestSubscription.cancel();
    await authorizationSubscription.cancel();
    return super.close();
  }
}
