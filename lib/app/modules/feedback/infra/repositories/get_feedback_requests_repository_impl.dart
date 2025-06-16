import '../../../../core/types/either.dart';
import '../../domain/failures/feedback_failure.dart';
import '../../domain/repositories/get_feedback_requests_repository.dart';
import '../../domain/types/feedback_domain_types.dart';
import '../adapters/feedback_request_by_me_entity_adapter.dart';
import '../adapters/feedback_request_to_me_entity_adapter.dart';
import '../datasources/get_feedback_requests_datasource.dart';
import '../models/feedback_request_by_me_model.dart';

class GetFeedbackRequestsRepositoryImpl implements GetFeedbackRequestsRepository {
  final GetFeedbackRequestsDatasource _getFeedbackRequestsDatasource;
  final FeedbackRequestByMeEntityAdapter _feedbackRequestByMeEntityAdapter;
  final FeedbackRequestToMeEntityAdapter _feedbackRequestToMeEntityAdapter;

  const GetFeedbackRequestsRepositoryImpl({
    required GetFeedbackRequestsDatasource getFeedbackRequestsDatasource,
    required FeedbackRequestByMeEntityAdapter feedbackRequestByMeEntityAdapter,
    required FeedbackRequestToMeEntityAdapter feedbackRequestToMeEntityAdapter,
  })  : _getFeedbackRequestsDatasource = getFeedbackRequestsDatasource,
        _feedbackRequestByMeEntityAdapter = feedbackRequestByMeEntityAdapter,
        _feedbackRequestToMeEntityAdapter = feedbackRequestToMeEntityAdapter;

  @override
  GetFeedbackRequestsUsecaseCallback call() async {
    try {
      final feedbackRequestModelList = await _getFeedbackRequestsDatasource.call();

      final feedbackRequestEntityList = feedbackRequestModelList.map(
        (feedbackRequestModel) {
          if (feedbackRequestModel is FeedbackRequestByMeModel) {
            return _feedbackRequestByMeEntityAdapter.fromModel(
              feedbackRequestModel: feedbackRequestModel,
            );
          }

          return _feedbackRequestToMeEntityAdapter.fromModel(
            feedbackRequestModel: feedbackRequestModel,
          );
        },
      ).toList();

      return right(feedbackRequestEntityList);
    } catch (error) {
      return left(const FeedbackDatasourceFailure());
    }
  }
}
