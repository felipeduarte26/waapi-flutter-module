import '../../../../core/services/error_logging/error_logging_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/notification_failure.dart';
import '../../domain/repositories/register_device_token_repository.dart';
import '../../domain/types/notification_domain_types.dart';
import '../datasources/register_device_token_datasource.dart';
import '../drivers/save_last_token_saved_driver.dart';

class RegisterDeviceTokenRepositoryImpl implements RegisterDeviceTokenRepository {
  final RegisterDeviceTokenDatasource _registerDeviceTokenDatasource;
  final SaveLastTokenSavedDriver _saveLastTokenSavedDriver;
  final ErrorLoggingService _errorLoggingService;

  const RegisterDeviceTokenRepositoryImpl({
    required RegisterDeviceTokenDatasource registerDeviceTokenDatasource,
    required SaveLastTokenSavedDriver saveAlreadyClearTokenDriver,
    required ErrorLoggingService errorLoggingService,
  })  : _registerDeviceTokenDatasource = registerDeviceTokenDatasource,
        _saveLastTokenSavedDriver = saveAlreadyClearTokenDriver,
        _errorLoggingService = errorLoggingService;

  @override
  RegisterDeviceTokenCallback call({
    required String token,
  }) async {
    try {
      await _registerDeviceTokenDatasource.call(
        deviceToken: token,
      );

      await _saveLastTokenSavedDriver.call(
        lastTokenSaved: token,
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
