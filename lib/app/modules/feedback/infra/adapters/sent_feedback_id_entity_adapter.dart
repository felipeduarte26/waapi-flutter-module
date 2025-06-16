import '../../domain/entities/sent_feedback_id_entity.dart';
import '../models/send_feedback_id_model.dart';

class SentFeedbackIdEntityAdapter {
  SentFeedbackIdEntity fromModel({
    required SendFeedbackIdModel sentFeedbackIdModel,
  }) {
    return SentFeedbackIdEntity(
      id: sentFeedbackIdModel.id,
    );
  }
}
