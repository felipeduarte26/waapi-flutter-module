import 'package:equatable/equatable.dart';

import '../../../blocs/feedback_requests_bloc/feedback_requests_state.dart';
import '../../../blocs/received_feedbacks_bloc/received_feedbacks_state.dart';
import '../../../blocs/sent_feedbacks_bloc/sent_feedbacks_state.dart';

abstract class FeedbacksScreenEvent extends Equatable {}

class ChangeReceivedFeedbacksStateEvent extends FeedbacksScreenEvent {
  final ReceivedFeedbacksState receivedFeedbacksState;

  ChangeReceivedFeedbacksStateEvent({
    required this.receivedFeedbacksState,
  });

  @override
  List<Object?> get props {
    return [
      receivedFeedbacksState,
    ];
  }
}

class ChangeFeedbackRequestsStateEvent extends FeedbacksScreenEvent {
  final FeedbackRequestsState feedbackRequestsState;

  ChangeFeedbackRequestsStateEvent({
    required this.feedbackRequestsState,
  });

  @override
  List<Object?> get props {
    return [
      feedbackRequestsState,
    ];
  }
}

class ChangeSentFeedbacksStateEvent extends FeedbacksScreenEvent {
  final SentFeedbacksState sentFeedbacksState;

  ChangeSentFeedbacksStateEvent({
    required this.sentFeedbacksState,
  });

  @override
  List<Object?> get props {
    return [
      sentFeedbacksState,
    ];
  }
}
