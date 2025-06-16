import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/details_sent_feedback_bloc/details_sent_feedback_bloc.dart';
import 'details_sent_feedback_screen_event.dart';
import 'details_sent_feedback_screen_state.dart';

class DetailsSentFeedbackScreenBloc extends Bloc<DetailsSentFeedbackScreenEvent, DetailsSentFeedbackScreenState> {
  final DetailsSentFeedbackBloc detailsSentFeedbackBloc;

  late StreamSubscription detailsSentFeedbackSubscription;

  DetailsSentFeedbackScreenBloc({
    required this.detailsSentFeedbackBloc,
  }) : super(
          CurrentDetailsSentFeedbackState(
            detailsSentFeedbackState: detailsSentFeedbackBloc.state,
          ),
        ) {
    on<ChangeDetailsSentFeedbackStateEvent>(_changeDetailsSentFeedbackStateEvent);

    detailsSentFeedbackSubscription = detailsSentFeedbackBloc.stream.listen(
      (detailsSentFeedbackBlocState) {
        add(
          ChangeDetailsSentFeedbackStateEvent(
            detailsSentFeedbackState: detailsSentFeedbackBlocState,
          ),
        );
      },
    );
  }

  Future<void> _changeDetailsSentFeedbackStateEvent(
    ChangeDetailsSentFeedbackStateEvent event,
    Emitter<DetailsSentFeedbackScreenState> emit,
  ) async {
    emit(
      state.currentState(
        detailsSentFeedbackState: event.detailsSentFeedbackState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await detailsSentFeedbackSubscription.cancel();
    return super.close();
  }
}
