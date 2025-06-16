import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/search_person_by_term_usecase.dart';
import 'search_person_bloc_event_transformer.dart';
import 'search_person_event.dart';
import 'search_person_state.dart';

class SearchPersonBloc extends Bloc<SearchPersonEvent, SearchPersonState> {
  final SearchPersonByTermUsecase _searchPersonByTermUsecase;

  SearchPersonBloc({
    required SearchPersonByTermUsecase searchPersonByTermUsecase,
  })  : _searchPersonByTermUsecase = searchPersonByTermUsecase,
        super(const InitialSearchPersonState()) {
    on<SearchPersonByTermEvent>(
      _searchPersonByTermEvent,
      transformer: debounce(
        const Duration(
          milliseconds: 300,
        ),
      ),
    );
  }

  Future<void> _searchPersonByTermEvent(
    SearchPersonByTermEvent event,
    Emitter<SearchPersonState> emit,
  ) async {
    final bool isInvalidTerm = event.paginationRequirements.queryText.trim().length < 3;

    if (isInvalidTerm) {
      emit(state.cleanSearchPersonState());
      return;
    }

    final bool isAllowedToGetMorePerson = (state is! LoadingMoreSearchPersonState &&
        state is! LastPageSearchPersonState &&
        (state is! ErrorSearchPersonState || state is! ErrorMoreSearchPersonState));

    if (!isAllowedToGetMorePerson) {
      return;
    }

    if (state.searchTerm != event.paginationRequirements.queryText) {
      emit(
        state.loadingSearchPersonState(
          searchTerm: event.paginationRequirements.queryText.trim(),
        ),
      );
    } else {
      emit(
        state.loadingMoreSearchPersonState(
          personEntityList: state.personEntityList,
          searchTerm: state.searchTerm.trim(),
        ),
      );
    }

    final people = await _searchPersonByTermUsecase.call(
      paginationRequirements: event.paginationRequirements,
    );

    people.fold(
      (left) {
        if (state.personEntityList.isEmpty) {
          emit(
            state.errorSearchPersonState(
              searchTerm: event.paginationRequirements.queryText.trim(),
            ),
          );
        } else {
          emit(
            state.errorMoreSearchPersonState(
              personEntityList: state.personEntityList,
              searchTerm: state.searchTerm.trim(),
            ),
          );
        }
      },
      (right) {
        if (right.isEmpty) {
          if (state.personEntityList.isEmpty) {
            emit(
              state.emptySearchPersonState(
                searchTerm: event.paginationRequirements.queryText.trim(),
              ),
            );
          } else {
            emit(
              state.lastPageSearchPersonState(
                personEntityList: state.personEntityList,
                searchTerm: state.searchTerm.trim(),
              ),
            );
          }
        } else {
          emit(
            state.loadedSearchPersonState(
              personEntityList: state.personEntityList + right,
              searchTerm: state.searchTerm.trim(),
            ),
          );
        }
      },
    );
  }
}
