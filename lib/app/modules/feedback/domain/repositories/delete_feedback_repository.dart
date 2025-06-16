import '../types/feedback_domain_types.dart';

abstract class DeleteFeedbackRepository {
  DeleteFeedbackUsecaseCallback call({
    required String idFeedback,
  });
}
