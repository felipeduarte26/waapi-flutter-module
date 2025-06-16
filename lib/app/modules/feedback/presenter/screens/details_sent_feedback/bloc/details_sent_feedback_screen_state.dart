import 'package:equatable/equatable.dart';

import '../../../blocs/details_sent_feedback_bloc/details_sent_feedback_state.dart';

abstract class DetailsSentFeedbackScreenState extends Equatable {
  final DetailsSentFeedbackState detailsSentFeedbackState;

  const DetailsSentFeedbackScreenState({
    required this.detailsSentFeedbackState,
  });

  CurrentDetailsSentFeedbackState currentState({
    required DetailsSentFeedbackState detailsSentFeedbackState,
  }) {
    return CurrentDetailsSentFeedbackState(
      detailsSentFeedbackState: detailsSentFeedbackState,
    );
  }

  @override
  List<Object?> get props {
    return [
      detailsSentFeedbackState,
    ];
  }
}

class CurrentDetailsSentFeedbackState extends DetailsSentFeedbackScreenState {
  const CurrentDetailsSentFeedbackState({
    required DetailsSentFeedbackState detailsSentFeedbackState,
  }) : super(detailsSentFeedbackState: detailsSentFeedbackState);
}
