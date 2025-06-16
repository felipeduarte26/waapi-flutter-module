import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/types/either.dart';
import '../failures/feedback_failure.dart';
import '../repositories/get_received_feedbacks_repository.dart';
import '../types/feedback_domain_types.dart';

abstract class GetLatestFeedbacksUsecase {
  GetReceivedFeedbacksUsecaseCallback call({
    required bool isUserAllowedToViewMyFeedbacks,
  });
}

class GetLatestFeedbacksUsecaseImpl implements GetLatestFeedbacksUsecase {
  final GetReceivedFeedbacksRepository _getReceivedFeedbacksRepository;

  const GetLatestFeedbacksUsecaseImpl({
    required GetReceivedFeedbacksRepository getReceivedFeedbacksRepository,
  }) : _getReceivedFeedbacksRepository = getReceivedFeedbacksRepository;

  @override
  GetReceivedFeedbacksUsecaseCallback call({
    required bool isUserAllowedToViewMyFeedbacks,
  }) async {
    if (!isUserAllowedToViewMyFeedbacks) {
      return left(const NoPermissionToViewMyFeedbacksFailure());
    }

    return _getReceivedFeedbacksRepository.call(
      paginationRequirements: const PaginationRequirements(
        page: 1,
        limit: 3,
      ),
    );
  }
}
