import '../../../../core/types/either.dart';
import '../../domain/entities/feedback_request_entity.dart';
import '../../domain/failures/feedback_failure.dart';
import '../../domain/input_models/request_feedback_details_input_model.dart';
import '../../domain/repositories/get_feedback_request_details_repository.dart';
import '../../domain/types/feedback_domain_types.dart';
import '../adapters/feedback_request_by_me_entity_adapter.dart';
import '../adapters/feedback_request_to_me_entity_adapter.dart';
import '../datasources/get_feedback_request_details_datasource.dart';
import '../models/feedback_request_by_me_model.dart';

class GetFeedbackRequestDetailsRepositoryImpl implements GetFeedbackRequestDetailsRepository {
  final GetFeedbackRequestDetailsDatasource _getFeedbackRequestDetailsDatasource;
  final FeedbackRequestByMeEntityAdapter _feedbackRequestByMeEntityAdapter;
  final FeedbackRequestToMeEntityAdapter _feedbackRequestToMeEntityAdapter;

  const GetFeedbackRequestDetailsRepositoryImpl({
    required GetFeedbackRequestDetailsDatasource getFeedbackRequestDetailsDatasource,
    required FeedbackRequestByMeEntityAdapter feedbackRequestByMeEntityAdapter,
    required FeedbackRequestToMeEntityAdapter feedbackRequestToMeEntityAdapter,
  })  : _getFeedbackRequestDetailsDatasource = getFeedbackRequestDetailsDatasource,
        _feedbackRequestByMeEntityAdapter = feedbackRequestByMeEntityAdapter,
        _feedbackRequestToMeEntityAdapter = feedbackRequestToMeEntityAdapter;

  @override
  RequestFeedbackDetailUsecaseCallback call({
    required RequestFeedbackDetailsInputModel requestFeedbackDetailsParams,
  }) async {
    try {
      final feedbackRequestModel = await _getFeedbackRequestDetailsDatasource.call(
        requestFeedbackDetailsParams: requestFeedbackDetailsParams,
      );

      FeedbackRequestEntity feedbackRequestEntity;

      feedbackRequestEntity = feedbackRequestModel is FeedbackRequestByMeModel
          ? _feedbackRequestByMeEntityAdapter.fromModel(feedbackRequestModel: feedbackRequestModel)
          : _feedbackRequestToMeEntityAdapter.fromModel(feedbackRequestModel: feedbackRequestModel);

      return right(feedbackRequestEntity);
    } catch (error) {
      return left(const FeedbackDatasourceFailure());
    }
  }
}
