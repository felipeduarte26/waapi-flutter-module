import 'package:equatable/equatable.dart';

import '../../../../../attachment/presenter/blocs/attachment_bloc/attachment_state.dart';

abstract class FeedbackAttachmentsScreenState extends Equatable {
  final AttachmentState attachmentState;

  const FeedbackAttachmentsScreenState({
    required this.attachmentState,
  });

  CurrentFeedbackAttachmentsState currentState({
    required AttachmentState attachmentState,
  }) {
    return CurrentFeedbackAttachmentsState(
      attachmentState: attachmentState,
    );
  }

  @override
  List<Object?> get props {
    return [
      attachmentState,
    ];
  }
}

class CurrentFeedbackAttachmentsState extends FeedbackAttachmentsScreenState {
  const CurrentFeedbackAttachmentsState({
    required AttachmentState attachmentState,
  }) : super(attachmentState: attachmentState);
}
