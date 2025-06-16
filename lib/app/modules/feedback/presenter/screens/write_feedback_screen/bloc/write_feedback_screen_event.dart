import 'package:equatable/equatable.dart';

import '../../../../../ia_assist/presenter/bloc/ia_assist_bloc/ia_assist_state.dart';
import '../../../blocs/proficiency_list_bloc/proficiency_list_state.dart';
import '../../../blocs/search_competences_bloc/search_competences_state.dart';
import '../../../blocs/search_employee_bloc/search_employee_state.dart';
import '../../../blocs/send_feedback_bloc/send_feedback_state.dart';
import '../../../blocs/user_info_feedback_bloc/user_info_feedback_state.dart';

abstract class WriteFeedbackScreenEvent extends Equatable {}

class ChangeSearchEmployeeStateEvent extends WriteFeedbackScreenEvent {
  final SearchEmployeeState searchEmployeeState;

  ChangeSearchEmployeeStateEvent({
    required this.searchEmployeeState,
  });

  @override
  List<Object?> get props {
    return [
      searchEmployeeState,
    ];
  }
}

class ChangeSearchCompetencesStateEvent extends WriteFeedbackScreenEvent {
  final SearchCompetencesState searchCompetencesState;

  ChangeSearchCompetencesStateEvent({
    required this.searchCompetencesState,
  });

  @override
  List<Object?> get props {
    return [
      searchCompetencesState,
    ];
  }
}

class ChangeSendFeedbackStateEvent extends WriteFeedbackScreenEvent {
  final SendFeedbackState sendFeedbackState;

  ChangeSendFeedbackStateEvent({
    required this.sendFeedbackState,
  });

  @override
  List<Object?> get props {
    return [
      sendFeedbackState,
    ];
  }
}

class ChangeProficiencyListStateEvent extends WriteFeedbackScreenEvent {
  final ProficiencyListState proficiencyListState;

  ChangeProficiencyListStateEvent({
    required this.proficiencyListState,
  });

  @override
  List<Object?> get props {
    return [
      proficiencyListState,
    ];
  }
}

class ChangeUserInfoFeedbackStateEvent extends WriteFeedbackScreenEvent {
  final UserInfoFeedbackState userInfoFeedbackState;

  ChangeUserInfoFeedbackStateEvent({
    required this.userInfoFeedbackState,
  });

  @override
  List<Object?> get props {
    return [
      userInfoFeedbackState,
    ];
  }
}

class ChangeIAAssistStateEvent extends WriteFeedbackScreenEvent {
  final IAAssistState iaAssistState;

  ChangeIAAssistStateEvent({
    required this.iaAssistState,
  });

  @override
  List<Object?> get props {
    return [
      iaAssistState,
    ];
  }
}
