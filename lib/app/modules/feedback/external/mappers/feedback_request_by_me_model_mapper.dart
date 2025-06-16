import 'dart:convert';

import '../../../../core/helper/date_time_helper.dart';
import '../../helper/feedback_request_status_helper.dart';
import '../../infra/models/feedback_request_by_me_model.dart';

class FeedbackRequestByMeModelMapper {
  FeedbackRequestByMeModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return FeedbackRequestByMeModel(
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

  List<FeedbackRequestByMeModel> fromJsonList({
    required String feedbacksRequestedByMeJson,
  }) {
    if (feedbacksRequestedByMeJson.isEmpty) {
      return [];
    }

    final Map<String, dynamic> feedbackRequestResultMapData = json.decode(feedbacksRequestedByMeJson);
    final feedbackRequestByMeMapData = (feedbackRequestResultMapData['requestedByMe'] ?? []) as List;

    return (feedbackRequestByMeMapData).map(
      (requestMap) {
        return fromMap(
          map: requestMap,
        );
      },
    ).toList();
  }
}
