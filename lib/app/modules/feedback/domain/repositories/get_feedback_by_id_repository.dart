import '../../enums/feedback_type_enum.dart';
import '../types/feedback_domain_types.dart';

abstract class GetFeedbackByIdRepository {
  GetFeedbackByIdUsecaseCallback call({
    required String feedbackId,
    required FeedbackTypeEnum feedbackType,
  });
}
