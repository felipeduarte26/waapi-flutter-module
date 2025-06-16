import '../types/feedback_domain_types.dart';

abstract class SetFeedbackPublicRepository {
  SetFeedbackPublicUsecaseCallback call({
    required String idFeedback,
  });
}
