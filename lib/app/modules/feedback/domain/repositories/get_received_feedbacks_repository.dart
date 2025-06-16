import '../../../../core/pagination/pagination_requirements.dart';
import '../types/feedback_domain_types.dart';

abstract class GetReceivedFeedbacksRepository {
  GetReceivedFeedbacksUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  });
}
