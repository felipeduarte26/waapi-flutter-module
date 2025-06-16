import 'dart:convert';

import '../../infra/models/feedback_request_model.dart';
import 'feedback_request_by_me_model_mapper.dart';
import 'feedback_request_to_me_model_mapper.dart';

class FeedbackRequestModelMapper {
  final FeedbackRequestByMeModelMapper _feedbackRequestByMeModelMapper;
  final FeedbackRequestToMeModelMapper _feedbackRequestToMeModelMapper;

  const FeedbackRequestModelMapper({
    required FeedbackRequestByMeModelMapper feedbackRequestByMeModelMapper,
    required FeedbackRequestToMeModelMapper feedbackRequestToMeModelMapper,
  })  : _feedbackRequestByMeModelMapper = feedbackRequestByMeModelMapper,
        _feedbackRequestToMeModelMapper = feedbackRequestToMeModelMapper;

  FeedbackRequestModel fromJson({
    required String jsonFeedbackRequest,
    required bool isRequestedByMe,
  }) {
    final Map<String, dynamic> mapFeedbackRequest = json.decode(jsonFeedbackRequest);

    if (isRequestedByMe) {
      return _feedbackRequestByMeModelMapper.fromMap(
        map: mapFeedbackRequest,
      );
    }

    return _feedbackRequestToMeModelMapper.fromMap(
      map: mapFeedbackRequest,
    );
  }
}
