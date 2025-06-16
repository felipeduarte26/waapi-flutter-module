import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_sexual_orientation_usecase.dart';
import 'sexual_orientation_event.dart';
import 'sexual_orientation_state.dart';

class SexualOrientationBloc extends Bloc<SexualOrientationEvent, SexualOrientationState> {
  final GetSexualOrientationUsecase _getSexualOrientationUsecase;

  SexualOrientationBloc({
    required GetSexualOrientationUsecase getSexualOrientationUsecase,
  })  : _getSexualOrientationUsecase = getSexualOrientationUsecase,
        super(const InitialSexualOrientationState()) {
    on<GetSexualOrientationProfileEvent>(_getSexualOrientationEvent);
    on<ClearSexualOrientationProfileEvent>(_clearSexualOrientationProfileEvent);
    on<SelectSexualOrientationFromEntityToProfileEvent>(_selectSexualOrientationFromEntity);
    on<UnselectSexualOrientationFromEntityToProfileEvent>(_unselectSexualOrientationFromEntity);
  }

  Future<void> _clearSexualOrientationProfileEvent(
    ClearSexualOrientationProfileEvent _,
    Emitter<SexualOrientationState> emit,
  ) async {
    emit(state.initialSexualOrientationState());
  }

  Future<void> _getSexualOrientationEvent(
    GetSexualOrientationProfileEvent _,
    Emitter<SexualOrientationState> emit,
  ) async {
    emit(state.loadingSexualOrientationState());

    final genderIdentityList = await _getSexualOrientationUsecase.call();

    genderIdentityList.fold(
      (left) {
        emit(
          state.errorSexualOrientationState(
            message: left.message,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(state.emptyStateSexualOrientationState());
        } else {
          emit(
            state.loadedSexualOrientationState(
              sexualOrientations: right,
            ),
          );
        }
      },
    );
  }

  Future<void> _selectSexualOrientationFromEntity(
    SelectSexualOrientationFromEntityToProfileEvent event,
    Emitter<SexualOrientationState> emit,
  ) async {
    emit(
      state.loadedSelectSexualOrientationState(
        sexualOrientationEntity: event.genderIdentityEntity,
      ),
    );
  }

  Future<void> _unselectSexualOrientationFromEntity(
    UnselectSexualOrientationFromEntityToProfileEvent event,
    Emitter<SexualOrientationState> emit,
  ) async {
    emit(
      state.unselectSexualOrientationState(
        sexualOrientationEntity: event.genderIdentityEntity,
      ),
    );
  }
}
