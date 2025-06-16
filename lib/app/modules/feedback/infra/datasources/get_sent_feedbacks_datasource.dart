import '../../../../core/pagination/pagination_requirements.dart';
import '../models/feedback_model.dart';

abstract class GetSentFeedbacksDatasource {
  Future<List<FeedbackModel>> call({
    required PaginationRequirements paginationRequirements,
  });
}
