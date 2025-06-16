import '../../domain/input_model/data_source_response_dto.dart';

abstract class SyncLogsApiDatasource {
  Future<DataSourceResponseDto> call({
    required Map<String, dynamic> jsonLogs,
  });
}
