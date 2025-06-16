import 'dart:convert';

import '../../enums/feedback_type_enum.dart';
import '../../infra/models/feedback_model.dart';
import 'feedback_model_mapper.dart';

class FeedbackModelListMapper {
  final FeedbackModelMapper _feedbackModelMapper;

  const FeedbackModelListMapper({
    required FeedbackModelMapper feedbackModelMapper,
  }) : _feedbackModelMapper = feedbackModelMapper;

  List<FeedbackModel> _fromMap({
    required Map<String, dynamic> map,
    required FeedbackTypeEnum feedbackType,
  }) {
    return map['list'] == null
        ? List.empty()
        : (map['list'] as List).map(
            (feedbackMap) {
              return _feedbackModelMapper.fromMap(
                map: feedbackMap,
                feedbackType: feedbackType,
              );
            },
          ).toList();
  }

  List<FeedbackModel> fromJson({
    required String json,
    required FeedbackTypeEnum feedbackType,
  }) {
    return json.isNotEmpty
        ? _fromMap(
            map: jsonDecode(json),
            feedbackType: feedbackType,
          )
        : [];
  }
}
