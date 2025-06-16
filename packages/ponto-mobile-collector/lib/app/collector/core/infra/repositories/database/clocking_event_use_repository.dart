import '../../../domain/entities/clocking_event_use.dart';
import '../../../domain/enums/clocking_event_use_type.dart';
import '../../../domain/repositories/database/clocking_event_use_repository.dart';
import '../../../external/drift/collector_database.dart';

class ClockingEventUseRepositoryImpl implements ClockingEventUseRepository {
  CollectorDatabase database;

  ClockingEventUseRepositoryImpl({required this.database});

  @override
  Future<bool> exist({
    required String employeeId,
    required String clockingType,
  }) async {
    final query = database.select(database.clockingEventUseTable);
    query.where((tbl) => tbl.employeeId.equals(employeeId));
    query.where((tbl) => tbl.clockingEventUseType.equals(clockingType));
    List<ClockingEventUseTableData> tableData = await query.get();
    return tableData.isNotEmpty;
  }

  @override
  Future<int> insert({
    required ClockingEventUse clocking,
    required String employeeId,
  }) async {
    ClockingEventUseTableData tableData =
        convertToTable(clocking: clocking, employeeId: employeeId);
    return database.into(database.clockingEventUseTable).insert(tableData);
  }

  @override
  Future<bool> update({
    required ClockingEventUse clocking,
    required String employeeId,
  }) async {
    ClockingEventUseTableData tableData =
        convertToTable(clocking: clocking, employeeId: employeeId);
    return database.update(database.clockingEventUseTable).replace(tableData);
  }

  @override
  Future<bool> save({
    required ClockingEventUse clocking,
    required String employeeId,
  }) async {
    if (await exist(
      employeeId: employeeId,
      clockingType: clocking.clockingEventUseType.value,
    )) {
      await update(clocking: clocking, employeeId: employeeId);
    } else {
      await insert(clocking: clocking, employeeId: employeeId);
    }

    return true;
  }

  @override
  Future<List<ClockingEventUse>> findAllByEmployeeId({
    required String employeeId,
  }) async {
    final query = database.select(database.clockingEventUseTable);
    query.where((tbl) => tbl.employeeId.equals(employeeId));
    List<ClockingEventUseTableData> tableDatas = await query.get();

    List<ClockingEventUse> clockings = [];
    for (ClockingEventUseTableData clocking in tableDatas) {
      clockings.add(convertToDto(tableData: clocking, employeeId: employeeId));
    }

    return clockings;
  }

  @override
  Future<ClockingEventUse?> findByEmployeeIdAndClockingEventUseType({
    required String employeeId,
    required ClockingEventUseType clockingEventUseType,
  }) async {
    final query = database.select(database.clockingEventUseTable)
      ..where(
        (tbl) => tbl.employeeId.equals(employeeId),
      )
      ..where(
        (tbl) => tbl.clockingEventUseType.equals(clockingEventUseType.value),
      )
      ..limit(1);

    final tableDatas = await query.get();

    if (tableDatas.isEmpty) {
      return null;
    }

    return convertToDto(
      tableData: tableDatas[0],
      employeeId: employeeId,
    );
  }

  @override
  Future<int> deleteByEmployeeId({required String employeeId}) async {
    return (database.delete(database.clockingEventUseTable)
          ..where((tbl) => tbl.employeeId.equals(employeeId)))
        .go();
  }

  @override
  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  }) async {
    final query = database.delete(database.clockingEventUseTable);
    query.where((tbl) => tbl.employeeId.isIn(employeeIds));

    await query.go();
  }

  ClockingEventUseTableData convertToTable({
    required ClockingEventUse clocking,
    required String employeeId,
  }) {
    ClockingEventUseTableData tableData = ClockingEventUseTableData(
      employeeId: employeeId,
      description: clocking.description,
      code: clocking.code,
      clockingEventUseType: clocking.clockingEventUseType.value,
    );

    return tableData;
  }

  ClockingEventUse convertToDto({
    required ClockingEventUseTableData tableData,
    required String employeeId,
  }) {
    ClockingEventUse clocking = ClockingEventUse(
      employeeId: employeeId,
      description: tableData.description,
      code: tableData.code,
      clockingEventUseType:
          ClockingEventUseType.build(tableData.clockingEventUseType),
    );

    return clocking;
  }
}
