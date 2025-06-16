import 'package:equatable/equatable.dart';

import '../../../domain/entities/skill_feedback_entity.dart';

abstract class SearchCompetencesState extends Equatable {
  final List<SkillFeedbackEntity> competences;
  final List<SkillFeedbackEntity> competencesSelected;

  const SearchCompetencesState({
    this.competences = const <SkillFeedbackEntity>[],
    this.competencesSelected = const [],
  });

  LoadingSearchCompetencesState loadingSearchCompetencesState() {
    return LoadingSearchCompetencesState(
      competencesSelected: competencesSelected,
    );
  }

  EmptyListSearchCompetencesState emptyListSearchCompetencesState() {
    return EmptyListSearchCompetencesState(
      competencesSelected: competencesSelected,
    );
  }

  LoadedSearchCompetencesState loadedSearchCompetencesState({
    required List<SkillFeedbackEntity> competences,
    required List<SkillFeedbackEntity> competencesSelected,
  }) {
    return LoadedSearchCompetencesState(
      competences: competences,
      competencesSelected: competencesSelected,
    );
  }

  ErrorSearchCompetencesState errorSearchCompetencesState({
    required String? errorMessage,
    required String competencySearchText,
  }) {
    return ErrorSearchCompetencesState(
      competencesSelected: competencesSelected,
      errorMessage: errorMessage,
      competencySearchText: competencySearchText,
    );
  }

  @override
  List<Object?> get props {
    return [
      competences,
      competencesSelected,
    ];
  }
}

class InitialSearchCompetencesState extends SearchCompetencesState {}

class LoadingSearchCompetencesState extends SearchCompetencesState {
  const LoadingSearchCompetencesState({
    required List<SkillFeedbackEntity> competencesSelected,
  }) : super(
          competencesSelected: competencesSelected,
        );
}

class LoadedSearchCompetencesState extends SearchCompetencesState {
  const LoadedSearchCompetencesState({
    required List<SkillFeedbackEntity> competences,
    required List<SkillFeedbackEntity> competencesSelected,
  }) : super(
          competences: competences,
          competencesSelected: competencesSelected,
        );
}

class EmptyListSearchCompetencesState extends SearchCompetencesState {
  const EmptyListSearchCompetencesState({
    required List<SkillFeedbackEntity> competencesSelected,
  }) : super(
          competencesSelected: competencesSelected,
        );
}

class ErrorSearchCompetencesState extends SearchCompetencesState {
  final String? errorMessage;
  final String competencySearchText;

  const ErrorSearchCompetencesState({
    required List<SkillFeedbackEntity> competencesSelected,
    required this.competencySearchText,
    this.errorMessage,
  }) : super(competencesSelected: competencesSelected);

  @override
  List<Object?> get props {
    return [
      ...super.props,
      errorMessage,
      competencySearchText,
    ];
  }
}
