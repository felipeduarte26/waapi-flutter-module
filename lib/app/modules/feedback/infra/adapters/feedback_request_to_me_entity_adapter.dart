import '../../domain/entities/feedback_request_entity.dart';
import '../../domain/entities/feedback_request_to_me_entity.dart';
import '../models/feedback_request_model.dart';

class FeedbackRequestToMeEntityAdapter {
  FeedbackRequestEntity fromModel({
    required FeedbackRequestModel feedbackRequestModel,
  }) {
    return FeedbackRequestToMeEntity(
      id: feedbackRequestModel.id,
      when: feedbackRequestModel.when,
      fromPersonId: feedbackRequestModel.fromPersonId,
      toPersonId: feedbackRequestModel.toPersonId,
      status: feedbackRequestModel.status,
      text: feedbackRequestModel.text,
      photoLinkFrom: feedbackRequestModel.photoLinkFrom,
      nameFrom: feedbackRequestModel.nameFrom,
      photoLinkTo: feedbackRequestModel.photoLinkTo,
      nameTo: feedbackRequestModel.nameTo,
      fromUsername: feedbackRequestModel.fromUsername,
      toUsername: feedbackRequestModel.toUsername,
    );
  }
}
