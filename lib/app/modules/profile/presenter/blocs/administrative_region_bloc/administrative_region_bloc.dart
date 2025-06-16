import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_administrative_region_usecase.dart';
import 'administrative_region_event.dart';
import 'administrative_region_state.dart';

class AdministrativeRegionBloc extends Bloc<AdministrativeRegionEvent, AdministrativeRegionState> {
  final GetAdministrativeRegionUsecase _getAdministrativeRegionUsecase;

  AdministrativeRegionBloc({
    required GetAdministrativeRegionUsecase getAdministrativeRegionUsecase,
  })  : _getAdministrativeRegionUsecase = getAdministrativeRegionUsecase,
        super(const InitialAdministrativeRegionState()) {
    on<GetAdministrativeRegionProfileEvent>(_getAdministrativeRegion);
    on<ClearAdministrativeRegionProfileEvent>(_clearAdministrativeRegionProfileEvent);
    on<SelectAdministrativeRegionFromEntityToProfileEvent>(_selectAdministrativeRegionFromEntity);
    on<UnselectAdministrativeRegionFromEntityToProfileEvent>(_unselectAdministrativeRegionFromEntity);
  }

  Future<void> _clearAdministrativeRegionProfileEvent(
    ClearAdministrativeRegionProfileEvent _,
    Emitter<AdministrativeRegionState> emit,
  ) async {
    emit(state.initialAdministrativeRegionState());
  }

  Future<void> _getAdministrativeRegion(
    GetAdministrativeRegionProfileEvent event,
    Emitter<AdministrativeRegionState> emit,
  ) async {
    emit(state.loadingAdministrativeRegionState());

    final administrativeRegionList = await _getAdministrativeRegionUsecase.call(
      cityId: event.cityId,
    );

    administrativeRegionList.fold(
      (left) {
        emit(
          state.errorAdministrativeRegionState(
            message: left.message,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(state.emptyStateAdministrativeRegionState());
        } else {
          emit(
            state.loadedAdministrativeRegionState(
              administrativeRegionList: right,
            ),
          );
        }
      },
    );
  }

  Future<void> _selectAdministrativeRegionFromEntity(
    SelectAdministrativeRegionFromEntityToProfileEvent event,
    Emitter<AdministrativeRegionState> emit,
  ) async {
    emit(
      state.loadedSelectAdministrativeRegionState(
        administrativeRegionEntity: event.administrativeRegionEntity,
      ),
    );
  }

  Future<void> _unselectAdministrativeRegionFromEntity(
    UnselectAdministrativeRegionFromEntityToProfileEvent event,
    Emitter<AdministrativeRegionState> emit,
  ) async {
    emit(
      state.unselectAdministrativeRegionState(
        administrativeRegionEntity: event.administrativeRegionEntity,
      ),
    );
  }
}
