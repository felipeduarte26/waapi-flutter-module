import '../../domain/input_models/request_feedback_details_input_model.dart';
import '../models/feedback_request_model.dart';

abstract class GetFeedbackRequestDetailsDatasource {
  Future<FeedbackRequestModel> call({
    required RequestFeedbackDetailsInputModel requestFeedbackDetailsParams,
  });
}
