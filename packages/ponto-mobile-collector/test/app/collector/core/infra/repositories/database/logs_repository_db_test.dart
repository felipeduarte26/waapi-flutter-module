import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/crash_log.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/logs_repository_db_impl.dart';

import '../../../../../../mocks/crash_log_mock.dart';

void main() {
  late CollectorDatabase database;
  late LogsRepositoryDbImpl logsRepositoryDb;

  LazyDatabase openConnection() {
    return LazyDatabase(
      () async {
        return NativeDatabase.memory(logStatements: false);
      },
    );
  }

  setUp(
    () {
      database = CollectorDatabase(
        database: openConnection(),
      );

      logsRepositoryDb = LogsRepositoryDbImpl(database: database);
    },
  );
  tearDown(
    () async {
      await database.close();
    },
  );

  group('convertToTable', () {
    test('should convert CrashLog to LogsTableData', () {
      final crashLog = crashLogMock;

      final tableData = logsRepositoryDb.convertToTable(crashLog: crashLog);

      expect(tableData.employeeId, crashLog.employeeId);
      expect(tableData.createdAt, crashLog.createdAt);
      expect(tableData.deviceId, crashLog.deviceId);
      expect(tableData.log, crashLog.log);
      expect(tableData.userPlatform, crashLog.userPlatform);
      expect(tableData.employeeExternalId, crashLog.employeeId);
    });
  });

  group('select', () {
    test('should return fetchPaginatedLogsByDateAsc logs', () async {
      CrashLog crashLog1 = CrashLog(
        id: '1',
        createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(DateTime.now()),
        deviceId: '1234567890',
        userPlatform: '76846435645',
        employeeId: '62342362354324',
        employeeExternalId: '62342362354324',
        log: 'Test log 1',
      );

      CrashLog crashLog2 = CrashLog(
        id: '2',
        createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(DateTime.now()),
        deviceId: '1234567890',
        userPlatform: '76846435645',
        employeeId: '62342362354324',
        employeeExternalId: '62342362354324',
        log: 'Test log 1',
      );


      final tableData = logsRepositoryDb.convertToTable(crashLog: crashLog1);

      await logsRepositoryDb.insert(crashLog: crashLog1);
      await logsRepositoryDb.insert(crashLog: crashLog2);

      final result = await logsRepositoryDb.fetchPaginatedLogsByDateAsc(batchSize: 1, offset: 0);

      expect(result.length, 1);
      expect(result.first.employeeId, tableData.employeeId);
      expect(result.first.createdAt, tableData.createdAt);
      expect(result.first.deviceId, tableData.deviceId);
      expect(result.first.log, tableData.log);
      expect(result.first.userPlatform, tableData.userPlatform);
      expect(result.first.employeeExternalId, tableData.employeeExternalId);
    });

    test('should return fetchPaginatedLogsByDateAsc logs', () async {
      CrashLog crashLog1 = CrashLog(
        id: '1',
        createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(DateTime.now()),
        deviceId: '1234567890',
        userPlatform: '76846435645',
        employeeId: '62342362354324',
        employeeExternalId: '62342362354324',
        log: 'Test log 1',
      );

      CrashLog crashLog2 = CrashLog(
        id: '2',
        createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(DateTime.now()),
        deviceId: '1234567890',
        userPlatform: '76846435645',
        employeeId: '62342362354324',
        employeeExternalId: '62342362354324',
        log: 'Test log 1',
      );


      final tableData = logsRepositoryDb.convertToTable(crashLog: crashLog2);

      await logsRepositoryDb.insert(crashLog: crashLog1);
      await logsRepositoryDb.insert(crashLog: crashLog2);

      final result = await logsRepositoryDb.fetchPaginatedLogsByDateAsc(batchSize: 1, offset: 1);

      expect(result.length, 1);
      expect(result.first.employeeId, tableData.employeeId);
      expect(result.first.createdAt, tableData.createdAt);
      expect(result.first.deviceId, tableData.deviceId);
      expect(result.first.log, tableData.log);
      expect(result.first.userPlatform, tableData.userPlatform);
      expect(result.first.employeeExternalId, tableData.employeeExternalId);
    });
  });

  group('delete', () {
    test('should deleteLogsByList', () async {
      CrashLog crashLog1 = CrashLog(
        id: '1',
        createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(DateTime.now()),
        deviceId: '1234567890',
        userPlatform: '76846435645',
        employeeId: '62342362354324',
        employeeExternalId: '62342362354324',
        log: 'Test log 1',
      );

      CrashLog crashLog2 = CrashLog(
        id: '2',
        createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(DateTime.now()),
        deviceId: '1234567890',
        userPlatform: '76846435645',
        employeeId: '62342362354324',
        employeeExternalId: '62342362354324',
        log: 'Test log 1',
      );


      await logsRepositoryDb.insert(crashLog: crashLog1);
      await logsRepositoryDb.insert(crashLog: crashLog2);

      List<LogsTableData> tableData = [];
      tableData.add(logsRepositoryDb.convertToTable(crashLog: crashLog1));

      await logsRepositoryDb.deleteLogsByList(logsToDelete: tableData);

      final result = await logsRepositoryDb.getAllLogs();

      expect(result.length, 1);
    });

    test('should delete logs by list', () async {
      CrashLog crashLog1 = CrashLog(
        id: '1',
        createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(DateTime(2021, 2, 10)),
        deviceId: '1234567890',
        userPlatform: '76846435645',
        employeeId: '62342362354324',
        employeeExternalId: '62342362354324',
        log: 'Test log 1',
      );

      CrashLog crashLog2 = CrashLog(
        id: '2',
        createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(DateTime(2021, 1, 1)),
        deviceId: '1234567890',
        userPlatform: '76846435645',
        employeeId: '62342362354324',
        employeeExternalId: '62342362354324',
        log: 'Test log 1',
      );

      await logsRepositoryDb.insert(crashLog: crashLog1);
      await logsRepositoryDb.insert(crashLog: crashLog2);

      await logsRepositoryDb.deleteLogsOlderThen30Days(referenceDate: DateTime(2021, 2, 10));

      final result = await logsRepositoryDb.getAllLogs();
      expect(result.length, 1);
    });
  });
}
