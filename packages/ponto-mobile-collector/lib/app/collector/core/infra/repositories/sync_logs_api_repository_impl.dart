import '../../domain/input_model/data_source_response_dto.dart';
import '../../domain/repositories/sync_logs_api_repository.dart';
import '../datasources/sync_logs_api_datasource.dart';

class SyncLogsApiRepositoryImpl implements SyncLogsApiRepository {
  final SyncLogsApiDatasource syncLogsApiDatasource;

  SyncLogsApiRepositoryImpl({
    required this.syncLogsApiDatasource,
  });

  @override
  Future<DataSourceResponseDto> call({
    required Map<String, dynamic> jsonLogs,
  }) async {
    return syncLogsApiDatasource.call(jsonLogs: jsonLogs);
  }
}
