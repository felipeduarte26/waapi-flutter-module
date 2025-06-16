import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_disability_usecase.dart';
import 'disability_event.dart';
import 'disability_state.dart';

class DisabilityBloc extends Bloc<DisabilityEvent, DisabilityState> {
  final GetDisabilityUsecase _getDisabilityUsecase;

  DisabilityBloc({
    required GetDisabilityUsecase getDisabilityUsecase,
  })  : _getDisabilityUsecase = getDisabilityUsecase,
        super(const InitialDisabilityState()) {
    on<DisabilityProfileEvent>(_getDisability);
    on<ClearDisabilityProfileEvent>(_clearDisabilityProfileEvent);
    on<SelectDisabilityFromEntityToProfileEvent>(_selectDisabilityFromEntity);
    on<UnselectDisabilityFromEntityToProfileEvent>(_unselectDisabilityFromEntity);
  }

  Future<void> _clearDisabilityProfileEvent(
    ClearDisabilityProfileEvent _,
    Emitter<DisabilityState> emit,
  ) async {
    emit(state.initialDisabilityState());
  }

  Future<void> _getDisability(
    DisabilityProfileEvent _,
    Emitter<DisabilityState> emit,
  ) async {
    emit(state.loadingDisabilityState());

    final disabilityList = await _getDisabilityUsecase.call();

    disabilityList.fold(
      (left) {
        emit(
          state.errorDisabilityState(
            message: left.message,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(state.emptyStateDisabilityState());
        } else {
          emit(
            state.loadedDisabilityState(
              disabilityList: right,
            ),
          );
        }
      },
    );
  }

  Future<void> _selectDisabilityFromEntity(
    SelectDisabilityFromEntityToProfileEvent event,
    Emitter<DisabilityState> emit,
  ) async {
    emit(
      state.loadedSelectDisabilityState(
        disabilityEntity: event.disabilityEntity,
      ),
    );
  }

  Future<void> _unselectDisabilityFromEntity(
    UnselectDisabilityFromEntityToProfileEvent event,
    Emitter<DisabilityState> emit,
  ) async {
    emit(
      state.unselectDisabilityState(
        disabilityEntity: event.disabilityEntity,
      ),
    );
  }
}
