import 'dart:convert';

import '../../infra/models/user_info_feedback_model.dart';

class UserInfoFeedbackModelMapper {
  UserInfoFeedbackModel fromMap({
    required Map<String, dynamic> userInfoMap,
  }) {
    return UserInfoFeedbackModel(
      link: userInfoMap['link'] ?? '',
      linkPhoto: userInfoMap['linkPhoto'] ?? '',
      id: userInfoMap['id'] ?? '',
      name: userInfoMap['name'] ?? '',
      nickname: userInfoMap['nickname'] ?? '',
      username: userInfoMap['username'] ?? '',
    );
  }

  UserInfoFeedbackModel fromJson({
    required String userInfoJson,
  }) {
    if (userInfoJson.isEmpty) {
      return fromMap(
        userInfoMap: {},
      );
    }

    return fromMap(
      userInfoMap: json.decode(userInfoJson),
    );
  }
}
