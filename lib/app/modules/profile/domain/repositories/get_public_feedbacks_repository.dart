import '../../../../core/pagination/pagination_requirements.dart';
import '../types/profile_domain_types.dart';

abstract class GetPublicFeedbacksRepository {
  GetPublicFeedbacksUsecaseCallback call({
    required String employeeId,
    required PaginationRequirements paginationRequirements,
  });
}
