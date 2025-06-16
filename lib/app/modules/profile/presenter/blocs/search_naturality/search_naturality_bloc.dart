import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/search_naturality_usecase.dart';
import 'search_naturality_bloc_event_transformer.dart';
import 'search_naturality_event.dart';
import 'search_naturality_state.dart';

class SearchNaturalityBloc extends Bloc<SearchNaturalityEvent, SearchNaturalityState> {
  final SearchNaturalityUsecase _searchNaturalityUsecase;

  SearchNaturalityBloc({
    required SearchNaturalityUsecase searchNaturalityUsecase,
  })  : _searchNaturalityUsecase = searchNaturalityUsecase,
        super(const InitialSearchNaturalityState()) {
    on<SearchNaturalityProfileEvent>(
      _searchNaturality,
      transformer: debounce(
        const Duration(
          milliseconds: 300,
        ),
      ),
    );

    on<ClearSearchNaturalityProfileEvent>(_clearSearchNaturalityProfileEvent);
    on<SelectNaturalityFromEntityToProfileEvent>(_selectNaturalityFromEntity);
  }

  Future<void> _clearSearchNaturalityProfileEvent(
    ClearSearchNaturalityProfileEvent _,
    Emitter<SearchNaturalityState> emit,
  ) async {
    emit(state.initialSearchNaturalityState());
  }

  Future<void> _searchNaturality(
    SearchNaturalityProfileEvent event,
    Emitter<SearchNaturalityState> emit,
  ) async {
    final bool isInvalidName = event.search.trim().length < 3;

    if (isInvalidName) {
      emit(state.initialSearchNaturalityState());
      return;
    }

    emit(state.loadingSearchNaturalityState());

    final naturalityList = await _searchNaturalityUsecase.call(
      naturality: event.search,
    );

    naturalityList.fold(
      (left) {
        emit(
          state.errorSearchNaturalityState(
            message: left.message,
            search: event.search,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(state.emptyStateSearchNaturalityState());
        } else {
          emit(
            state.loadedSearchNaturalityState(
              naturalityList: right,
            ),
          );
        }
      },
    );
  }

  Future<void> _selectNaturalityFromEntity(
    SelectNaturalityFromEntityToProfileEvent event,
    Emitter<SearchNaturalityState> emit,
  ) async {
    emit(
      state.loadedSelectNaturalityState(
        naturalityEntity: event.naturalityEntity,
      ),
    );
  }
}
