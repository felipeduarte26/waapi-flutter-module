import 'package:equatable/equatable.dart';

import '../../../blocs/details_sent_feedback_bloc/details_sent_feedback_state.dart';

abstract class DetailsSentFeedbackScreenEvent extends Equatable {}

class ChangeDetailsSentFeedbackStateEvent extends DetailsSentFeedbackScreenEvent {
  final DetailsSentFeedbackState detailsSentFeedbackState;

  ChangeDetailsSentFeedbackStateEvent({
    required this.detailsSentFeedbackState,
  });

  @override
  List<Object?> get props {
    return [
      detailsSentFeedbackState,
    ];
  }
}
