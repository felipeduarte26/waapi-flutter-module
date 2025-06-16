import '../../domain/input_models/request_feedback_input_model.dart';

class RequestFeedbackInputModelMapper {
  Map<String, dynamic> toMap({
    required RequestFeedbackInputModel requestFeedbackInputModel,
  }) {
    return {
      'message': requestFeedbackInputModel.message,
      'targetPeopleId': [
        requestFeedbackInputModel.receiverId,
      ],
    };
  }
}
