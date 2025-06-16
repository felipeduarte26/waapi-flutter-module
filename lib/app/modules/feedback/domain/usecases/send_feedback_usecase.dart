import '../../../../core/types/either.dart';
import '../../enums/feedback_analytics_type_enum.dart';
import '../failures/feedback_failure.dart';
import '../input_models/send_feedback_input_model.dart';
import '../repositories/send_feedback_repository.dart';
import '../types/feedback_domain_types.dart';

abstract class SendFeedbackUsecase {
  SendFeedbackUsecaseCallback call({
    required SendFeedbackInputModel sendFeedbackInputModel,
    required FeedbackAnalyticsTypeEnum feedbackAnalyticsTypeEnum,
  });
}

class SendFeedbackUsecaseImpl implements SendFeedbackUsecase {
  final SendFeedbackRepository _sendFeedbackRepository;

  const SendFeedbackUsecaseImpl({
    required SendFeedbackRepository sendFeedbackRepository,
  }) : _sendFeedbackRepository = sendFeedbackRepository;

  @override
  SendFeedbackUsecaseCallback call({
    required SendFeedbackInputModel sendFeedbackInputModel,
    required FeedbackAnalyticsTypeEnum feedbackAnalyticsTypeEnum,
  }) async {
    if (sendFeedbackInputModel.starCount == 0 && sendFeedbackInputModel.proficiency == null) {
      return left(const SendFeedbackRequirementsFailure());
    }

    return _sendFeedbackRepository.call(
      sendFeedbackInputModel: sendFeedbackInputModel,
      feedbackAnalyticsTypeEnum: feedbackAnalyticsTypeEnum,
    );
  }
}
