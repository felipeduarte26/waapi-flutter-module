import 'package:equatable/equatable.dart';

import '../../../blocs/feedback_person_bloc/feedback_person_state.dart';
import '../../../blocs/request_feedback_bloc/request_feedback_state.dart';
import '../../../blocs/search_employee_bloc/search_employee_state.dart';

abstract class RequestFeedbackScreenEvent extends Equatable {}

class ChangeRequestFeedbackStateEvent extends RequestFeedbackScreenEvent {
  final RequestFeedbackState requestFeedbackState;

  ChangeRequestFeedbackStateEvent({
    required this.requestFeedbackState,
  });

  @override
  List<Object?> get props {
    return [
      requestFeedbackState,
    ];
  }
}

class ChangeSearchEmployeeStateEvent extends RequestFeedbackScreenEvent {
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

class ChangeFeedbackPersonStateEvent extends RequestFeedbackScreenEvent {
  final FeedbackPersonState feedbackPersonState;

  ChangeFeedbackPersonStateEvent({
    required this.feedbackPersonState,
  });

  @override
  List<Object?> get props {
    return [
      feedbackPersonState,
    ];
  }
}
