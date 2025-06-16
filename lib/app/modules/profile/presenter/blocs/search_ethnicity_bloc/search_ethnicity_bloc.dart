import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/ethnicity_entity.dart';
import '../../../domain/usecases/search_ethnicity_usecase.dart';
import 'search_ethnicity_bloc_event_transformer.dart';

part 'search_ethnicity_event.dart';
part 'search_ethnicity_state.dart';

class SearchEthnicityBloc extends Bloc<SearchEthnicityEvent, SearchEthnicityState> {
  final SearchEthnicityUsecase _searchEthnicityUsecase;

  SearchEthnicityBloc({
    required SearchEthnicityUsecase searchEthnicityUsecase,
  })  : _searchEthnicityUsecase = searchEthnicityUsecase,
        super(const InitialSearchEthnicityState()) {
    on<SearchEthnicityProfileEvent>(
      _searchEthnicity,
      transformer: debounce(
        const Duration(
          milliseconds: 300,
        ),
      ),
    );

    on<ClearSearchEthnicityProfileEvent>(_clearSearchEthnicityProfileEvent);
    on<SelectEthnicityFromEntityToProfileEvent>(_selectEthnicityFromEntity);
  }

  Future<void> _clearSearchEthnicityProfileEvent(
    ClearSearchEthnicityProfileEvent _,
    Emitter<SearchEthnicityState> emit,
  ) async {
    emit(state.initialSearchEthnicityState());
  }

  Future<void> _searchEthnicity(
    SearchEthnicityProfileEvent event,
    Emitter<SearchEthnicityState> emit,
  ) async {
    final bool isInvalidName = event.search.trim().length < 3 && event.search.trim() != '%';

    if (isInvalidName) {
      return;
    }
    
    emit(state.loadingSearchEthnicityState());

    final ethnicityList = await _searchEthnicityUsecase.call(
      ethnicity: event.search,
    );

    ethnicityList.fold(
      (left) {
        emit(
          state.errorSearchEthnicityState(
            message: left.message,
            search: event.search,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(state.emptySearchEthnicityState());
        } else {
          emit(
            state.loadedSearchEthnicityState(
              ethnicityList: right,
            ),
          );
        }
      },
    );
  }

  Future<void> _selectEthnicityFromEntity(
    SelectEthnicityFromEntityToProfileEvent event,
    Emitter<SearchEthnicityState> emit,
  ) async {
    emit(
      state.loadedSelectedEthnicityState(
        ethnicityEntity: event.ethnicityEntity,
      ),
    );
  }
}
