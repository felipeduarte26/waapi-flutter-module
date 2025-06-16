import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/input_models/request_feedback_details_input_model.dart';
import '../../infra/datasources/get_feedback_request_details_datasource.dart';
import '../../infra/models/feedback_request_model.dart';
import '../mappers/feedback_request_model_mapper.dart';

class GetFeedbackRequestDetailsDatasourceImpl implements GetFeedbackRequestDetailsDatasource {
  final RestService _restService;
  final FeedbackRequestModelMapper _requestModelMapper;

  const GetFeedbackRequestDetailsDatasourceImpl({
    required RestService restService,
    required FeedbackRequestModelMapper requestModelMapper,
  })  : _restService = restService,
        _requestModelMapper = requestModelMapper;

  @override
  Future<FeedbackRequestModel> call({
    required RequestFeedbackDetailsInputModel requestFeedbackDetailsParams,
  }) async {
    final feedbackDetailsPath = '/feedbackrequest/${requestFeedbackDetailsParams.requestFeedbackId}';
    final feedbackRequestResult = await _restService.legacyManagementPanelService().get(feedbackDetailsPath);

    return _requestModelMapper.fromJson(
      jsonFeedbackRequest: feedbackRequestResult.data ?? '{}',
      isRequestedByMe: requestFeedbackDetailsParams.isRequestedByMe,
    );
  }
}
