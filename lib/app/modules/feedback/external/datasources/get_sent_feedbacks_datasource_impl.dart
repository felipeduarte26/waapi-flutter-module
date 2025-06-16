import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../enums/feedback_type_enum.dart';
import '../../infra/datasources/get_sent_feedbacks_datasource.dart';
import '../../infra/models/feedback_model.dart';
import '../mappers/feedback_model_list_mapper.dart';

class GetSentFeedbacksDatasourceImpl implements GetSentFeedbacksDatasource {
  final RestService _restService;
  final FeedbackModelListMapper _feedbackModelListMapper;

  const GetSentFeedbacksDatasourceImpl({
    required RestService restService,
    required FeedbackModelListMapper feedbackModelListMapper,
  })  : _restService = restService,
        _feedbackModelListMapper = feedbackModelListMapper;

  @override
  Future<List<FeedbackModel>> call({
    required PaginationRequirements paginationRequirements,
  }) async {
    final sentFeedbacksResult = await _restService.legacyManagementPanelService().get(
      '/feedback/sent/paged',
      queryParameters: {
        'limit': paginationRequirements.limit,
        'offset': paginationRequirements.offset,
      },
    );

    return _feedbackModelListMapper.fromJson(
      json: sentFeedbacksResult.data!,
      feedbackType: FeedbackTypeEnum.sent,
    );
  }
}
