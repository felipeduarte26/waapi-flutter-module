import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/search_nationality_usecase.dart';
import '../search_naturality/search_naturality_bloc_event_transformer.dart';
import 'search_nationality_event.dart';
import 'search_nationality_state.dart';

class SearchNationalityBloc extends Bloc<SearchNationalityEvent, SearchNationalityState> {
  final SearchNationalityUsecase _searchNationalityUsecase;

  SearchNationalityBloc({
    required SearchNationalityUsecase searchNationalityUsecase,
  })  : _searchNationalityUsecase = searchNationalityUsecase,
        super(const InitialSearchNationalityState()) {
    on<SearchNationalityProfileEvent>(
      _searchNationality,
      transformer: debounce(
        const Duration(
          milliseconds: 300,
        ),
      ),
    );

    on<ClearSearchNationalityProfileEvent>(_clearSearchNationalityProfileEvent);
    on<SelectNationalityFromEntityToProfileEvent>(_selectNationalityFromEntity);
  }

  Future<void> _clearSearchNationalityProfileEvent(
    ClearSearchNationalityProfileEvent _,
    Emitter<SearchNationalityState> emit,
  ) async {
    emit(state.initialSearchNationalityState());
  }

  Future<void> _searchNationality(
    SearchNationalityProfileEvent event,
    Emitter<SearchNationalityState> emit,
  ) async {
    final bool isInvalidName = event.search.trim().length < 3;

    if (isInvalidName) {
      emit(state.initialSearchNationalityState());
      return;
    }

    emit(state.loadingSearchNationalityState());

    final nationalityList = await _searchNationalityUsecase.call(
      nationality: event.search,
    );

    nationalityList.fold(
      (left) {
        emit(
          state.errorSearchNationalityState(
            message: left.message,
            search: event.search,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(state.emptyStateSearchNationalityState());
        } else {
          emit(
            state.loadedSearchNationalityState(
              nationalityList: right,
            ),
          );
        }
      },
    );
  }

  Future<void> _selectNationalityFromEntity(
    SelectNationalityFromEntityToProfileEvent event,
    Emitter<SearchNationalityState> emit,
  ) async {
    emit(
      state.loadedSelectNationalityState(
        nationalityEntity: event.nationalityEntity,
      ),
    );
  }
}
