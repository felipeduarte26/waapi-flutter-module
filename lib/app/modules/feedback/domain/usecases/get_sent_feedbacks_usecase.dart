import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/types/either.dart';
import '../failures/feedback_failure.dart';
import '../repositories/get_sent_feedbacks_repository.dart';
import '../types/feedback_domain_types.dart';

abstract class GetSentFeedbacksUsecase {
  GetSentFeedbacksUsecaseCallback call({
    required bool isUserAllowedToViewMyFeedbacks,
    required PaginationRequirements paginationRequirements,
  });
}

class GetSentFeedbacksUsecaseImpl implements GetSentFeedbacksUsecase {
  final GetSentFeedbacksRepository _getSentFeedbacksRepository;

  const GetSentFeedbacksUsecaseImpl({
    required GetSentFeedbacksRepository getSentFeedbacksRepository,
  }) : _getSentFeedbacksRepository = getSentFeedbacksRepository;

  @override
  GetSentFeedbacksUsecaseCallback call({
    required bool isUserAllowedToViewMyFeedbacks,
    required PaginationRequirements paginationRequirements,
  }) async {
    if (isUserAllowedToViewMyFeedbacks) {
      return _getSentFeedbacksRepository.call(
        paginationRequirements: paginationRequirements,
      );
    }

    return left(const NoPermissionToViewMyFeedbacksFailure());
  }
}
