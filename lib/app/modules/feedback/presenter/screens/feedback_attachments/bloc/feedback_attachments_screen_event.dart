import 'package:equatable/equatable.dart';

import '../../../../../attachment/presenter/blocs/attachment_bloc/attachment_state.dart';

abstract class FeedbackAttachmentsScreenEvent extends Equatable {}

class ChangeFeedbackAttachmentsStateEvent extends FeedbackAttachmentsScreenEvent {
  final AttachmentState feedbackAttachmentsState;

  ChangeFeedbackAttachmentsStateEvent({
    required this.feedbackAttachmentsState,
  });

  @override
  List<Object?> get props {
    return [
      feedbackAttachmentsState,
    ];
  }
}
