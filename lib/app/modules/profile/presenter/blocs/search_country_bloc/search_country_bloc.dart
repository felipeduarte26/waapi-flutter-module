import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/search_country_usecase.dart';
import 'search_country_bloc_event_transformer.dart';
import 'search_country_event.dart';
import 'search_country_state.dart';

class SearchCountryBloc extends Bloc<SearchCountryEvent, SearchCountryState> {
  final SearchCountryUsecase _searchCountryUsecase;

  SearchCountryBloc({
    required SearchCountryUsecase searchCountryUsecase,
  })  : _searchCountryUsecase = searchCountryUsecase,
        super(const InitialSearchCountryState()) {
    on<SearchCountryProfileEvent>(
      _searchCountry,
      transformer: debounceCountry(
        const Duration(
          milliseconds: 300,
        ),
      ),
    );

    on<ClearSearchCountryProfileEvent>(_clearSearchCountryProfileEvent);
    on<SelectCountryFromEntityToProfileEvent>(_selectCountryFromEntity);
  }

  Future<void> _clearSearchCountryProfileEvent(
    ClearSearchCountryProfileEvent _,
    Emitter<SearchCountryState> emit,
  ) async {
    emit(state.initialSearchCountryState());
  }

  Future<void> _searchCountry(
    SearchCountryProfileEvent event,
    Emitter<SearchCountryState> emit,
  ) async {
    final bool isInvalidName = event.search.trim().length < 3;

    if (isInvalidName) {
      emit(state.initialSearchCountryState());
      return;
    }

    emit(state.loadingSearchCountryState());

    final countryList = await _searchCountryUsecase.call(
      country: event.search,
    );

    countryList.fold(
      (left) {
        emit(
          state.errorSearchCountryState(
            message: left.message,
            search: event.search,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(state.emptyStateSearchCountryState());
        } else {
          emit(
            state.loadedSearchCountryState(
              countryList: right,
            ),
          );
        }
      },
    );
  }

  Future<void> _selectCountryFromEntity(
    SelectCountryFromEntityToProfileEvent event,
    Emitter<SearchCountryState> emit,
  ) async {
    emit(
      state.loadedSelectCountryState(
        countryEntity: event.countryEntity,
      ),
    );
  }
}
