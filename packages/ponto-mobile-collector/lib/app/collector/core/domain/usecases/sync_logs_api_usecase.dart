import 'dart:convert';

import '../../external/drift/collector_database.dart';
import '../../infra/utils/iutils.dart';
import '../input_model/data_source_response_dto.dart';
import '../services/logs/delete_logs_service.dart';
import '../services/logs/sync_logs_api_service.dart';

abstract class SyncLogsApiUsecase {
  Future<DataSourceResponseDto> call({required List<LogsTableData> listLogs});
}

class SyncLogsApiUsecaseImpl implements SyncLogsApiUsecase {
  final SyncLogsApiService _syncLogsApiService;
  final DeleteLogsService _deleteLogsService;
  final IUtils _utils;

  SyncLogsApiUsecaseImpl({
    required SyncLogsApiService syncLogsApiService,
    required IUtils utils,
    required DeleteLogsService deleteLogsService,
  })  : _syncLogsApiService = syncLogsApiService,
        _utils = utils,
        _deleteLogsService = deleteLogsService;

  @override
  Future<DataSourceResponseDto> call({
    required List<LogsTableData> listLogs,
  }) async {

    Map<String, dynamic> jsonMap = {
      'entities': listLogs.map((log) {
        return _truncateLog(log);
      }).toList(),
    };

    DataSourceResponseDto response =
        await _syncLogsApiService.syncLogsApi(jsonLogs: jsonMap);

    if (response.success) {
      await _deleteLogsService.deleteLogsByList(listLogs);
    }
    return response;
  }

  LogsTableData _truncateLog(LogsTableData log) {
    var logMap = log.toJson();
    var logjson = jsonEncode(logMap);

    if (logjson.length > 4000) {
      logMap['log'] = _utils.truncateString(
        logMap['log'],
        4000 - (logjson.length - logMap['log'].length).toInt(),
      );
    }

    return LogsTableData.fromJson(logMap);
  }
}
