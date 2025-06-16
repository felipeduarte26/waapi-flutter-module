import '../../../domain/input_model/data_source_response_dto.dart';
import '../../../domain/repositories/sync_logs_api_repository.dart';
import '../../../domain/services/logs/sync_logs_api_service.dart';

class SyncLogsApiServiceImpl implements SyncLogsApiService {
  SyncLogsApiRepository syncLogsApiRepository;
  SyncLogsApiServiceImpl({
    required this.syncLogsApiRepository,
  });

  @override
  Future<DataSourceResponseDto> syncLogsApi({
    required Map<String, dynamic> jsonLogs,
  }) async {
    return await syncLogsApiRepository.call(jsonLogs: jsonLogs);
  }
}
