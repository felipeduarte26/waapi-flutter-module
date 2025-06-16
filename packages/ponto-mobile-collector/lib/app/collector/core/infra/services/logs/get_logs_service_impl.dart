import '../../../domain/repositories/database/logs_repository_db.dart';
import '../../../domain/services/logs/get_logs_service.dart';
import '../../../external/drift/collector_database.dart';

class GetLogsServiceImpl implements GetLogsService {
  final LogsRepositoryDb _logsRepositoryDb;

  GetLogsServiceImpl({
    required LogsRepositoryDb logsRepositoryDb,
  }) : _logsRepositoryDb = logsRepositoryDb;

  @override
  Future<List<LogsTableData>> getAllLogs() async {
    return await _logsRepositoryDb.getAllLogs();
  }

  @override
  Future<List<LogsTableData>> fetchPaginatedLogsByDateAsc({
    required int batchSize,
    required int offset,
  }) async {
    return await _logsRepositoryDb.fetchPaginatedLogsByDateAsc(batchSize: batchSize, offset: offset);
  }
}
