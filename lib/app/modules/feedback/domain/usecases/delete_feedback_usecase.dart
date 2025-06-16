import '../repositories/delete_feedback_repository.dart';
import '../types/feedback_domain_types.dart';

abstract class DeleteFeedbackUsecase {
  DeleteFeedbackUsecaseCallback call({
    required String idFeedback,
  });
}

class DeleteFeedbackUsecaseImpl implements DeleteFeedbackUsecase {
  final DeleteFeedbackRepository _deleteFeedbackRepository;

  const DeleteFeedbackUsecaseImpl({
    required DeleteFeedbackRepository deleteFeedbackRepository,
  }) : _deleteFeedbackRepository = deleteFeedbackRepository;

  @override
  DeleteFeedbackUsecaseCallback call({
    required String idFeedback,
  }) {
    return _deleteFeedbackRepository.call(
      idFeedback: idFeedback,
    );
  }
}
