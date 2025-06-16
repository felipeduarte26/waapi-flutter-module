import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../attachment/presenter/blocs/attachment_bloc/attachment_bloc.dart';
import '../../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../blocs/details_received_feedback_bloc/details_received_feedback_bloc.dart';
import 'details_received_feedback_screen_event.dart';
import 'details_received_feedback_screen_state.dart';

class DetailsReceivedFeedbackScreenBloc
    extends Bloc<DetailsReceivedFeedbackScreenEvent, DetailsReceivedFeedbackScreenState> {
  final DetailsReceivedFeedbackBloc detailsReceivedFeedbacksBloc;
  final AuthorizationBloc authorizationBloc;
  final AttachmentBloc shareFileBloc;

  late StreamSubscription detailsReceivedFeedbacksSubscription;
  late StreamSubscription shareFileSubscription;

  DetailsReceivedFeedbackScreenBloc({
    required this.authorizationBloc,
    required this.detailsReceivedFeedbacksBloc,
    required this.shareFileBloc,
  }) : super(
          CurrentDetailsReceivedFeedbackScreenState(
            detailsReceivedFeedbackState: detailsReceivedFeedbacksBloc.state,
            shareFileState: shareFileBloc.state,
          ),
        ) {
    on<ChangeDetailsReceivedFeedbackScreenEvent>(_changeDetailsReceivedFeedbackScreenEvent);
    on<ChangeShareFileDetailsReceivedFeedbackScreenEvent>(_changeShareFileDetailsReceivedFeedbackScreenEvent);

    detailsReceivedFeedbacksSubscription = detailsReceivedFeedbacksBloc.stream.listen(
      (receivedFeedbacksBlocState) {
        add(
          ChangeDetailsReceivedFeedbackScreenEvent(
            detailsReceivedFeedbackState: receivedFeedbacksBlocState,
          ),
        );
      },
    );

    shareFileSubscription = shareFileBloc.stream.listen(
      (shareFileState) {
        add(
          ChangeShareFileDetailsReceivedFeedbackScreenEvent(
            shareFileState: shareFileState,
          ),
        );
      },
    );
  }

  Future<void> _changeDetailsReceivedFeedbackScreenEvent(
    ChangeDetailsReceivedFeedbackScreenEvent event,
    Emitter<DetailsReceivedFeedbackScreenState> emit,
  ) async {
    emit(
      state.currentState(
        detailsReceivedFeedbackState: event.detailsReceivedFeedbackState,
      ),
    );
  }

  Future<void> _changeShareFileDetailsReceivedFeedbackScreenEvent(
    ChangeShareFileDetailsReceivedFeedbackScreenEvent event,
    Emitter<DetailsReceivedFeedbackScreenState> emit,
  ) async {
    emit(
      state.currentState(
        shareFileState: event.shareFileState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await detailsReceivedFeedbacksSubscription.cancel();
    await shareFileSubscription.cancel();
    return super.close();
  }
}
