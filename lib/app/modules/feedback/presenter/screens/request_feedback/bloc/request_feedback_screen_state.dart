import 'package:equatable/equatable.dart';

import '../../../blocs/feedback_person_bloc/feedback_person_state.dart';
import '../../../blocs/request_feedback_bloc/request_feedback_state.dart';
import '../../../blocs/search_employee_bloc/search_employee_state.dart';

abstract class RequestFeedbackScreenState extends Equatable {
  final RequestFeedbackState requestFeedbackState;
  final SearchEmployeeState searchEmployeeState;
  final FeedbackPersonState feedbackPersonState;

  const RequestFeedbackScreenState({
    required this.requestFeedbackState,
    required this.searchEmployeeState,
    required this.feedbackPersonState,
  });

  CurrentRequestFeedbackState currentState({
    RequestFeedbackState? requestFeedbackState,
    SearchEmployeeState? searchEmployeeState,
    FeedbackPersonState? feedbackPersonState,
  }) {
    return CurrentRequestFeedbackState(
      requestFeedbackState: requestFeedbackState ?? this.requestFeedbackState,
      searchEmployeeState: searchEmployeeState ?? this.searchEmployeeState,
      feedbackPersonState: feedbackPersonState ?? this.feedbackPersonState,
    );
  }

  @override
  List<Object?> get props {
    return [
      requestFeedbackState,
      searchEmployeeState,
      feedbackPersonState,
    ];
  }
}

class CurrentRequestFeedbackState extends RequestFeedbackScreenState {
  const CurrentRequestFeedbackState({
    required RequestFeedbackState requestFeedbackState,
    required SearchEmployeeState searchEmployeeState,
    required FeedbackPersonState feedbackPersonState,
  }) : super(
          requestFeedbackState: requestFeedbackState,
          searchEmployeeState: searchEmployeeState,
          feedbackPersonState: feedbackPersonState,
        );
}
