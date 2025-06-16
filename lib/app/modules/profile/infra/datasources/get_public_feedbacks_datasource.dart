import '../../../../core/pagination/pagination_requirements.dart';
import '../../../feedback/infra/models/feedback_model.dart';

abstract class GetPublicFeedbacksDatasource {
  Future<List<FeedbackModel>> call({
    required String employeeId,
    required PaginationRequirements paginationRequirements,
  });
}
