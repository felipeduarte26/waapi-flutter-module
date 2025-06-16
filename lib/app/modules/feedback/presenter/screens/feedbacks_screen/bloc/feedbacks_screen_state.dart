import 'package:equatable/equatable.dart';

import '../../../blocs/feedback_requests_bloc/feedback_requests_state.dart';
import '../../../blocs/received_feedbacks_bloc/received_feedbacks_state.dart';
import '../../../blocs/sent_feedbacks_bloc/sent_feedbacks_state.dart';

abstract class FeedbacksScreenState extends Equatable {
  final ReceivedFeedbacksState receivedFeedbacksState;
  final FeedbackRequestsState feedbackRequestsState;
  final SentFeedbacksState sentFeedbacksState;

  const FeedbacksScreenState({
    required this.receivedFeedbacksState,
    required this.feedbackRequestsState,
    required this.sentFeedbacksState,
  });

  CurrentFeedbacksScreenState currentState({
    ReceivedFeedbacksState? receivedFeedbacksState,
    FeedbackRequestsState? feedbackRequestsState,
    SentFeedbacksState? sentFeedbacksState,
  }) {
    return CurrentFeedbacksScreenState(
      receivedFeedbacksState: receivedFeedbacksState ?? this.receivedFeedbacksState,
      feedbackRequestsState: feedbackRequestsState ?? this.feedbackRequestsState,
      sentFeedbacksState: sentFeedbacksState ?? this.sentFeedbacksState,
    );
  }

  @override
  List<Object?> get props {
    return [
      receivedFeedbacksState,
      feedbackRequestsState,
      sentFeedbacksState,
    ];
  }
}

class CurrentFeedbacksScreenState extends FeedbacksScreenState {
  const CurrentFeedbacksScreenState({
    required ReceivedFeedbacksState receivedFeedbacksState,
    required FeedbackRequestsState feedbackRequestsState,
    required SentFeedbacksState sentFeedbacksState,
  }) : super(
          receivedFeedbacksState: receivedFeedbacksState,
          feedbackRequestsState: feedbackRequestsState,
          sentFeedbacksState: sentFeedbacksState,
        );
}
