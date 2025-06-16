import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/input_models/request_feedback_details_input_model.dart';
import '../../../../domain/usecases/get_feedback_request_details_usecase.dart';
import 'details_request_feedback_screen_event.dart';
import 'details_request_feedback_screen_state.dart';

class DetailsRequestFeedbackScreenBloc
    extends Bloc<DetailsRequestFeedbackScreenEvent, DetailsRequestFeedbackScreenState> {
  late GetFeedbackRequestDetailsUsecase _getFeedbackRequestDetailsUsecase;

  DetailsRequestFeedbackScreenBloc({
    required GetFeedbackRequestDetailsUsecase getFeedbackRequestDetailsUsecase,
  }) : super(InitialDetailsRequestFeedbackState()) {
    _getFeedbackRequestDetailsUsecase = getFeedbackRequestDetailsUsecase;
    on<GetDetailsRequestFeedbackStateEvent>(_getDetailsFeedbackRequest);
  }

  Future<void> _getDetailsFeedbackRequest(
    GetDetailsRequestFeedbackStateEvent event,
    Emitter<DetailsRequestFeedbackScreenState> emit,
  ) async {
    emit(LoadingDetailsRequestFeedbackState());

    final isFeedbackDeleted = await _getFeedbackRequestDetailsUsecase.call(
      requestFeedbackDetailsParams: RequestFeedbackDetailsInputModel(
        isRequestedByMe: event.isRequestedByMe,
        requestFeedbackId: event.feedbackRequestId,
      ),
    );

    isFeedbackDeleted.fold(
      (left) {
        emit(
          ErrorDetailsRequestFeedbackState(
            errorMessage: left.message ?? '',
          ),
        );
      },
      (right) {
        emit(
          LoadedDetailsRequestFeedbackState(
            requestEntity: right,
          ),
        );
      },
    );
  }
}
