import '../../../../core/types/either.dart';
import '../failures/feedback_failure.dart';
import '../input_models/request_feedback_details_input_model.dart';
import '../repositories/get_feedback_request_details_repository.dart';
import '../types/feedback_domain_types.dart';

abstract class GetFeedbackRequestDetailsUsecase {
  RequestFeedbackDetailUsecaseCallback call({
    required RequestFeedbackDetailsInputModel requestFeedbackDetailsParams,
  });
}

class GetFeedbackRequestDetailsUsecaseImpl implements GetFeedbackRequestDetailsUsecase {
  final GetFeedbackRequestDetailsRepository _getFeedbackRequestDetailsRepository;

  const GetFeedbackRequestDetailsUsecaseImpl({
    required GetFeedbackRequestDetailsRepository getFeedbackRequestDetailsRepository,
  }) : _getFeedbackRequestDetailsRepository = getFeedbackRequestDetailsRepository;

  @override
  RequestFeedbackDetailUsecaseCallback call({
    required RequestFeedbackDetailsInputModel requestFeedbackDetailsParams,
  }) async {
    if (requestFeedbackDetailsParams.requestFeedbackId.isEmpty) {
      return left(
        const RequestFeedbackDetailsRequirementsFailure(),
      );
    }

    return _getFeedbackRequestDetailsRepository.call(
      requestFeedbackDetailsParams: requestFeedbackDetailsParams,
    );
  }
}
