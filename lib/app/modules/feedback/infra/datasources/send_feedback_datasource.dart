import '../../domain/input_models/send_feedback_input_model.dart';
import '../models/send_feedback_id_model.dart';

abstract class SendFeedbackDatasource {
  Future<SendFeedbackIdModel> call({
    required SendFeedbackInputModel sendFeedbackInputModel,
  });
}
