import '../input_model/data_source_response_dto.dart';

abstract class SyncLogsApiRepository {
  Future<DataSourceResponseDto> call({
    required Map<String, dynamic> jsonLogs,
  });
}
