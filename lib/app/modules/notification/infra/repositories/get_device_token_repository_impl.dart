import 'package:firebase_core/firebase_core.dart';

import '../../../../core/services/error_logging/error_logging_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/notification_failure.dart';
import '../../domain/repositories/get_device_token_repository.dart';
import '../../domain/types/notification_domain_types.dart';
import '../drivers/get_device_token_driver.dart';

class GetDeviceTokenRepositoryImpl implements GetDeviceTokenRepository {
  final GetDeviceTokenDriver _getDeviceTokenDriver;
  final ErrorLoggingService _errorLoggingService;

  const GetDeviceTokenRepositoryImpl({
    required GetDeviceTokenDriver getDeviceTokenDriver,
    required ErrorLoggingService errorLoggingService,
  })  : _getDeviceTokenDriver = getDeviceTokenDriver,
        _errorLoggingService = errorLoggingService;

  @override
  GetDeviceTokenCallback call() async {
    try {
      final deviceToken = await _getDeviceTokenDriver.call();

      return right(deviceToken!);
    } on FirebaseException catch (error, stackTrace) {
      _errorLoggingService.recordError(
        exception: error,
        stackTrace: stackTrace,
      );

      if (error.message!.contains('AUTHENTICATION_FAILED')) {
        return left(const NotificationFirebaseFailure());
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
