import '../../../../core/services/error_logging/error_logging_service.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/notification_failure.dart';
import '../../domain/input_models/mark_notification_as_read_input_model.dart';
import '../../domain/repositories/mark_notification_as_read_repository.dart';
import '../../domain/types/notification_domain_types.dart';
import '../datasources/mark_notification_as_read_datasource.dart';

class MarkNotificationAsReadRepositoryImpl implements MarkNotificationAsReadRepository {
  final MarkNotificationAsReadDatasource _markNotificationAsReadDatasource;
  final ErrorLoggingService _errorLoggingService;

  const MarkNotificationAsReadRepositoryImpl({
    required MarkNotificationAsReadDatasource markNotificationAsReadDatasource,
    required ErrorLoggingService errorLoggingService,
  })  : _markNotificationAsReadDatasource = markNotificationAsReadDatasource,
        _errorLoggingService = errorLoggingService;

  @override
  MarkNotificationAsReadCallback call({
    required MarkNotificationAsReadInputModel markNotificationAsReadInputModel,
  }) async {
    try {
      await _markNotificationAsReadDatasource.call(
        markNotificationAsReadInputModel: markNotificationAsReadInputModel,
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
