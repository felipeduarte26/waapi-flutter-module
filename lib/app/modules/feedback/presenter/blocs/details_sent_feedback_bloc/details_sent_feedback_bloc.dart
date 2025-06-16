import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/delete_feedback_usecase.dart';
import '../../../domain/usecases/get_feedback_by_id_usecase.dart';
import 'details_sent_feedback_event.dart';
import 'details_sent_feedback_state.dart';

class DetailsSentFeedbackBloc extends Bloc<DetailsSentFeedbackEvent, DetailsSentFeedbackState> {
  final DeleteFeedbackUsecase _deleteFeedbackUsecase;
  final GetFeedbackByIdUsecase _getFeedbackByIdUsecase;

  DetailsSentFeedbackBloc({
    required DeleteFeedbackUsecase deleteFeedbackUsecase,
    required GetFeedbackByIdUsecase getFeedbackByIdUsecase,
  })  : _deleteFeedbackUsecase = deleteFeedbackUsecase,
        _getFeedbackByIdUsecase = getFeedbackByIdUsecase,
        super(InitialDetailsSentFeedbackState()) {
    on<DeleteFeedbackDetailsSentFeedbackEvent>(_deleteFeedbackDetailsSentFeedbackEvent);
    on<GetSentFeedbackEvent>(_getSentFeedbackEvent);
  }

  Future<void> _deleteFeedbackDetailsSentFeedbackEvent(
    DeleteFeedbackDetailsSentFeedbackEvent event,
    Emitter<DetailsSentFeedbackState> emit,
  ) async {
    emit(LoadingDetailsSentFeedbackState());

    final isFeedbackDeleted = await _deleteFeedbackUsecase.call(
      idFeedback: event.idFeedback,
    );

    isFeedbackDeleted.fold(
      (left) {
        emit(ErrorDeleteSentFeedbackState());
      },
      (right) {
        emit(FeedbackDeletedDetailsSentFeedbackState());
      },
    );
  }

  Future<void> _getSentFeedbackEvent(
    GetSentFeedbackEvent event,
    Emitter<DetailsSentFeedbackState> emit,
  ) async {
    emit(LoadingDetailsSentFeedbackState());

    final sentFeedback = await _getFeedbackByIdUsecase.call(
      feedbackId: event.sentFeedbackId,
      feedbackType: event.feedbackType,
    );

    sentFeedback.fold(
      (left) {
        emit(
          ErrorDetailsSentFeedbackState(
            errorMessage: left.message ?? '',
          ),
        );
      },
      (right) {
        emit(
          LoadedDetailsSentFeedbackState(
            feedbackEntity: right,
          ),
        );
      },
    );
  }
}
