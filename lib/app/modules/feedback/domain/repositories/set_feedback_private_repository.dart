import '../types/feedback_domain_types.dart';

abstract class SetFeedbackPrivateRepository {
  SetFeedbackPrivateUsecaseCallback call({
    required String idFeedback,
  });
}
