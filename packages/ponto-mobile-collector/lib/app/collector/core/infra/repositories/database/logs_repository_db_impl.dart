import 'package:drift/drift.dart';

import 'package:intl/intl.dart';
import '../../../domain/entities/crash_log.dart';
import '../../../domain/repositories/database/logs_repository_db.dart';
import '../../../external/drift/collector_database.dart';

class LogsRepositoryDbImpl extends LogsRepositoryDb {
  CollectorDatabase database;
  LogsRepositoryDbImpl({required this.database});

  @override
  Future<int> insert({
    required CrashLog crashLog,
  }) async {
    LogsTableData tableData = convertToTable(crashLog: crashLog);
    return database.into(database.logsTable).insert(tableData);
  }

  @override
  Future<List<LogsTableData>> getAllLogs() async {
    List<LogsTableData> result =
        await (database.select(database.logsTable)).get();
    if (result.isNotEmpty) {
      return result;
    } else {
      return <LogsTableData>[];
    }
  }

  @override
  Future<List<LogsTableData>> fetchPaginatedLogsByDateAsc({
    required int batchSize,
    required int offset,
  }) async {
    final result = await (database.select(database.logsTable)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc),
          ])
          ..limit(batchSize, offset: offset))
        .get();

    if (result.isNotEmpty) {
      return result;
    } else {
      return <LogsTableData>[];
    }
  }

  @override
  LogsTableData convertToTable({
    required CrashLog crashLog,
  }) {
    LogsTableData tableData = LogsTableData(
      id: crashLog.id,
      employeeId: crashLog.employeeId,
      createdAt: crashLog.createdAt,
      deviceId: crashLog.deviceId,
      log: crashLog.log,
      userPlatform: crashLog.userPlatform,
      employeeExternalId: crashLog.employeeId,
    );

    return tableData;
  }

  @override
  Future<void> deleteAllLogs() async {
    await database.delete(database.logsTable).go();
  }

  @override
  Future<void> deleteLogsByList({
    required List<LogsTableData> logsToDelete,
  }) async {
    for (var log in logsToDelete) {
      await (database.delete(database.logsTable)
            ..where((tbl) => tbl.id.equals(log.id)))
          .go();
    }
  }

  @override
  Future<int> deleteLogsOlderThen30Days({
    required DateTime referenceDate,
  }) async {
    final query = database.delete(database.logsTable);
    DateTime limitDate  = referenceDate.subtract(const Duration(days: 30));
    String formattedLimitDate = DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(limitDate);

    query.where((tbl) => tbl.createdAt.isSmallerThanValue(formattedLimitDate ));
    return Future.value(query.go());
  }
}
