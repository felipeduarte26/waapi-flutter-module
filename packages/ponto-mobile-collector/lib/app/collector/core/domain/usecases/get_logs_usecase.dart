import '../../external/drift/collector_database.dart';
import '../../infra/repositories/database/logs_repository_db_impl.dart';

abstract class GetLogsUsecase {
  Future<List<LogsTableData>> getAllLogs();
  Future<List<LogsTableData>> fetchPaginatedLogsByDateAsc({
    required int batchSize,
    required int offset,
  });
}

class GetLogsUsecaseImpl implements GetLogsUsecase {
  final LogsRepositoryDbImpl _logsRepositoryDb;

  GetLogsUsecaseImpl({
    required LogsRepositoryDbImpl logsRepositoryDb,
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
