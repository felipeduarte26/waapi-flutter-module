import '../input_models/request_feedback_input_model.dart';
import '../types/feedback_domain_types.dart';

abstract class RequestFeedbackRepository {
  RequestFeedbackUsecaseCallback call({
    required RequestFeedbackInputModel requestFeedbackInputModel,
  });
}
