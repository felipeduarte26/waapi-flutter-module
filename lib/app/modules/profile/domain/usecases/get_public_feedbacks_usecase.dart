import '../../../../core/pagination/pagination_requirements.dart';
import '../repositories/get_public_feedbacks_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetPublicFeedbacksUsecase {
  GetPublicFeedbacksUsecaseCallback call({
    required String employeeId,
    required PaginationRequirements paginationRequirements,
  });
}

class GetPublicFeedbacksUsecaseImpl implements GetPublicFeedbacksUsecase {
  final GetPublicFeedbacksRepository _getPublicFeedbacksRepository;

  const GetPublicFeedbacksUsecaseImpl({
    required GetPublicFeedbacksRepository getPublicFeedbacksRepository,
  }) : _getPublicFeedbacksRepository = getPublicFeedbacksRepository;

  @override
  GetPublicFeedbacksUsecaseCallback call({
    required String employeeId,
    required PaginationRequirements paginationRequirements,
  }) {
    return _getPublicFeedbacksRepository.call(
      employeeId: employeeId,
      paginationRequirements: paginationRequirements,
    );
  }
}
