import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/happiness_index/happiness_index_bloc.dart';
import '../../blocs/retrieve_all_reasons/retrieve_all_reasons_bloc.dart';
import 'happiness_index_screen_event.dart';
import 'happiness_index_screen_state.dart';

class HappinessIndexScreenBloc extends Bloc<HappinessIndexScreenEvent, HappinessIndexScreenState> {
  final HappinessIndexBloc happinessIndexBloc;
  final RetrieveAllReasonsBloc retrieveAllReasonsBloc;

  late StreamSubscription retrieveAllReasonsSubscription;
  late StreamSubscription happinessIndexSubscription;

  HappinessIndexScreenBloc({
    required this.happinessIndexBloc,
    required this.retrieveAllReasonsBloc,
  }) : super(
          CurrentHappinessIndexScreenState(
            happinessIndexState: happinessIndexBloc.state,
            retrieveAllReasonsState: retrieveAllReasonsBloc.state,
          ),
        ) {
    on<ChangeHappinessIndexStateEvent>(_changeHappinessIndexBlocEvent);
    on<ChangeRetrieveAllReasonsStateEvent>(_changeRetrieveAllReasonsBlocEvent);

    happinessIndexSubscription = happinessIndexBloc.stream.listen((happinessIndexState) {
      add(
        ChangeHappinessIndexStateEvent(
          happinessIndexState: happinessIndexState,
        ),
      );
    });

    retrieveAllReasonsSubscription = retrieveAllReasonsBloc.stream.listen((retrieveAllReasonsState) {
      add(
        ChangeRetrieveAllReasonsStateEvent(
          retrieveAllReasonsState: retrieveAllReasonsState,
        ),
      );
    });
  }

  Future<void> _changeHappinessIndexBlocEvent(
    ChangeHappinessIndexStateEvent event,
    Emitter<HappinessIndexScreenState> emit,
  ) async {
    emit(
      state.currentState(
        happinessIndexState: event.happinessIndexState,
      ),
    );
  }

  Future<void> _changeRetrieveAllReasonsBlocEvent(
    ChangeRetrieveAllReasonsStateEvent event,
    Emitter<HappinessIndexScreenState> emit,
  ) async {
    emit(
      state.currentState(
        retrieveAllReasonsState: event.retrieveAllReasonsState,
      ),
    );
  }

  @override
  Future<void> close() {
    happinessIndexSubscription.cancel();
    retrieveAllReasonsSubscription.cancel();
    return super.close();
  }
}
