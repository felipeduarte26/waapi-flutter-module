import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/input_models/toggle_notification_setting_input_model.dart';
import '../../infra/datasources/toggle_user_notification_setting_datasource.dart';
import '../mappers/toggle_notification_setting_input_model_mapper.dart';

class ToggleUserNotificationSettingDatasourceImpl implements ToggleUserNotificationSettingDatasource {
  final RestService _restService;
  final ToggleNotificationSettingInputModelMapper _toggleNotificationSettingInputModelMapper;

  const ToggleUserNotificationSettingDatasourceImpl({
    required RestService restService,
    required ToggleNotificationSettingInputModelMapper toggleNotificationSettingInputModelMapper,
  })  : _restService = restService,
        _toggleNotificationSettingInputModelMapper = toggleNotificationSettingInputModelMapper;

  @override
  Future<void> call({
    required ToggleNotificationSettingInputModel toggleNotificationSettingInputModel,
  }) async {
    await _restService.appEmployeeNotification().post(
          '/actions/toggleUserNotificationSetting',
          body: _toggleNotificationSettingInputModelMapper.toMap(
            toggleNotificationSettingInputModel: toggleNotificationSettingInputModel,
          ),
        );
  }
}
