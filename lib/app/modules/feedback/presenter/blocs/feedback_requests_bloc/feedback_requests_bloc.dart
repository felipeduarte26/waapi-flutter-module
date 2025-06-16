import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_feedback_requests_usecase.dart';
import 'feedback_requests_event.dart';
import 'feedback_requests_state.dart';

class FeedbackRequestsBloc extends Bloc<FeedbackRequestsEvent, FeedbackRequestsState> {
  final GetFeedbackRequestsUsecase _getFeedbackRequestsUsecase;

  FeedbackRequestsBloc({
    required GetFeedbackRequestsUsecase getFeedbackRequestsUsecase,
  })  : _getFeedbackRequestsUsecase = getFeedbackRequestsUsecase,
        super(const InitialFeedbackRequestsState()) {
    on<GetFeedbackRequestsEvent>(_getFeedbackRequests);
    on<ReloadListFeedbackRequestsEvent>(_reloadListFeedbackRequestsEvent);
  }

  Future<void> _reloadListFeedbackRequestsEvent(
    ReloadListFeedbackRequestsEvent _,
    Emitter<FeedbackRequestsState> emit,
  ) async {
    emit(ReloadListFeedbackRequestsState());
  }

  Future<void> _getFeedbackRequests(
    GetFeedbackRequestsEvent _,
    Emitter<FeedbackRequestsState> emit,
  ) async {
    emit(state.loadingFeedbackRequestsState());

    final feedbackRequests = await _getFeedbackRequestsUsecase.call();

    feedbackRequests.fold(
      (left) {
        emit(
          state.errorFeedbackRequestsState(
            errorMessage: left.message,
          ),
        );
      },
      (right) {
        if (right.isEmpty) {
          emit(state.emptyListFeedbackRequestsState());
        } else {
          emit(
            state.loadedFeedbackRequestsState(
              feedbackRequests: right,
            ),
          );
        }
      },
    );
  }
}
