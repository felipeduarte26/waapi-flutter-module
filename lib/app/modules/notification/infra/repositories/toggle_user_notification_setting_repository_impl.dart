import '../../../../core/enums/analytics/analytics_event_enum.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../../../core/services/analytics/analytics_service.dart';
import '../../../../core/services/error_logging/error_logging_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/notification_failure.dart';
import '../../domain/input_models/toggle_notification_setting_input_model.dart';
import '../../domain/repositories/toggle_user_notification_setting_repository.dart';
import '../../domain/types/notification_domain_types.dart';
import '../datasources/toggle_user_notification_setting_datasource.dart';

class ToggleUserNotificationSettingRepositoryImpl implements ToggleUserNotificationSettingRepository {
  final ToggleUserNotificationSettingDatasource _toggleUserNotificationSettingDatasource;
  final ErrorLoggingService _errorLoggingService;
  final AnalyticsService _analyticsService;

  const ToggleUserNotificationSettingRepositoryImpl({
    required ToggleUserNotificationSettingDatasource toggleUserNotificationSettingDatasource,
    required ErrorLoggingService errorLoggingService,
    required AnalyticsService analyticsService,
  })  : _toggleUserNotificationSettingDatasource = toggleUserNotificationSettingDatasource,
        _errorLoggingService = errorLoggingService,
        _analyticsService = analyticsService;

  @override
  ToggleUserNotificationSettingCallback call({
    required ToggleNotificationSettingInputModel toggleNotificationSettingInputModel,
  }) async {
    try {
      await _toggleUserNotificationSettingDatasource.call(
        toggleNotificationSettingInputModel: toggleNotificationSettingInputModel,
      );

      await _analyticsService.logEvent(
        analyticsEventEnum: AnalyticsEventEnum.notificationSettingsChanged,
        parameters: {
          'notificationType': EnumHelper()
              .enumToString(
                enumToParse: toggleNotificationSettingInputModel.notificationType,
              )
              .toLowerCase(),
          'value': toggleNotificationSettingInputModel.notificationEnabled,
        },
      );

      return right(unit);
    } catch (error, stackTrace) {
      _errorLoggingService.recordError(
        exception: error,
        stackTrace: stackTrace,
      );

      return left(const NotificationDatasourceFailure());
    }
  }
}
