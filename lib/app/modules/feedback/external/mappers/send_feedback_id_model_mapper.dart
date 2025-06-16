import 'dart:convert';

import '../../infra/models/send_feedback_id_model.dart';

class SendFeedbackIdModelMapper {
  SendFeedbackIdModel fromMap({
    required Map<String, dynamic> sentFeedbackIdMap,
  }) {
    return SendFeedbackIdModel(
      id: sentFeedbackIdMap['id'] ?? '',
    );
  }

  SendFeedbackIdModel fromJson({
    required String sentFeedbackIdJson,
  }) {
    if (sentFeedbackIdJson.isEmpty) {
      return fromMap(
        sentFeedbackIdMap: {},
      );
    }

    return fromMap(
      sentFeedbackIdMap: json.decode(sentFeedbackIdJson),
    );
  }
}
