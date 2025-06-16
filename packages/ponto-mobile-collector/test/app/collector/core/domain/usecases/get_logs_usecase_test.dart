import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_logs_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/logs_repository_db_impl.dart';

import '../../../../../mocks/logs_table_data_mock.dart';

class MockLogsRepositoryDb extends Mock implements LogsRepositoryDbImpl {}

void main() {
  late MockLogsRepositoryDb mockLogsRepositoryDb;
  late GetLogsUsecase getLogsUsecase;
  setUp(() {
    mockLogsRepositoryDb = MockLogsRepositoryDb();

    getLogsUsecase =
        GetLogsUsecaseImpl(logsRepositoryDb: mockLogsRepositoryDb);
  });
  group('get all logs', () {
    test('getAllLogs should return all logs from logsRepositoryDb', () async {
      final logs = [logsTableDataMock];
      when(() => mockLogsRepositoryDb.getAllLogs())
          .thenAnswer((_) async => logs);

      final result = await getLogsUsecase.getAllLogs();

      expect(result, logs);
      verify(() => mockLogsRepositoryDb.getAllLogs()).called(1);
    });
  });

  group('get fetchPaginatedLogsByDateAsc logs', () {
    test('fetchPaginatedLogsByDateAsc should return logs from logsRepositoryDb', () async {
      final logs = [
        logsTableDataMock,
        logsTableDataMock,
      ];
      when(() => mockLogsRepositoryDb.fetchPaginatedLogsByDateAsc(batchSize: 2, offset: 0))
          .thenAnswer((_) async => logs);

      final result = await getLogsUsecase.fetchPaginatedLogsByDateAsc(batchSize: 2, offset: 0);

      expect(result, logs);
      verify(() => mockLogsRepositoryDb.fetchPaginatedLogsByDateAsc(batchSize: 2, offset: 0)).called(1);
    });
  });
}
