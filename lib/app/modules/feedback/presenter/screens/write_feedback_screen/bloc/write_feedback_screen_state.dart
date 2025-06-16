import 'package:equatable/equatable.dart';

import '../../../../../ia_assist/presenter/bloc/ia_assist_bloc/ia_assist_state.dart';
import '../../../blocs/proficiency_list_bloc/proficiency_list_state.dart';
import '../../../blocs/search_competences_bloc/search_competences_state.dart';
import '../../../blocs/search_employee_bloc/search_employee_state.dart';
import '../../../blocs/send_feedback_bloc/send_feedback_state.dart';
import '../../../blocs/user_info_feedback_bloc/user_info_feedback_state.dart';

abstract class WriteFeedbackScreenState extends Equatable {
  final SearchEmployeeState searchEmployeeState;
  final SearchCompetencesState searchCompetencesState;
  final ProficiencyListState proficiencyListState;
  final UserInfoFeedbackState userInfoFeedbackState;
  final SendFeedbackState sendFeedbackState;
  final IAAssistState iaAssistState;

  const WriteFeedbackScreenState({
    required this.searchEmployeeState,
    required this.searchCompetencesState,
    required this.proficiencyListState,
    required this.userInfoFeedbackState,
    required this.sendFeedbackState,
    required this.iaAssistState,
  });

  WriteFeedbackScreenState currentState({
    SearchEmployeeState? searchEmployeeState,
    SearchCompetencesState? searchCompetencesState,
    ProficiencyListState? proficiencyListState,
    UserInfoFeedbackState? userInfoFeedbackState,
    SendFeedbackState? sendFeedbackState,
    IAAssistState? iaAssistState,
  }) {
    return CurrentWriteFeedbackScreenState(
      searchEmployeeState: searchEmployeeState ?? this.searchEmployeeState,
      searchCompetencesState: searchCompetencesState ?? this.searchCompetencesState,
      proficiencyListState: proficiencyListState ?? this.proficiencyListState,
      userInfoFeedbackState: userInfoFeedbackState ?? this.userInfoFeedbackState,
      sendFeedbackState: sendFeedbackState ?? this.sendFeedbackState,
      iaAssistState: iaAssistState ?? this.iaAssistState,
    );
  }
}

class CurrentWriteFeedbackScreenState extends WriteFeedbackScreenState {
  const CurrentWriteFeedbackScreenState({
    required SearchEmployeeState searchEmployeeState,
    required SearchCompetencesState searchCompetencesState,
    required ProficiencyListState proficiencyListState,
    required UserInfoFeedbackState userInfoFeedbackState,
    required SendFeedbackState sendFeedbackState,
    required IAAssistState iaAssistState,
  }) : super(
          searchEmployeeState: searchEmployeeState,
          searchCompetencesState: searchCompetencesState,
          proficiencyListState: proficiencyListState,
          userInfoFeedbackState: userInfoFeedbackState,
          sendFeedbackState: sendFeedbackState,
          iaAssistState: iaAssistState,
        );

  @override
  List<Object?> get props {
    return [
      searchEmployeeState,
      searchCompetencesState,
      proficiencyListState,
      userInfoFeedbackState,
      sendFeedbackState,
      iaAssistState,
    ];
  }
}
