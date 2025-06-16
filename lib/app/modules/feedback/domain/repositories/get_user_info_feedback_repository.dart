import '../types/feedback_domain_types.dart';

abstract class GetUserInfoFeedbackRepository {
  GetUserInfoFeedbackEntityUsecaseCallback call({
    required String userId,
  });
}
