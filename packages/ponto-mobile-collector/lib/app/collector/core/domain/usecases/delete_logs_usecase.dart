import '../../external/drift/collector_database.dart';
import '../../infra/repositories/database/logs_repository_db_impl.dart';

abstract class DeleteLogsUsecase {
  Future<void> deleteAllLogs();
  Future<void> deleteLogsByList(List<LogsTableData> logsToDelete);
  Future<int> deleteLogsOlderThen30Days(DateTime referenceDat);
}

class DeleteLogsUsecaseImpl implements DeleteLogsUsecase {
  final LogsRepositoryDbImpl _logsRepositoryDb;

  DeleteLogsUsecaseImpl({
    required LogsRepositoryDbImpl logsRepositoryDb,
  }) : _logsRepositoryDb = logsRepositoryDb;

  @override
  Future<void> deleteAllLogs() {
    return _logsRepositoryDb.deleteAllLogs();
  }

  @override
  Future<void> deleteLogsByList(List<LogsTableData> logsToDelete) {
    return _logsRepositoryDb.deleteLogsByList(logsToDelete: logsToDelete);
  }

  @override
  Future<int> deleteLogsOlderThen30Days(DateTime referenceDate) {
    return _logsRepositoryDb.deleteLogsOlderThen30Days(referenceDate: referenceDate);
  }
}
