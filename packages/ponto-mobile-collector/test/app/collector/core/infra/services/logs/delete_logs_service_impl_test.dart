import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/logs_repository_db.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/logs/delete_logs_service_impl.dart';

import '../../../../../../mocks/logs_table_data_mock.dart';

class MockLogsRepositoryDb extends Mock implements LogsRepositoryDb {}

void main() {
  late DeleteLogsServiceImpl deleteLogsService;
  late MockLogsRepositoryDb mockLogsRepositoryDb;
  group('DeleteLogsServiceImpl', () {
    setUp(() {
      mockLogsRepositoryDb = MockLogsRepositoryDb();
      deleteLogsService =
          DeleteLogsServiceImpl(logsRepositoryDb: mockLogsRepositoryDb);
    });
    test('should call deleteAllLogs on LogsRepositoryDb', () async {
      when(() => mockLogsRepositoryDb.deleteAllLogs())
          .thenAnswer((_) async => {});

      await deleteLogsService.deleteAllLogs();

      verify(() => mockLogsRepositoryDb.deleteAllLogs()).called(1);
    });

    test('should call deleteLogsByList on LogsRepositoryDb', () async {
      final logs = [
        logsTableDataMock,
        logsTableDataMock,
      ];
      
      when(() => mockLogsRepositoryDb.deleteLogsByList(logsToDelete: any(named: 'logsToDelete')))
          .thenAnswer((_) async => {});

      await deleteLogsService.deleteLogsByList(logs);

      verify(() => mockLogsRepositoryDb.deleteLogsByList(logsToDelete: any(named: 'logsToDelete'))).called(1);
    });

    test('should call deleteLogsOlderThen30Days on LogsRepositoryDb', () async {
      when(() => mockLogsRepositoryDb.deleteLogsOlderThen30Days(referenceDate: any(named: 'referenceDate')))
          .thenAnswer((_) async => 0);

      await deleteLogsService.deleteLogsOlderThen30Days(DateTime.now());

      verify(() => mockLogsRepositoryDb.deleteLogsOlderThen30Days(referenceDate: any(named: 'referenceDate'))).called(1);
    });
  });
}
