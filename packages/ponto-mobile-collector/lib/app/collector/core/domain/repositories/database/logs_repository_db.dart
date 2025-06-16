import '../../../external/drift/collector_database.dart';
import '../../entities/crash_log.dart';

abstract class LogsRepositoryDb {
  Future<int> insert({
    required CrashLog crashLog,
  });
  Future<List<LogsTableData>> getAllLogs();

  Future<List<LogsTableData>> fetchPaginatedLogsByDateAsc({
    required int batchSize,
    required int offset,
  });

  LogsTableData convertToTable({
    required CrashLog crashLog,
  });
  
  Future<void> deleteAllLogs();

  Future<void> deleteLogsByList({
    required List<LogsTableData> logsToDelete,
  });

  Future<int> deleteLogsOlderThen30Days({
    required DateTime referenceDate,
  });
}
