import '../../../../core/services/error_logging/error_logging_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/notification_failure.dart';
import '../../domain/repositories/clear_device_token_repository.dart';
import '../../domain/types/notification_domain_types.dart';
import '../datasources/clear_device_token_datasource.dart';
import '../drivers/get_last_token_saved_driver.dart';
import '../drivers/save_last_token_saved_driver.dart';

class ClearDeviceTokenRepositoryImpl implements ClearDeviceTokenRepository {
  final ClearDeviceTokenDatasource _clearDeviceTokenDatasource;
  final GetLastTokenSavedDriver _getLastTokenSavedDriver;
  final SaveLastTokenSavedDriver _saveLastTokenSavedDriver;
  final ErrorLoggingService _errorLoggingService;

  const ClearDeviceTokenRepositoryImpl({
    required ClearDeviceTokenDatasource clearDeviceTokenDatasource,
    required GetLastTokenSavedDriver getAlreadyClearTokenDriver,
    required SaveLastTokenSavedDriver saveAlreadyClearTokenDriver,
    required ErrorLoggingService errorLoggingService,
  })  : _clearDeviceTokenDatasource = clearDeviceTokenDatasource,
        _getLastTokenSavedDriver = getAlreadyClearTokenDriver,
        _saveLastTokenSavedDriver = saveAlreadyClearTokenDriver,
        _errorLoggingService = errorLoggingService;

  @override
  ClearDeviceTokenCallback call() async {
    try {
      final lastTokenSaved = _getLastTokenSavedDriver.call();

      if (lastTokenSaved == null) {
        return right(
          unit,
        );
      }

      await _clearDeviceTokenDatasource.call();

      await _saveLastTokenSavedDriver.call(
        lastTokenSaved: null,
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
