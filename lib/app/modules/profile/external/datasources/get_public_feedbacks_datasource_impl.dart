import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../../feedback/enums/feedback_type_enum.dart';
import '../../../feedback/external/mappers/feedback_model_list_mapper.dart';
import '../../../feedback/infra/models/feedback_model.dart';
import '../../infra/datasources/get_public_feedbacks_datasource.dart';

class GetPublicFeedbacksDatasourceImpl implements GetPublicFeedbacksDatasource {
  final RestService _restService;
  final FeedbackModelListMapper _feedbackModelListMapper;

  GetPublicFeedbacksDatasourceImpl({
    required RestService restService,
    required FeedbackModelListMapper feedbackModelListMapper,
  })  : _restService = restService,
        _feedbackModelListMapper = feedbackModelListMapper;

  @override
  Future<List<FeedbackModel>> call({
    required String employeeId,
    required PaginationRequirements paginationRequirements,
  }) async {
    final receivedFeedbacksResult = await _restService.legacyManagementPanelService().get(
      '/feedback/$employeeId/public',
      queryParameters: {
        'offset': paginationRequirements.offset,
        'limit': paginationRequirements.limit,
      },
    );

    return _feedbackModelListMapper.fromJson(
      json: receivedFeedbacksResult.data!,
      feedbackType: FeedbackTypeEnum.public,
    );
  }
}
