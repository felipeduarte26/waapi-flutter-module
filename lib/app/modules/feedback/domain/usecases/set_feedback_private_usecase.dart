import '../../../../core/types/either.dart';
import '../failures/feedback_failure.dart';
import '../repositories/set_feedback_private_repository.dart';
import '../types/feedback_domain_types.dart';

abstract class SetFeedbackPrivateUsecase {
  SetFeedbackPrivateUsecaseCallback call({
    required bool isUserAllowedToToggleInternalFeedbackSharing,
    required String idFeedback,
  });
}

class SetFeedbackPrivateUsecaseImpl implements SetFeedbackPrivateUsecase {
  final SetFeedbackPrivateRepository _setFeedbackPrivateRepository;

  const SetFeedbackPrivateUsecaseImpl({
    required SetFeedbackPrivateRepository setFeedbackPrivateRepository,
  }) : _setFeedbackPrivateRepository = setFeedbackPrivateRepository;

  @override
  SetFeedbackPrivateUsecaseCallback call({
    required bool isUserAllowedToToggleInternalFeedbackSharing,
    required String idFeedback,
  }) async {
    if (isUserAllowedToToggleInternalFeedbackSharing) {
      return _setFeedbackPrivateRepository.call(
        idFeedback: idFeedback,
      );
    }

    return left(const NoPermissionToToggleInternalFeedbackSharingFailure());
  }
}
