import 'package:equatable/equatable.dart';

import '../../../../../../attachment/presenter/blocs/attachment_bloc/attachment_state.dart';
import '../../../../blocs/details_received_feedback_bloc/details_received_feedback_state.dart';

abstract class DetailsReceivedFeedbackScreenEvent extends Equatable {}

class ChangeDetailsReceivedFeedbackScreenEvent extends DetailsReceivedFeedbackScreenEvent {
  final DetailsReceivedFeedbackState detailsReceivedFeedbackState;

  ChangeDetailsReceivedFeedbackScreenEvent({
    required this.detailsReceivedFeedbackState,
  });

  @override
  List<Object?> get props {
    return [
      detailsReceivedFeedbackState,
    ];
  }
}

class ChangeShareFileDetailsReceivedFeedbackScreenEvent extends DetailsReceivedFeedbackScreenEvent {
  final AttachmentState shareFileState;

  ChangeShareFileDetailsReceivedFeedbackScreenEvent({
    required this.shareFileState,
  });

  @override
  List<Object?> get props {
    return [
      shareFileState,
    ];
  }
}
