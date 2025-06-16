import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_feedback_requests_datasource.dart';
import '../../infra/models/feedback_request_model.dart';
import '../mappers/feedback_request_by_me_model_mapper.dart';
import '../mappers/feedback_request_to_me_model_mapper.dart';

class GetFeedbackRequestsDatasourceImpl implements GetFeedbackRequestsDatasource {
  final RestService _restService;
  final FeedbackRequestByMeModelMapper _feedbackRequestByMeModelMapper;
  final FeedbackRequestToMeModelMapper _feedbackRequestToMeModelMapper;

  const GetFeedbackRequestsDatasourceImpl({
    required RestService restService,
    required FeedbackRequestByMeModelMapper feedbackRequestByMeModelMapper,
    required FeedbackRequestToMeModelMapper feedbackRequestToMeModelMapper,
  })  : _restService = restService,
        _feedbackRequestByMeModelMapper = feedbackRequestByMeModelMapper,
        _feedbackRequestToMeModelMapper = feedbackRequestToMeModelMapper;

  @override
  Future<List<FeedbackRequestModel>> call() async {
    final feedbackRequestResult = await _restService.legacyManagementPanelService().get('/feedbackrequest');

    final feedbackRequestByMeModelList = _feedbackRequestByMeModelMapper.fromJsonList(
      feedbacksRequestedByMeJson: feedbackRequestResult.data ?? '{}',
    );

    final feedbackRequestToMeModelList = _feedbackRequestToMeModelMapper.fromJsonList(
      feedbacksRequestJson: feedbackRequestResult.data ?? '{}',
    );

    return [
      ...feedbackRequestByMeModelList,
      ...feedbackRequestToMeModelList,
    ];
  }
}
