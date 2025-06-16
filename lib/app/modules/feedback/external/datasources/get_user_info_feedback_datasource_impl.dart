import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_user_info_feedback_datasource.dart';
import '../../infra/models/user_info_feedback_model.dart';
import '../mappers/user_info_feedback_model_mapper.dart';

class GetUserInfoFeedbackDatasourceImpl implements GetUserInfoFeedbackDatasource {
  final RestService _restService;
  final UserInfoFeedbackModelMapper _userInfoFeedbackModelMapper;

  const GetUserInfoFeedbackDatasourceImpl({
    required RestService restService,
    required UserInfoFeedbackModelMapper userInfoFeedbackModelMapper,
  })  : _restService = restService,
        _userInfoFeedbackModelMapper = userInfoFeedbackModelMapper;

  @override
  Future<UserInfoFeedbackModel> call({
    required String userId,
  }) async {
    final personPath = '/person/$userId';
    final userInfoFeedbackModelResult = await _restService.legacyManagementPanelService().post(personPath);

    return _userInfoFeedbackModelMapper.fromJson(
      userInfoJson: userInfoFeedbackModelResult.data ?? '{}',
    );
  }
}
