import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/data_source_response_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/sync_logs_api_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/logs/delete_logs_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/logs/get_logs_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/sync_logs_api_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/logs/sync_logs_api_service_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/iutils.dart';

import '../../../../../mocks/logs_table_data_mock.dart';

class MockSyncLogsApiRepository extends Mock implements SyncLogsApiRepository {}

class MockGetLogsService extends Mock implements GetLogsService {}

class MockDeleteLogsService extends Mock implements DeleteLogsService {}

class MockUtils extends Mock implements IUtils {}

void main() {
  late SyncLogsApiUsecase syncLogsApiUsecase;
  late MockSyncLogsApiRepository mockSyncLogsApiRepository;
  late SyncLogsApiServiceImpl mockSyncLogsApiService;
  late DeleteLogsService mockDeleteLogsService;

  late MockUtils mockUtils;
  setUp(() {
    mockUtils = MockUtils();
  });
  group('Sync logs api', () {
    setUp(() {
      mockSyncLogsApiRepository = MockSyncLogsApiRepository();
      mockDeleteLogsService = MockDeleteLogsService();

      mockSyncLogsApiService = SyncLogsApiServiceImpl(
        syncLogsApiRepository: mockSyncLogsApiRepository,
      );
      syncLogsApiUsecase = SyncLogsApiUsecaseImpl(
        deleteLogsService: mockDeleteLogsService,
        syncLogsApiService: mockSyncLogsApiService,
        utils: mockUtils,
      );
    });
    test('syncLogsApi method should sync logs on success', () async {
      final logs = [
        logsTableDataMock,
        logsTableDataMock,
      ];
      final jsonMap = {
        'entities': logs.map((log) {
          return LogsTableData.fromJson(log.toJson());
        }).toList(),
      };

      when(() => mockDeleteLogsService.deleteLogsByList(logs))
          .thenAnswer((_) async => {});
      when(() => mockSyncLogsApiRepository.call(jsonLogs: jsonMap)).thenAnswer(
        (_) async => DataSourceResponseDto(success: true, message: 'success'),
      );

      await syncLogsApiUsecase.call(listLogs: logs);

      verify(() => mockSyncLogsApiRepository.call(jsonLogs: jsonMap)).called(1);
    });
  });

  test('should truncate log if JSON exceeds 4000 characters', () {
    String truncatedLog = 'a' * 4000;
    LogsTableData log = LogsTableData(
      id: '74559473-91b4-46d5-9b5a-53db70a3ae45',
      createdAt: '2024-08-01 18:37:56.000',
      log: truncatedLog,
      deviceId: '12345678',
      employeeExternalId: '1234567890',
      employeeId: '1234567890',
      userPlatform: '098765',
    );

    when(() => mockUtils.truncateString(any(), any())).thenReturn(truncatedLog);

    final logMap = log.toJson();
    final logjson = jsonEncode(logMap);

    if (logjson.length > 4000) {
      logMap['log'] = mockUtils.truncateString(
        logMap['log'],
        4000 - (logjson.length - logMap['log'].length).toInt(),
      );
    }

    expect(logMap['log'], truncatedLog);
    verify(() => mockUtils.truncateString(any(), any())).called(1);
  });

  test('should not truncate log if JSON is within 4000 characters', () {
    final log = logsTableDataMock;
    final logMap = log.toJson();
    final logjson = jsonEncode(logMap);

    if (logjson.length > 4000) {
      logMap['log'] = mockUtils.truncateString(
        logMap['log'],
        4000 - (logjson.length - logMap['log'].length).toInt(),
      );
    }

    expect(logMap['log'], log.log);
    verifyNever(() => mockUtils.truncateString(any(), any()));
  });
}
