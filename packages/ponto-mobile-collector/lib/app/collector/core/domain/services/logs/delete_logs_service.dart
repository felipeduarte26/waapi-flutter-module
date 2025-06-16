import '../../../external/drift/collector_database.dart';

abstract class DeleteLogsService {
  Future<void> deleteAllLogs();
  Future<void> deleteLogsByList(List<LogsTableData> logsToDelete);
  Future<int> deleteLogsOlderThen30Days(DateTime referenceDate);
}
