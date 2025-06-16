import '../../input_model/data_source_response_dto.dart';

abstract class SyncLogsApiService {
  Future<DataSourceResponseDto> syncLogsApi({
    required Map<String, dynamic> jsonLogs,
  });
}
