import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../blocs/feedback_requests_bloc/feedback_requests_bloc.dart';
import '../../../blocs/received_feedbacks_bloc/received_feedbacks_bloc.dart';
import '../../../blocs/sent_feedbacks_bloc/sent_feedbacks_bloc.dart';
import 'feedbacks_screen_event.dart';
import 'feedbacks_screen_state.dart';

class FeedbacksScreenBloc extends Bloc<FeedbacksScreenEvent, FeedbacksScreenState> {
  final ReceivedFeedbacksBloc receivedFeedbacksBloc;
  final FeedbackRequestsBloc feedbackRequestsBloc;
  final SentFeedbacksBloc sentFeedbacksBloc;
  final AuthorizationBloc authorizationBloc;

  late StreamSubscription receivedFeedbacksSubscription;
  late StreamSubscription feedbackRequestsSubscription;
  late StreamSubscription sentFeedbacksSubscription;

  FeedbacksScreenBloc({
    required this.receivedFeedbacksBloc,
    required this.feedbackRequestsBloc,
    required this.sentFeedbacksBloc,
    required this.authorizationBloc,
  }) : super(
          CurrentFeedbacksScreenState(
            receivedFeedbacksState: receivedFeedbacksBloc.state,
            feedbackRequestsState: feedbackRequestsBloc.state,
            sentFeedbacksState: sentFeedbacksBloc.state,
          ),
        ) {
    on<ChangeReceivedFeedbacksStateEvent>(_changeReceivedFeedbacksStateEvent);
    on<ChangeSentFeedbacksStateEvent>(_changeSentFeedbacksStateEvent);

    sentFeedbacksSubscription = sentFeedbacksBloc.stream.listen(
      (sentFeedbacksBlocState) {
        add(
          ChangeSentFeedbacksStateEvent(
            sentFeedbacksState: sentFeedbacksBlocState,
          ),
        );
      },
    );

    on<ChangeFeedbackRequestsStateEvent>(_changeFeedbackRequestsStateEvent);

    receivedFeedbacksSubscription = receivedFeedbacksBloc.stream.listen(
      (receivedFeedbacksBlocState) {
        add(
          ChangeReceivedFeedbacksStateEvent(
            receivedFeedbacksState: receivedFeedbacksBlocState,
          ),
        );
      },
    );

    feedbackRequestsSubscription = feedbackRequestsBloc.stream.listen(
      (feedbackRequestsBlocState) {
        add(
          ChangeFeedbackRequestsStateEvent(
            feedbackRequestsState: feedbackRequestsBlocState,
          ),
        );
      },
    );
  }

  Future<void> _changeReceivedFeedbacksStateEvent(
    ChangeReceivedFeedbacksStateEvent event,
    Emitter<FeedbacksScreenState> emit,
  ) async {
    emit(
      state.currentState(
        receivedFeedbacksState: event.receivedFeedbacksState,
      ),
    );
  }

  Future<void> _changeFeedbackRequestsStateEvent(
    ChangeFeedbackRequestsStateEvent event,
    Emitter<FeedbacksScreenState> emit,
  ) async {
    emit(
      state.currentState(
        feedbackRequestsState: event.feedbackRequestsState,
      ),
    );
  }

  Future<void> _changeSentFeedbacksStateEvent(
    ChangeSentFeedbacksStateEvent event,
    Emitter<FeedbacksScreenState> emit,
  ) async {
    emit(
      state.currentState(
        sentFeedbacksState: event.sentFeedbacksState,
      ),
    );
  }
}
