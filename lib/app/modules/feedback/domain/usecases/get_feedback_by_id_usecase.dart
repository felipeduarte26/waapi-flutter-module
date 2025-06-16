import '../../../../core/types/either.dart';
import '../../enums/feedback_type_enum.dart';
import '../failures/feedback_failure.dart';
import '../repositories/get_feedback_by_id_repository.dart';
import '../types/feedback_domain_types.dart';

abstract class GetFeedbackByIdUsecase {
  GetFeedbackByIdUsecaseCallback call({
    required String feedbackId,
    required FeedbackTypeEnum feedbackType,
  });
}

class GetFeedbackByIdUsecaseImpl implements GetFeedbackByIdUsecase {
  final GetFeedbackByIdRepository _getFeedbackByIdRepository;

  const GetFeedbackByIdUsecaseImpl({
    required GetFeedbackByIdRepository getFeedbackByIdRepository,
  }) : _getFeedbackByIdRepository = getFeedbackByIdRepository;

  @override
  GetFeedbackByIdUsecaseCallback call({
    required String feedbackId,
    required FeedbackTypeEnum feedbackType,
  }) async {
    if (feedbackId.isNotEmpty) {
      return _getFeedbackByIdRepository.call(
        feedbackId: feedbackId,
        feedbackType: feedbackType,
      );
    }

    return left(const InvalidFeedbackIdFailure());
  }
}
