// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_has_clocking_usecase.dart';
import '../../domain/usecases/save_has_clocking_usecase.dart';
import 'has_clocking_event.dart';
import 'has_clocking_state.dart';

class HasClockingBloc extends Bloc<HasClockingEvent, HasClockingState> {
  final GetHasClockingUsecase _getHasClockingUsecase;
  final SaveHasClockingUsecase _saveHasClockingUsecase;

  HasClockingBloc({
    required GetHasClockingUsecase getHasClockingUsecase,
    required SaveHasClockingUsecase saveHasClockingUsecase,
  })  : _getHasClockingUsecase = getHasClockingUsecase,
        _saveHasClockingUsecase = saveHasClockingUsecase,
        super(InitialClockingState()) {
    on<SetActiveHasClockingEvent>(_setActiveHasClockingEvent);
    on<SetInactiveHasClockingEvent>(_setInactiveHasClockingEvent);
    on<GetHasClockingEvent>(_getHasClockingEvent);
  }

  Future<void> _setActiveHasClockingEvent(
    SetActiveHasClockingEvent _,
    Emitter<HasClockingState> emit,
  ) async {
    emit(LoadingClockingState());

    final hasClocking = await _saveHasClockingUsecase.call(
      hasClocking: true,
    );

    hasClocking.fold(
      (left) => emit(LoadedClockingState(hasClocking: false)),
      (right) => emit(LoadedClockingState(hasClocking: true)),
    );
  }

  Future<void> _setInactiveHasClockingEvent(
    SetInactiveHasClockingEvent _,
    Emitter<HasClockingState> emit,
  ) async {
    emit(LoadingClockingState());

    final hasClocking = await _saveHasClockingUsecase.call(
      hasClocking: null,
    );

    hasClocking.fold(
      (left) => emit(LoadedClockingState(hasClocking: false)),
      (right) => emit(LoadedClockingState(hasClocking: false)),
    );
  }

  Future<void> _getHasClockingEvent(
    GetHasClockingEvent _,
    Emitter<HasClockingState> emit,
  ) async {
    emit(LoadingClockingState());

    final hasClocking = await _getHasClockingUsecase.call();

    hasClocking.fold(
      (left) {
        emit(LoadedClockingState(hasClocking: false));
      },
      (right) {
        emit(
          LoadedClockingState(hasClocking: right),
        );
      },
    );
  }
}
