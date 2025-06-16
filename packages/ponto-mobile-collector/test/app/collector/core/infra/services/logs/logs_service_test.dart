import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/data_source_response_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/sync_logs_api_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/logs_repository_db_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/logs/send_logs_service_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/logs/sync_logs_api_service_impl.dart';

import '../../../../../../mocks/crash_log_mock.dart';

class MockLogsRepositoryDb extends Mock implements LogsRepositoryDbImpl {}

class MockSyncLogsApiRepository extends Mock implements SyncLogsApiRepository {}

void main() {
  late MockLogsRepositoryDb mockLogsRepositoryDb;
  late MockSyncLogsApiRepository mockSyncLogsApiRepository;
  late SendLogsServiceImpl sendLogsService;

  late SyncLogsApiServiceImpl mockSyncLogsApiService;

  setUp(() {
    mockLogsRepositoryDb = MockLogsRepositoryDb();
    mockSyncLogsApiRepository = MockSyncLogsApiRepository();
    sendLogsService = SendLogsServiceImpl(
      logsRepositoryDb: mockLogsRepositoryDb,
      logsRepository: mockSyncLogsApiRepository,
    );
    mockSyncLogsApiService = SyncLogsApiServiceImpl(
      syncLogsApiRepository: mockSyncLogsApiRepository,
    );
  });

  group('LogsService', () {
    test('sendLog should call insert on logsRepositoryDb', () async {
      when(() => mockLogsRepositoryDb.insert(crashLog: crashLogMock))
          .thenAnswer((_) async => 11);

      await sendLogsService.sendLog(crashLog: crashLogMock);

      verify(() => mockLogsRepositoryDb.insert(crashLog: crashLogMock))
          .called(1);
    });

    test('syncLogsApi should call logsRepository and return the result',
        () async {
      var dataResponse =
          DataSourceResponseDto(success: true, message: 'succes');
      final jsonLogs = {'key': 'value'};
      when(() => mockSyncLogsApiRepository.call(jsonLogs: jsonLogs))
          .thenAnswer((_) async => dataResponse);

      final result =
          await mockSyncLogsApiService.syncLogsApi(jsonLogs: jsonLogs);

      expect(result, dataResponse);
      verify(() => mockSyncLogsApiRepository.call(jsonLogs: jsonLogs))
          .called(1);
    });
  });
}
