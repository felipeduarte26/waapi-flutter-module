import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/delete_logs_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/logs_repository_db_impl.dart';

import '../../../../../mocks/logs_table_data_mock.dart';

class MockLogsRepositoryDb extends Mock implements LogsRepositoryDbImpl {}

void main() {
  late MockLogsRepositoryDb mockLogsRepositoryDb;
  late DeleteLogsUsecase deleteLogsUsecase;
  setUp(() {
    mockLogsRepositoryDb = MockLogsRepositoryDb();

    deleteLogsUsecase =
        DeleteLogsUsecaseImpl(logsRepositoryDb: mockLogsRepositoryDb);
  });
  group('deletealllogs', () {
    test('deleteAll should call deleteAll on logsRepositoryDb', () async {
      when(() => mockLogsRepositoryDb.deleteAllLogs())
          .thenAnswer((_) async => {});

      await deleteLogsUsecase.deleteAllLogs();

      verify(() => mockLogsRepositoryDb.deleteAllLogs()).called(1);
    });
  });

  group('deleteLogsByList', () {
    test('delete should call deleteLogsByList on logsRepositoryDb', () async {
      final logs = [
        logsTableDataMock,
        logsTableDataMock,
      ];

      when(() => mockLogsRepositoryDb.deleteLogsByList(logsToDelete: logs))
          .thenAnswer((_) async => {});

      await deleteLogsUsecase.deleteLogsByList(logs);

      verify(() => mockLogsRepositoryDb.deleteLogsByList(logsToDelete: logs)).called(1);
    });
  });

  group('deleteLogsOlderThen30Days', () {
    test('delete should call deleteLogsOlderThen30Days on logsRepositoryDb', () async {
      when(() => mockLogsRepositoryDb.deleteLogsOlderThen30Days(referenceDate: any(named: 'referenceDate')))
          .thenAnswer((_) async => 0);

      await deleteLogsUsecase.deleteLogsOlderThen30Days(DateTime.now());

      verify(() => mockLogsRepositoryDb.deleteLogsOlderThen30Days(referenceDate: any(named: 'referenceDate'))).called(1);
    });
  });
}
