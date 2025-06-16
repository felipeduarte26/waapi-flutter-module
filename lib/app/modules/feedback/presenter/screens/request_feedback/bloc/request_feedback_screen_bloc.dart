import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/feedback_person_bloc/feedback_person_bloc.dart';
import '../../../blocs/request_feedback_bloc/request_feedback_bloc.dart';
import '../../../blocs/search_employee_bloc/search_employee_bloc.dart';
import 'request_feedback_screen_event.dart';
import 'request_feedback_screen_state.dart';

class RequestFeedbackScreenBloc extends Bloc<RequestFeedbackScreenEvent, RequestFeedbackScreenState> {
  final RequestFeedbackBloc requestFeedbackBloc;
  final SearchEmployeeBloc searchEmployeeBloc;
  final FeedbackPersonBloc feedbackPersonBloc;

  late StreamSubscription requestFeedbackSubscription;
  late StreamSubscription searchEmployeeSubscription;
  late StreamSubscription feedbackPersonSubscription;

  RequestFeedbackScreenBloc({
    required this.requestFeedbackBloc,
    required this.searchEmployeeBloc,
    required this.feedbackPersonBloc,
  }) : super(
          CurrentRequestFeedbackState(
            requestFeedbackState: requestFeedbackBloc.state,
            searchEmployeeState: searchEmployeeBloc.state,
            feedbackPersonState: feedbackPersonBloc.state,
          ),
        ) {
    on<ChangeRequestFeedbackStateEvent>(_changeRequestFeedbackStateEvent);
    on<ChangeSearchEmployeeStateEvent>(_changeSearchEmployeeStateEvent);
    on<ChangeFeedbackPersonStateEvent>(_changeFeedbackPersonStateEvent);

    requestFeedbackSubscription = requestFeedbackBloc.stream.listen(
      (requestFeedbackBlocState) {
        add(
          ChangeRequestFeedbackStateEvent(
            requestFeedbackState: requestFeedbackBlocState,
          ),
        );
      },
    );

    searchEmployeeSubscription = searchEmployeeBloc.stream.listen(
      (searchEmployeeState) {
        add(
          ChangeSearchEmployeeStateEvent(
            searchEmployeeState: searchEmployeeState,
          ),
        );
      },
    );

    feedbackPersonSubscription = feedbackPersonBloc.stream.listen(
      (feedbackPersonState) {
        add(
          ChangeFeedbackPersonStateEvent(
            feedbackPersonState: feedbackPersonState,
          ),
        );
      },
    );
  }

  Future<void> _changeRequestFeedbackStateEvent(
    ChangeRequestFeedbackStateEvent event,
    Emitter<RequestFeedbackScreenState> emit,
  ) async {
    emit(
      state.currentState(
        requestFeedbackState: event.requestFeedbackState,
      ),
    );
  }

  Future<void> _changeSearchEmployeeStateEvent(
    ChangeSearchEmployeeStateEvent event,
    Emitter<RequestFeedbackScreenState> emit,
  ) async {
    emit(
      state.currentState(
        searchEmployeeState: event.searchEmployeeState,
      ),
    );
  }

  Future<void> _changeFeedbackPersonStateEvent(
    ChangeFeedbackPersonStateEvent event,
    Emitter<RequestFeedbackScreenState> emit,
  ) async {
    emit(
      state.currentState(
        feedbackPersonState: event.feedbackPersonState,
      ),
    );
  }

  @override
  Future<void> close() async {
    await requestFeedbackSubscription.cancel();
    await searchEmployeeSubscription.cancel();
    await feedbackPersonSubscription.cancel();
    await super.close();
  }
}
