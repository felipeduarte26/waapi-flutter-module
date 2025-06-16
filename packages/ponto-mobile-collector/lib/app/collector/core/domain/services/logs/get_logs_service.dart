import '../../../external/drift/collector_database.dart';

abstract class GetLogsService {
  Future<List<LogsTableData>> getAllLogs();
  Future<List<LogsTableData>> fetchPaginatedLogsByDateAsc({
    required int batchSize,
    required int offset,
  });
}
