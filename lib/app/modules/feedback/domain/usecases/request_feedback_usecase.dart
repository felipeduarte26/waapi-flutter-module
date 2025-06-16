import '../input_models/request_feedback_input_model.dart';
import '../repositories/request_feedback_repository.dart';
import '../types/feedback_domain_types.dart';

abstract class RequestFeedbackUsecase {
  RequestFeedbackUsecaseCallback call({
    required RequestFeedbackInputModel requestFeedbackInputModel,
  });
}

class RequestFeedbackUsecaseImpl implements RequestFeedbackUsecase {
  final RequestFeedbackRepository _requestFeedbackRepository;

  const RequestFeedbackUsecaseImpl({
    required RequestFeedbackRepository requestFeedbackRepository,
  }) : _requestFeedbackRepository = requestFeedbackRepository;

  @override
  RequestFeedbackUsecaseCallback call({
    required RequestFeedbackInputModel requestFeedbackInputModel,
  }) {
    return _requestFeedbackRepository.call(
      requestFeedbackInputModel: requestFeedbackInputModel,
    );
  }
}
