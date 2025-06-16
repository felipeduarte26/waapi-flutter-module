import '../../enums/feedback_analytics_type_enum.dart';
import '../input_models/send_feedback_input_model.dart';
import '../types/feedback_domain_types.dart';

abstract class SendFeedbackRepository {
  SendFeedbackUsecaseCallback call({
    required SendFeedbackInputModel sendFeedbackInputModel,
    required FeedbackAnalyticsTypeEnum feedbackAnalyticsTypeEnum,
  });
}
