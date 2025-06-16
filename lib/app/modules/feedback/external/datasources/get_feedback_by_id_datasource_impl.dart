import '../../../../core/services/rest_client/rest_service.dart';
import '../../enums/feedback_type_enum.dart';
import '../../infra/datasources/get_feedback_by_id_datasource.dart';
import '../../infra/models/feedback_model.dart';
import '../mappers/feedback_model_mapper.dart';

class GetFeedbackByIdDatasourceImpl implements GetFeedbackByIdDatasource {
  final RestService _restService;
  final FeedbackModelMapper _feedbackModelMapper;

  const GetFeedbackByIdDatasourceImpl({
    required RestService restService,
    required FeedbackModelMapper feedbackModelMapper,
  })  : _restService = restService,
        _feedbackModelMapper = feedbackModelMapper;

  @override
  Future<FeedbackModel> call({
    required String feedbackId,
    required FeedbackTypeEnum feedbackType,
  }) async {
    final feedbackPath = '/feedback/$feedbackId';
    final feedbackResult = await _restService.legacyManagementPanelService().get(feedbackPath);

    return _feedbackModelMapper.fromJson(
      json: feedbackResult.data!,
      feedbackType: feedbackType,
    );
  }
}
