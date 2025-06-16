import '../models/feedback_request_model.dart';

abstract class GetFeedbackRequestsDatasource {
  Future<List<FeedbackRequestModel>> call();
}
