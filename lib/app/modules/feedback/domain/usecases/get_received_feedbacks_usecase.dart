import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/types/either.dart';
import '../failures/feedback_failure.dart';
import '../repositories/get_received_feedbacks_repository.dart';
import '../types/feedback_domain_types.dart';

abstract class GetReceivedFeedbacksUsecase {
  GetReceivedFeedbacksUsecaseCallback call({
    required bool isUserAllowedToViewMyFeedbacks,
    required PaginationRequirements paginationRequirements,
  });
}

class GetReceivedFeedbacksUsecaseImpl implements GetReceivedFeedbacksUsecase {
  final GetReceivedFeedbacksRepository _getReceivedFeedbacksRepository;

  const GetReceivedFeedbacksUsecaseImpl({
    required GetReceivedFeedbacksRepository getReceivedFeedbacksRepository,
  }) : _getReceivedFeedbacksRepository = getReceivedFeedbacksRepository;

  @override
  GetReceivedFeedbacksUsecaseCallback call({
    required bool isUserAllowedToViewMyFeedbacks,
    required PaginationRequirements paginationRequirements,
  }) async {
    if (isUserAllowedToViewMyFeedbacks) {
      return _getReceivedFeedbacksRepository.call(
        paginationRequirements: paginationRequirements,
      );
    }

    return left(const NoPermissionToViewMyFeedbacksFailure());
  }
}
