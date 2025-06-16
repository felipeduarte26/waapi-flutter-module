import '../../domain/input_models/request_feedback_input_model.dart';

abstract class RequestFeedbackDatasource {
  Future<void> call({
    required RequestFeedbackInputModel requestFeedbackInputModel,
  });
}
