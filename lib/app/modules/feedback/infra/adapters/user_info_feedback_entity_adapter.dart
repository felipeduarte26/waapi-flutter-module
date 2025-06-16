import '../../domain/entities/user_info_feedback_entity.dart';
import '../models/user_info_feedback_model.dart';

class UserInfoFeedbackEntityAdapter {
  UserInfoFeedbackEntity fromModel({
    required UserInfoFeedbackModel userInfoFeedbackModel,
  }) {
    return UserInfoFeedbackEntity(
      id: userInfoFeedbackModel.id,
      name: userInfoFeedbackModel.name,
      username: userInfoFeedbackModel.username,
      nickname: userInfoFeedbackModel.nickname,
      link: userInfoFeedbackModel.link,
      linkPhoto: userInfoFeedbackModel.linkPhoto,
    );
  }
}
