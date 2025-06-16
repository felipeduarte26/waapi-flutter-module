import '../../../../core/services/error_logging/error_logging_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/notification_failure.dart';
import '../../domain/repositories/get_user_notification_settings_repository.dart';
import '../../domain/types/notification_domain_types.dart';
import '../adapters/user_notification_setting_entity_adapter.dart';
import '../datasources/get_user_notification_settings_datasource.dart';

class GetUserNotificationSettingsRepositoryImpl implements GetUserNotificationSettingsRepository {
  final GetUserNotificationSettingsDatasource _getUserNotificationSettingsDatasource;
  final UserNotificationSettingEntityAdapter _userNotificationSettingEntityAdapter;
  final ErrorLoggingService _errorLoggingService;

  const GetUserNotificationSettingsRepositoryImpl({
    required GetUserNotificationSettingsDatasource getUserNotificationSettingsDatasource,
    required UserNotificationSettingEntityAdapter userNotificationSettingEntityAdapter,
    required ErrorLoggingService errorLoggingService,
  })  : _getUserNotificationSettingsDatasource = getUserNotificationSettingsDatasource,
        _userNotificationSettingEntityAdapter = userNotificationSettingEntityAdapter,
        _errorLoggingService = errorLoggingService;

  @override
  GetUserNotificationSettingsCallback call() async {
    try {
      final userNotificationSettingModels = await _getUserNotificationSettingsDatasource.call();

      final userNotificationSettingEntities = userNotificationSettingModels.map(
        (userNotificationSettingModel) {
          return _userNotificationSettingEntityAdapter.fromModel(
            userNotificationSettingModel: userNotificationSettingModel,
          );
        },
      ).toList();

      return right(userNotificationSettingEntities);
    } catch (error, stackTrace) {
      _errorLoggingService.recordError(
        exception: error,
        stackTrace: stackTrace,
      );

      return left(const NotificationDatasourceFailure());
    }
  }
}
