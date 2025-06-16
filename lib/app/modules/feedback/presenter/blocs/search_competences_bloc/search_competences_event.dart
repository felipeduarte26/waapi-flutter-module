import 'package:equatable/equatable.dart';

import '../../../domain/entities/skill_feedback_entity.dart';

abstract class SearchCompetencesEvent extends Equatable {}

class GetCompetencesEvent extends SearchCompetencesEvent {
  final String competency;

  GetCompetencesEvent({
    required this.competency,
  }) : super();

  @override
  List<Object?> get props {
    return [
      competency,
    ];
  }
}

class SelectCompetencesListEvent extends SearchCompetencesEvent {
  final SkillFeedbackEntity competencySelected;
  final bool isMarkAsSelected;

  SelectCompetencesListEvent({
    required this.competencySelected,
    required this.isMarkAsSelected,
  }) : super();

  @override
  List<Object?> get props {
    return [
      competencySelected,
      isMarkAsSelected,
    ];
  }
}

class ClearCompetencesListEvent extends SearchCompetencesEvent {
  @override
  List<Object?> get props {
    return [];
  }
}

class ClearCompetencesSelectedListEvent extends SearchCompetencesEvent {
  @override
  List<Object?> get props {
    return [];
  }
}
