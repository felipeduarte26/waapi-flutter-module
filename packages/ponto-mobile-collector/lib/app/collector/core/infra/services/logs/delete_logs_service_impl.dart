import '../../../domain/repositories/database/logs_repository_db.dart';
import '../../../domain/services/logs/delete_logs_service.dart';
import '../../../external/drift/collector_database.dart';

class DeleteLogsServiceImpl implements DeleteLogsService {
  final LogsRepositoryDb _logsRepositoryDb;

  DeleteLogsServiceImpl({
    required LogsRepositoryDb logsRepositoryDb,
  }) : _logsRepositoryDb = logsRepositoryDb;

  @override
  Future<void> deleteAllLogs() async {
    await _logsRepositoryDb.deleteAllLogs();
  }

  @override
  Future<void> deleteLogsByList(List<LogsTableData> logsToDelete) async {
    await _logsRepositoryDb.deleteLogsByList(logsToDelete: logsToDelete);
  }

  @override
  Future<int> deleteLogsOlderThen30Days(DateTime referenceDate) async {
    return await _logsRepositoryDb.deleteLogsOlderThen30Days(referenceDate: referenceDate);
  }
}
