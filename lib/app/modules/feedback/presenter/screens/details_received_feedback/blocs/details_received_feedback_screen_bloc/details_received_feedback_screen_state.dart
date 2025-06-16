import 'package:equatable/equatable.dart';

import '../../../../../../attachment/presenter/blocs/attachment_bloc/attachment_state.dart';
import '../../../../blocs/details_received_feedback_bloc/details_received_feedback_state.dart';

abstract class DetailsReceivedFeedbackScreenState extends Equatable {
  final DetailsReceivedFeedbackState detailsReceivedFeedbackState;
  final AttachmentState shareFileState;

  const DetailsReceivedFeedbackScreenState({
    required this.detailsReceivedFeedbackState,
    required this.shareFileState,
  });

  CurrentDetailsReceivedFeedbackScreenState currentState({
    DetailsReceivedFeedbackState? detailsReceivedFeedbackState,
    AttachmentState? shareFileState,
  }) {
    return CurrentDetailsReceivedFeedbackScreenState(
      detailsReceivedFeedbackState: detailsReceivedFeedbackState ?? this.detailsReceivedFeedbackState,
      shareFileState: shareFileState ?? this.shareFileState,
    );
  }

  @override
  List<Object?> get props {
    return [
      detailsReceivedFeedbackState,
      shareFileState,
    ];
  }
}

class CurrentDetailsReceivedFeedbackScreenState extends DetailsReceivedFeedbackScreenState {
  const CurrentDetailsReceivedFeedbackScreenState({
    required DetailsReceivedFeedbackState detailsReceivedFeedbackState,
    required AttachmentState shareFileState,
  }) : super(
          detailsReceivedFeedbackState: detailsReceivedFeedbackState,
          shareFileState: shareFileState,
        );
}
