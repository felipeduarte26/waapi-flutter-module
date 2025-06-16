import '../../../../core/pagination/pagination_requirements.dart';

import '../../../../core/types/either.dart';
import '../../domain/failures/feedback_failure.dart';
import '../../domain/repositories/get_received_feedbacks_repository.dart';
import '../../domain/types/feedback_domain_types.dart';
import '../adapters/feedback_entity_adapter.dart';
import '../datasources/get_received_feedbacks_datasource.dart';

class GetReceivedFeedbacksRepositoryImpl implements GetReceivedFeedbacksRepository {
  final GetReceivedFeedbacksDatasource _getReceivedFeedbacksDatasource;
  final FeedbackEntityAdapter _feedbackEntityAdapter;

  const GetReceivedFeedbacksRepositoryImpl({
    required GetReceivedFeedbacksDatasource getReceivedFeedbacksDatasource,
    required FeedbackEntityAdapter feedbackEntityAdapter,
  })  : _getReceivedFeedbacksDatasource = getReceivedFeedbacksDatasource,
        _feedbackEntityAdapter = feedbackEntityAdapter;

  @override
  GetReceivedFeedbacksUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  }) async {
    try {
      final receivedFeedbackModelList = await _getReceivedFeedbacksDatasource.call(
        paginationRequirements: paginationRequirements,
      );

      final receivedFeedbackEntityList = receivedFeedbackModelList.map(
        (receivedFeedbackModel) {
          return _feedbackEntityAdapter.fromModel(
            feedbackModel: receivedFeedbackModel,
          );
        },
      ).toList();

      return right(receivedFeedbackEntityList);
    } catch (error) {
      return left(const FeedbackDatasourceFailure());
    }
  }
}
