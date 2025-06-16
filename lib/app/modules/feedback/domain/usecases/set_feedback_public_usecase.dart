import '../../../../core/types/either.dart';
import '../failures/feedback_failure.dart';
import '../repositories/set_feedback_public_repository.dart';
import '../types/feedback_domain_types.dart';

abstract class SetFeedbackPublicUsecase {
  SetFeedbackPublicUsecaseCallback call({
    required bool isUserAllowedToToggleInternalFeedbackSharing,
    required String idFeedback,
  });
}

class SetFeedbackPublicUsecaseImpl implements SetFeedbackPublicUsecase {
  final SetFeedbackPublicRepository _setFeedbackPublicRepository;

  const SetFeedbackPublicUsecaseImpl({
    required SetFeedbackPublicRepository setFeedbackPublicRepository,
  }) : _setFeedbackPublicRepository = setFeedbackPublicRepository;

  @override
  SetFeedbackPublicUsecaseCallback call({
    required bool isUserAllowedToToggleInternalFeedbackSharing,
    required String idFeedback,
  }) async {
    if (isUserAllowedToToggleInternalFeedbackSharing) {
      return _setFeedbackPublicRepository.call(
        idFeedback: idFeedback,
      );
    }

    return left(const NoPermissionToToggleInternalFeedbackSharingFailure());
  }
}
