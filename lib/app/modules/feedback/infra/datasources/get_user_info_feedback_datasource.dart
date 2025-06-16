import '../models/user_info_feedback_model.dart';

abstract class GetUserInfoFeedbackDatasource {
  Future<UserInfoFeedbackModel> call({
    required String userId,
  });
}
