import '../../../../core/pagination/pagination_requirements.dart';

import '../../../../core/types/either.dart';
import '../../domain/failures/feedback_failure.dart';
import '../../domain/repositories/get_sent_feedbacks_repository.dart';
import '../../domain/types/feedback_domain_types.dart';
import '../adapters/feedback_entity_adapter.dart';
import '../datasources/get_sent_feedbacks_datasource.dart';

class GetSentFeedbacksRepositoryImpl implements GetSentFeedbacksRepository {
  final GetSentFeedbacksDatasource _getSentFeedbacksDatasource;
  final FeedbackEntityAdapter _feedbackEntityAdapter;

  const GetSentFeedbacksRepositoryImpl({
    required GetSentFeedbacksDatasource getSentFeedbacksDatasource,
    required FeedbackEntityAdapter feedbackEntityAdapter,
  })  : _getSentFeedbacksDatasource = getSentFeedbacksDatasource,
        _feedbackEntityAdapter = feedbackEntityAdapter;

  @override
  GetSentFeedbacksUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  }) async {
    try {
      final sentFeedbackModelList = await _getSentFeedbacksDatasource.call(
        paginationRequirements: paginationRequirements,
      );

      final sentFeedbackEntityList = sentFeedbackModelList.map(
        (sentFeedbackModel) {
          return _feedbackEntityAdapter.fromModel(
            feedbackModel: sentFeedbackModel,
          );
        },
      ).toList();

      return right(sentFeedbackEntityList);
    } catch (error) {
      return left(const FeedbackDatasourceFailure());
    }
  }
}
