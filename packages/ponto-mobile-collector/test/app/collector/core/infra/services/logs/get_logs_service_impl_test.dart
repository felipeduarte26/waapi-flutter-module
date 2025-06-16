import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/logs_repository_db.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/logs/get_logs_service_impl.dart';

import '../../../../../../mocks/logs_table_data_mock.dart';

class MockLogsRepositoryDb extends Mock implements LogsRepositoryDb {}

void main() {
  late GetLogsServiceImpl getLogsService;
  late MockLogsRepositoryDb mockLogsRepositoryDb;

  setUp(() {
    mockLogsRepositoryDb = MockLogsRepositoryDb();
    getLogsService =
        GetLogsServiceImpl(logsRepositoryDb: mockLogsRepositoryDb);
  });

  group('GetLogsServiceImpl', () {
    test('should return a list of LogsTableData from LogsRepositoryDb',
        () async {
      final logsList = [logsTableDataMock];
      when(() => mockLogsRepositoryDb.getAllLogs())
          .thenAnswer((_) async => logsList);

      final result = await getLogsService.getAllLogs();

      expect(result, logsList);
      verify(() => mockLogsRepositoryDb.getAllLogs()).called(1);
    });

    test('should return a list of LogsTableData from LogsRepositoryDb when fetchPaginatedLogsByDateAsc is called',
        () async {
      final logsList = [logsTableDataMock];
      when(() => mockLogsRepositoryDb.fetchPaginatedLogsByDateAsc(batchSize: any(named: 'batchSize'), offset: any(named: 'offset')))
          .thenAnswer((_) async => logsList);

      final result = await getLogsService.fetchPaginatedLogsByDateAsc(batchSize: 100, offset: 0);

      expect(result, logsList);
      verify(() => mockLogsRepositoryDb.fetchPaginatedLogsByDateAsc(batchSize: any(named: 'batchSize'), offset: any(named: 'offset'))).called(1);
    });
  });
}
