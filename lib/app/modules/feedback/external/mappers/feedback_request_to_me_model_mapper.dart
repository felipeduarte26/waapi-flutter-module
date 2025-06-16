import 'dart:convert';

import '../../../../core/helper/date_time_helper.dart';
import '../../helper/feedback_request_status_helper.dart';
import '../../infra/models/feedback_request_to_me_model.dart';

class FeedbackRequestToMeModelMapper {
  FeedbackRequestToMeModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return FeedbackRequestToMeModel(
      id: map['id'] ?? '',
      when: DateTimeHelper.convertStringIso8601toDateTime(
        stringIso8601: map['when'] ?? '',
      ),
      fromPersonId: map['fromPersonId'] ?? '',
      toPersonId: map['toPersonId'] ?? '',
      status: FeedbackRequestStatusHelper.stringToEnum(
        string: map['status'],
      ),
      text: map['text'] ?? '',
      photoLinkFrom: map['photoLinkFrom'] ?? '',
      nameFrom: map['nameFrom'] ?? '',
      photoLinkTo: map['photoLinkTo'] ?? '',
      nameTo: map['nameTo'] ?? '',
      fromUsername: map['fromUsername'] ?? '',
      toUsername: map['toUsername'] ?? '',
    );
  }

  List<FeedbackRequestToMeModel> fromJsonList({
    required String feedbacksRequestJson,
  }) {
    if (feedbacksRequestJson.isEmpty) {
      return [];
    }

    final Map<String, dynamic> feedbackRequestResultMapData = json.decode(feedbacksRequestJson);
    final feedbackRequestToMeMapData = (feedbackRequestResultMapData['requestedToMe'] ?? []) as List;

    return (feedbackRequestToMeMapData).map(
      (requestMap) {
        return fromMap(
          map: requestMap,
        );
      },
    ).toList();
  }
}
