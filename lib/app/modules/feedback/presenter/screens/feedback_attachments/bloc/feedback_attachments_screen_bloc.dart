import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../attachment/presenter/blocs/attachment_bloc/attachment_bloc.dart';
import 'feedback_attachments_screen_event.dart';
import 'feedback_attachments_screen_state.dart';

class FeedbackAttachmentsScreenBloc extends Bloc<FeedbackAttachmentsScreenEvent, FeedbackAttachmentsScreenState> {
  final AttachmentBloc attachmentsBloc;

  late StreamSubscription feedbackAttachmentsSubscription;

  FeedbackAttachmentsScreenBloc({
    required this.attachmentsBloc,
  }) : super(
          CurrentFeedbackAttachmentsState(
            attachmentState: attachmentsBloc.state,
          ),
        ) {
    on<ChangeFeedbackAttachmentsStateEvent>(_changeFeedbackAttachmentsStateEvent);

    feedbackAttachmentsSubscription = attachmentsBloc.stream.listen(
      (feedbackAttachmentsBlocState) {
        add(
          ChangeFeedbackAttachmentsStateEvent(
            feedbackAttachmentsState: feedbackAttachmentsBlocState,
          ),
        );
      },
    );
  }

  Future<void> _changeFeedbackAttachmentsStateEvent(
    ChangeFeedbackAttachmentsStateEvent event,
    Emitter<FeedbackAttachmentsScreenState> emit,
  ) async {
    emit(
      state.currentState(
        attachmentState: event.feedbackAttachmentsState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await feedbackAttachmentsSubscription.cancel();
    return super.close();
  }
}
