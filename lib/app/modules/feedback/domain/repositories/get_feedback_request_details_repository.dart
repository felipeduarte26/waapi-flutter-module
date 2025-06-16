import '../input_models/request_feedback_details_input_model.dart';
import '../types/feedback_domain_types.dart';

abstract class GetFeedbackRequestDetailsRepository {
  RequestFeedbackDetailUsecaseCallback call({
    required RequestFeedbackDetailsInputModel requestFeedbackDetailsParams,
  });
}
