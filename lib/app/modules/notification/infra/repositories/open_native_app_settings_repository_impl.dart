import '../../../../core/services/error_logging/error_logging_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/notification_failure.dart';
import '../../domain/repositories/open_native_app_settings_repository.dart';
import '../../domain/types/notification_domain_types.dart';
import '../drivers/open_native_app_settings_driver.dart';

class OpenNativeAppSettingsRepositoryImpl implements OpenNativeAppSettingsRepository {
  final OpenNativeAppSettingsDriver _openNativeAppSettingsDriver;
  final ErrorLoggingService _errorLoggingService;

  const OpenNativeAppSettingsRepositoryImpl({
    required OpenNativeAppSettingsDriver openNativeAppSettingsDriver,
    required ErrorLoggingService errorLoggingService,
  })  : _openNativeAppSettingsDriver = openNativeAppSettingsDriver,
        _errorLoggingService = errorLoggingService;

  @override
  OpenNativeAppSettingsCallback call() async {
    try {
      final hasOpenNativeSettings = await _openNativeAppSettingsDriver.call();

      if (hasOpenNativeSettings) {
        return right(unit);
      }

      return left(const NotificationDriverFailure());
    } catch (error, stackTrace) {
      _errorLoggingService.recordError(
        exception: error,
        stackTrace: stackTrace,
      );

      return left(const NotificationDriverFailure());
    }
  }
}
