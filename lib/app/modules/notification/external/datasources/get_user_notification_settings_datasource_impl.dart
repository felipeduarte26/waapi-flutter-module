import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_user_notification_settings_datasource.dart';
import '../../infra/models/user_notification_setting_model.dart';
import '../mappers/user_notification_setting_model_mapper.dart';

class GetUserNotificationSettingsDatasourceImpl implements GetUserNotificationSettingsDatasource {
  final RestService _restService;
  final UserNotificationSettingModelMapper _userNotificationSettingModelMapper;

  const GetUserNotificationSettingsDatasourceImpl({
    required RestService restService,
    required UserNotificationSettingModelMapper userNotificationSettingModelMapper,
  })  : _restService = restService,
        _userNotificationSettingModelMapper = userNotificationSettingModelMapper;

  @override
  Future<List<UserNotificationSettingModel>> call() async {
    final responseServer = await _restService.appEmployeeNotification().get(
          '/queries/getUserNotificationSettings',
        );

    return _userNotificationSettingModelMapper.fromJson(
      userNotificationSettingJson: responseServer.data!,
    );
  }
}
