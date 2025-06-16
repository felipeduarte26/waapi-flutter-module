import '../../enums/feedback_type_enum.dart';
import '../models/feedback_model.dart';

abstract class GetFeedbackByIdDatasource {
  Future<FeedbackModel> call({
    required String feedbackId,
    required FeedbackTypeEnum feedbackType,
  });
}
