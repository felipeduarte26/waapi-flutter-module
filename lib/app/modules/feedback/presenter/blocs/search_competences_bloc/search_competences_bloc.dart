import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/skill_feedback_entity.dart';
import '../../../domain/usecases/search_competences_usecase.dart';
import 'search_competences_bloc_event_transformer.dart';
import 'search_competences_event.dart';
import 'search_competences_state.dart';

class SearchCompetencesBloc extends Bloc<SearchCompetencesEvent, SearchCompetencesState> {
  final SearchCompetencesUsecase _searchCompetencesUsecase;

  SearchCompetencesBloc({
    required SearchCompetencesUsecase searchCompetencesUsecase,
  })  : _searchCompetencesUsecase = searchCompetencesUsecase,
        super(InitialSearchCompetencesState()) {
    on<GetCompetencesEvent>(
      _getCompetences,
      transformer: debounce(
        const Duration(
          milliseconds: 300,
        ),
      ),
    );
    on<SelectCompetencesListEvent>(_selectCompetencesListEvent);
    on<ClearCompetencesSelectedListEvent>(_clearCompetencesSelectedListEvent);
    on<ClearCompetencesListEvent>(_clearCompetencesListEvent);
  }

  Future<void> _getCompetences(
    GetCompetencesEvent event,
    Emitter<SearchCompetencesState> emit,
  ) async {
    emit(state.loadingSearchCompetencesState());

    final competences = await _searchCompetencesUsecase.call(
      competency: event.competency,
    );

    competences.fold(
      (left) {
        emit(
          state.errorSearchCompetencesState(
            errorMessage: left.message,
            competencySearchText: event.competency,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(state.emptyListSearchCompetencesState());
          return;
        }
        List<SkillFeedbackEntity> previousCompetencyList = right;
        List<SkillFeedbackEntity> updatedCompetencyList = [];

        if (state.competencesSelected.isNotEmpty) {
          for (var competencySelected in state.competencesSelected) {
            bool isSelected = right.any(
              (competency) {
                return competency.id == competencySelected.id;
              },
            );

            if (isSelected) {
              previousCompetencyList.remove(competencySelected);

              previousCompetencyList.insert(
                0,
                competencySelected,
              );
            }
          }

          updatedCompetencyList = previousCompetencyList;
        } else {
          updatedCompetencyList = right;
        }

        emit(
          state.loadedSearchCompetencesState(
            competences: updatedCompetencyList,
            competencesSelected: state.competencesSelected,
          ),
        );
      },
    );
  }

  Future<void> _selectCompetencesListEvent(
    SelectCompetencesListEvent event,
    Emitter<SearchCompetencesState> emit,
  ) async {
    if (event.isMarkAsSelected) {
      final bool isDuplicate = state.competencesSelected.any(
        (entity) {
          return entity.id == event.competencySelected.id;
        },
      );

      if (!isDuplicate) {
        List<SkillFeedbackEntity> previousCompetencyList = state.competencesSelected;
        final List<SkillFeedbackEntity> updatedCompetencyList = [
          ...previousCompetencyList,
          event.competencySelected,
        ];
        emit(
          state.loadedSearchCompetencesState(
            competences: state.competences,
            competencesSelected: updatedCompetencyList,
          ),
        );
      }
    } else {
      List<SkillFeedbackEntity> previousCompetencyList = state.competencesSelected;
      final List<SkillFeedbackEntity> updatedCompetencyList = [
        ...previousCompetencyList,
      ];
      updatedCompetencyList.remove(event.competencySelected);
      emit(
        state.loadedSearchCompetencesState(
          competences: state.competences,
          competencesSelected: updatedCompetencyList,
        ),
      );
    }
  }

  Future<void> _clearCompetencesSelectedListEvent(
    ClearCompetencesSelectedListEvent _,
    Emitter<SearchCompetencesState> emit,
  ) async {
    List<SkillFeedbackEntity> updatedCompetencyList = [];
    emit(
      state.loadedSearchCompetencesState(
        competences: state.competences,
        competencesSelected: updatedCompetencyList,
      ),
    );
  }

  Future<void> _clearCompetencesListEvent(
    ClearCompetencesListEvent _,
    Emitter<SearchCompetencesState> emit,
  ) async {
    emit(InitialSearchCompetencesState());
  }
}
