import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_gender_identity_usecase.dart';
import 'gender_identity_event.dart';
import 'gender_identity_state.dart';

class GenderIdentityBloc extends Bloc<GenderIdentityEvent, GenderIdentityState> {
  final GetGenderIdentityUsecase _getGenderIdentityUsecase;

  GenderIdentityBloc({
    required GetGenderIdentityUsecase getGenderIdentityUsecase,
  })  : _getGenderIdentityUsecase = getGenderIdentityUsecase,
        super(const InitialGenderIdentityState()) {
    on<GetGenderIdentityProfileEvent>(_getGenderIdentityEvent);
    on<ClearGenderIdentityProfileEvent>(_clearGenderIdentityProfileEvent);
    on<SelectGenderIdentityFromEntityToProfileEvent>(_selectGenderIdentityFromEntity);
    on<UnselectGenderIdentityFromEntityToProfileEvent>(_unselectGenderIdentityFromEntity);
  }

  Future<void> _clearGenderIdentityProfileEvent(
    ClearGenderIdentityProfileEvent _,
    Emitter<GenderIdentityState> emit,
  ) async {
    emit(state.initialGenderIdentityState());
  }

  Future<void> _getGenderIdentityEvent(
    GetGenderIdentityProfileEvent _,
    Emitter<GenderIdentityState> emit,
  ) async {
    emit(state.loadingGenderIdentityState());

    final genderIdentityList = await _getGenderIdentityUsecase.call();

    genderIdentityList.fold(
      (left) {
        emit(
          state.errorGenderIdentityState(
            message: left.message,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(state.emptyStateGenderIdentityState());
        } else {
          emit(
            state.loadedGenderIdentityState(
              genderIdentities: right,
            ),
          );
        }
      },
    );
  }

  Future<void> _selectGenderIdentityFromEntity(
    SelectGenderIdentityFromEntityToProfileEvent event,
    Emitter<GenderIdentityState> emit,
  ) async {
    emit(
      state.loadedSelectGenderIdentityState(
        genderIdentityEntity: event.genderIdentityEntity,
      ),
    );
  }

  Future<void> _unselectGenderIdentityFromEntity(
    UnselectGenderIdentityFromEntityToProfileEvent event,
    Emitter<GenderIdentityState> emit,
  ) async {
    emit(
      state.unselectGenderIdentityState(
        genderIdentityEntity: event.genderIdentityEntity,
      ),
    );
  }
}
