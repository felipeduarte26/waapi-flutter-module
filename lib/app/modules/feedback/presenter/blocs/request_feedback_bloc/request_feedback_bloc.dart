import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/input_models/request_feedback_input_model.dart';
import '../../../domain/usecases/request_feedback_usecase.dart';
import 'request_feedback_event.dart';
import 'request_feedback_state.dart';

class RequestFeedbackBloc extends Bloc<RequestFeedbackEvent, RequestFeedbackState> {
  final RequestFeedbackUsecase _requestFeedbackUsecase;

  RequestFeedbackBloc({
    required RequestFeedbackUsecase requestFeedbackUsecase,
  })  : _requestFeedbackUsecase = requestFeedbackUsecase,
        super(InitialRequestFeedbackState()) {
    on<SendRequestFeedbackRequestEvent>(_sendRequestFeedbackRequestEvent);
  }

  Future<void> _sendRequestFeedbackRequestEvent(
    SendRequestFeedbackRequestEvent event,
    Emitter<RequestFeedbackState> emit,
  ) async {
    emit(LoadingRequestFeedbackState());

    final RequestFeedbackInputModel requestFeedbackInputModel = RequestFeedbackInputModel(
      receiverId: event.receiverId,
      message: event.message,
    );

    final isRequestedFeedback = await _requestFeedbackUsecase.call(
      requestFeedbackInputModel: requestFeedbackInputModel,
    );

    isRequestedFeedback.fold(
      (left) {
        emit(
          ErrorRequestFeedbackState(
            errorMessage: left.message,
          ),
        );
        emit(InitialRequestFeedbackState());
      },
      (right) {
        emit(SentRequestFeedbackState());
      },
    );
  }
}
