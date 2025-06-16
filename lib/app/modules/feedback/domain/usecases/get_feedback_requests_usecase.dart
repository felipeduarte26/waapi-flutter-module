import '../repositories/get_feedback_requests_repository.dart';
import '../types/feedback_domain_types.dart';

abstract class GetFeedbackRequestsUsecase {
  GetFeedbackRequestsUsecaseCallback call();
}

class GetFeedbackRequestsUsecaseImpl implements GetFeedbackRequestsUsecase {
  final GetFeedbackRequestsRepository _getFeedbackRequestsRepository;

  const GetFeedbackRequestsUsecaseImpl({
    required GetFeedbackRequestsRepository getFeedbackRequestsRepository,
  }) : _getFeedbackRequestsRepository = getFeedbackRequestsRepository;

  @override
  GetFeedbackRequestsUsecaseCallback call() async {
    final getFeedbackRequestsUsecaseCallback = await _getFeedbackRequestsRepository.call();

    getFeedbackRequestsUsecaseCallback.fold(
      (left) {
        return left;
      },
      (feedbackRequestEntityList) {
        feedbackRequestEntityList.sort(
          (
            feedbackRequestEntityA,
            feedbackRequestEntityB,
          ) {
            return feedbackRequestEntityB.when.compareTo(
              feedbackRequestEntityA.when,
            );
          },
        );
        return feedbackRequestEntityList;
      },
    );
    return getFeedbackRequestsUsecaseCallback;
  }
}
